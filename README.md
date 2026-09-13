# Lexical Analyzer for C

This project implements a **Lexical Analyzer for C** using **Lex/Flex** and **Yacc/Bison**.

## Files in the Project

* `1.l` – Lexical analyzer source file.
* `1.y` – Yacc parser source file containing the grammar and parsing actions.
* `inp.txt` – Input C program/code given to the analyzer.
* `production_rules.txt` – Production rules used by the parser.
* `sr_parser_table.txt` – Shift-Reduce parsing table generated/used by the parser.

## Requirements

Make sure the following tools are installed:

* Lex / Flex
* Yacc / Bison
* GCC

## How to Execute

Open the terminal in the project directory and run the following commands:

```bash
lex 1.l
yacc -d 1.y
gcc y.tab.c lex.yy.c -o 1
./1
```

## Input

The input program/code is provided in:

```text
inp.txt
```

The analyzer reads the input and performs lexical and syntax analysis based on the rules defined in `1.l` and `1.y`.

## Output

The program performs the required lexical and parsing operations and uses the following files for parser-related information:

```text
production_rules.txt
sr_parser_table.txt
```

## Tools Used

* **Lex/Flex** – Generates the lexical analyzer from `1.l`.
* **Yacc/Bison** – Generates the parser from `1.y`.
* **GCC** – Compiles the generated C source files.
* **C** – Programming language used for the implementation.
