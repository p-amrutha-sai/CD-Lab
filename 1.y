%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
FILE *yyout1;
FILE *yyout2;

int yylex();
void yyerror(const char *s);

int a = 1;

#define MAX 1000
#define LNE "------------------------------------------------------------"

char stack[MAX][MAX] = {"$"};
int top = 1;
char input[MAX];
char s_action[MAX];

void push(char v[], char u[]) {
	char s[MAX] = "";

    	for(int i = 0; i < top; i++) {
		strcat(s, stack[i]);
		strcat(s, " ");
	}
	
	strcpy(stack[top++], v);
	strcat(input, u);
	strcat(input, " ");
	strcpy(s_action, u);

	fprintf(yyout2, "%-60s| %-59s| Shift\t %-53s\n", s, input, s_action);
}

void function(char lhs[], int count, char rule1[], char rule2[]) {
	fprintf(yyout1, "%-15s-> %s\n", rule1, rule2);
	
	char s[MAX] = "";
	top -= count;
	strcpy(stack[top++], lhs);

	for(int i = 0; i < top; i++) {
		strcat(s, stack[i]);
		strcat(s, " ");
	}

	fprintf(yyout2, "%-60s| %-59s| Reduce\t %-15s-> %s\n", s, input, rule1, rule2);
}
%}

%union { char str[1000]; }

%token INT FLOAT CHAR WHILE LTE GTE EQT NEQ ID NUMBER

%start Program

%%

Program 	: StatList
			{
				function("Program", 1, "Program", "StatementList");
				fprintf(yyout2, "%-60s| %-59s| %-59s\n", "$ Program", "$", "Accept");
			}
    		;

StatList	: StatList Statement	{ function("StatementList", 2, "StatementList", "StatementList Statement"); }
    		| Statement		{ function("StatementList", 1, "StatementList", "Statement"); }
    		;

Statement 	: Declaration		{ function("Statement", 1, "Statement", "Declaration"); }
		| Assignment		{ function("Statement", 1, "Statement", "Assignment"); }
		| WhileStatement 	{ function("Statement", 1, "Statement", "WhileStatement"); }
		| CompStatement		{ function("Statement", 1, "Statement", "CompoundStatement"); }
   		;

Declaration	: Type ID ';' 		{ function("Declaration", 3, "Declaration", "Type ID ;"); }
		;

Type		: INT			{ function("Type", 1, "Type", "int"); }
    		| FLOAT			{ function("Type", 1, "Type", "float"); }
		| CHAR			{ function("Type", 1, "Type", "char"); }
    		;

Assignment 	: ID '=' E ';'		{ function("Assignment", 4, "Assignment", "ID = E ;"); }
  		;

E 		: E '+' T		{ function("E", 3, "Expression", "E + T"); }
    		| E '-' T		{ function("E", 3, "Expression", "E - T"); }
    		| T			{ function("E", 1, "Expression", "T"); }
    		;

T 		: T '*' F		{ function("E", 3, "Term", "T * F"); }
    		| T '/' F 		{ function("E", 3, "Term", "T / F"); }
		| F 			{ function("E", 1, "Term", "F"); }
    		;

F 		: '(' E ')' 		{ function("E", 3, "Factor", "( E )"); }
    		| ID			{ function("E", 1, "Factor", "ID"); }
		| NUMBER		{ function("E", 1, "Factor", "NUMBER"); }
    		;

WhileStatement	: WHILE '(' Condition ')' Statement
					{ function("WhileStatement", 5, "WhileStatement", "while ( Condition ) Statement"); }
    		;

Condition 	: E '<' E		{ function("Condition", 3, "Condition", "E < E"); }
		| E '>' E 		{ function("Condition", 3, "Condition", "E > E"); }
		| E LTE E 		{ function("Condition", 3, "Condition", "E <= E"); }
		| E GTE E 		{ function("Condition", 3, "Condition", "E >= E"); }
		| E EQT E 		{ function("Condition", 3, "Condition", "E == E"); }
		| E NEQ E 		{ function("Condition", 3, "Condition", "E != E"); }
		;

CompStatement	: '{' StatList '}' 	{ function("WhileStatement", 3, "CompStatement", "{ StatementList }"); }
		;

%%

void yyerror(const char *s) {
	printf("Syntax Error: %s\n", s);
}

int main(){
	yyin = fopen("inp.txt", "r");
	if(!yyin){
		printf("Couldn't find file: inp.txt\n");
		return 1;
	}
	
	yyout1 = fopen("production_rules.txt", "w");
	if(!yyout1){
		printf("Couldn't find file: production_rules.txt\n");
		return 1;
	}

	yyout2 = fopen("sr_parse_table.txt", "w");
	if(!yyout2){
		printf("Couldn't find file: sr_parse_table.txt\n");
		return 1;
	}
	
	fprintf(yyout2, "%-60s| %-59s| %-59s\n", "Stack", "Input", "Action");
    	fprintf(yyout2, "%s|%s|%s\n", LNE, LNE, LNE);
	
	yyparse();
	
	fclose(yyin);
	fclose(yyout1);
	fclose(yyout2);
	
	printf("Parsing Completed.\n");
	
	return 0;
}
