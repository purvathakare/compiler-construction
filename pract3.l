
%{
#include <stdio.h>
int count = 0;
%}

%%

[Aa][a-zA-Z]* {
    count++;
    printf("Matched: %s\n", yytext);
}

[a-zA-Z]+  ;
\n         ;
.          ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter text (Ctrl+D to stop):\n");
    yylex();
    printf("Total words starting with A: %d\n", count);
    return 0;
}
