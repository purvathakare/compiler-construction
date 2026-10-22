
%{
#include <stdio.h>
%}

%%

[0-9]+                    { printf("Number: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*    { printf("Identifier: %s\n", yytext); }
[+\-*/=]                  { printf("Operator: %s\n", yytext); }
[ \t\n]+                  ;
.                         { printf("Special Character: %s\n", yytext); }

%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter input (Ctrl+D to stop):\n");
    yylex();
    return 0;
}
