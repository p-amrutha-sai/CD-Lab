%{
#include <string.h>
#include "y.tab.h"

#define MAX 1000
extern void push(char v[], char u[]);
extern int ipos;
%}

%%

"int"	{
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return INT;
	}
"float"	{
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return FLOAT;
	}
"char"	{
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return CHAR;
	}
"while"	{ 
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return WHILE;
	}
"+"	{
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return '+';
	}
"-"	{
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return '-';
	}
"*"	{
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return '*';
	}
"/"	{
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return '/';
	}
"="	{ 
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return '=';
	}
"<"	{ 
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return '<'; 
	}
">"	{ 
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return '>';
	}
"<="	{ 
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return LTE;
	}
">="	{ 
		strcpy(yylval.str, yytext);
		push(yylval.str, yytext);
		return GTE;
	}
"=="	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return EQT; 
	}
"!="	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return NEQ; 
	}
"("	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return '('; 
	}
")"	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return ')'; 
	}
"["	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return '['; 
	}
"]"	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return ']'; 
	}
"{"	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return '{'; 
	}
"}"	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return '}'; 
	}
";"	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return ';'; 
	}
[0-9]+(\.[0-9]+)?	{ 
				strcpy(yylval.str, yytext); 
				push(yylval.str, yytext);
				return NUMBER; 
			}
[a-zA-Z\_][a-zA-Z0-9\_]*	{ 
					strcpy(yylval.str, yytext); 
					push(yylval.str, yytext);
					return ID; 
				}
[ \t\n]+	{
		}
.	{ 
		strcpy(yylval.str, yytext); 
		push(yylval.str, yytext);
		return yytext[0]; 
	}

%%

int yywrap(void)
{
    return 1;
}
