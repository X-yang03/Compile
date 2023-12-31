%{
/*********************************************
修改yacc程序，实现中缀表达式到后缀表达式的转换
YACC file
**********************************************/
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif
char identifier[50];
char number[50];
int yylex() ;
extern int yyparse() ;
FILE* yyin;
void yyerror(const char* s);
%}

//TODO:给每个符号定义一个单词类别
%token ADD SUB MUL DIV LB RB
%token NUMBER
%token ID
%left ADD MUS
%left MUL DIV
%right UMINUS
%%

lines : lines expr ';' { printf("result: %s\n" , $2);}
      | lines ';'
      |
      ;
//TODO:完善表达式的规则
expr  : expr ADD expr { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"+ "); }
      | expr SUB expr { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"- "); }
      | expr MUL expr { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"* "); }
      | expr DIV expr { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"/ "); }
      | LB expr RB    { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$2); }
      | SUB expr %prec UMINUS { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,"-"); strcat($$,$2); }
      | NUMBER        { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$," "); }
      | ID            { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$," "); }
      ;
%%

// programs section

int yylex()
{
    	char t;
	while(1){
		t = getchar();
		if(t==' ' || t =='\t'|| t == '\n'){

        }else if(t == '+'){
			return ADD;
		}else if(t == '*'){
			return MUL;
		}else if(t == '-'){
			return SUB;
		}else if(t == '/'){
			return DIV;
		}else if(t == '('){
			return LB;
		}else if(t == ')'){
			return RB;
		}else if(t>='0'&&t<='9'){
			int ti = 0;  
			while (t>='0'&&t<='9'){
                number[ti]=t;
                t = getchar();
                ti++;
            }
            number[ti] = '\0';
            yylval = number;
            ungetc(t,stdin);
            return NUMBER;
		}else if(('a'<=t&&t<='z')||('A'<=t&&'Z'>=t)||(t=='_')){
            int ti=0;
            while(('a'<=t&&t<='z')||('A'<=t&&'Z'>=t)||(t=='_')||(t>='0'&&t<='9')){
                identifier[ti] = t;
                ti++;
                t=getchar(); 
            }
            identifier[ti] = '\0';
            yylval = identifier;
            ungetc(t,stdin);
            return ID;   
        }else{
			return t;
		}
	}
}
int main(void)
{
    yyin = stdin;
    do {
        yyparse () ;
    } while (!feof(yyin)) ;
        return 0;
    }
void yyerror(const char* s) {
    fprintf(stderr,"Parse error : %s\n",s) ;
    exit(1);
}

