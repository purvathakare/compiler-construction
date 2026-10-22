
%{
#include <stdio.h>
#include <string.h>

int comments = 0, keywords = 0;
int identifiers = 0, words = 0;
int lines = 0, spaces = 0;

int is_keyword(const char *s)
{
    const char *kw[] = {
        "int", "float", "char", "double",
        "if", "else", "for", "while",
        "return", "void", "break", "continue"
    };

    for (int i = 0; i < 12; i++)
        if (strcmp(s, kw[i]) == 0)
            return 1;

    return 0;
}
%}

%x COMMENT

%%

"//"[^\n]* {
    comments++;
}

"/*" {
    comments++;
    BEGIN(COMMENT);
}

<COMMENT>"*/"  { BEGIN(INITIAL); }
<COMMENT>\n    { lines++; }
<COMMENT>.     ;

\"([^\\\"\n]|\\.)*\"  ;

[a-zA-Z_][a-zA-Z0-9_]* {
    words++;
    if (is_keyword(yytext))
        keywords++;
    else
        identifiers++;
}

\n       { lines++; }
[ \t]    { spaces += yyleng; }
.        ;

%%

int yywrap()
{
    return 1;
}

int main(int argc, char *argv[])
{
    if (argc < 2) {
        printf("Usage: %s input.txt\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");

    if (!yyin) {
        printf("Cannot open file\n");
        return 1;
    }

    yylex();

    printf("Comments: %d\n", comments);
    printf("Keywords: %d\n", keywords);
    printf("Identifiers: %d\n", identifiers);
    printf("Words: %d\n", words);
    printf("Lines: %d\n", lines);
    printf("Spaces: %d\n", spaces);

    fclose(yyin);
    return 0;
}
