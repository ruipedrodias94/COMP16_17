%{
   #include <stdio.h>
   #include <string.h>
   #include "estruturas.h"
  int yylex(void);
  void yyerror(char *s);
  int erro=0;
  int syntax_flag = 0;

%}

%union{
    char* token;
    struct node* _node;
}


%token IF
%token AND
%token ASSIGN
%token BOOL
%token CLASS
%token CCURV
%token CBRACE
%token COMMA
%token CSQUARE
%token DIV
%token DO
%token DOTLENGTH
%token DOUBLE
%token ELSE
%token EQ
%token GEQ
%token GT
%token INT
%token LT
%token LEQ
%token MINUS
%token MOD
%token NEQ
%token NOT
%token OBRACE
%token OCURV
%token OR
%token OSQUARE
%token PARSEINT
%token PLUS
%token PRINT
%token PUBLIC
%token RESERVED
%token RETURN
%token SEMI
%token STAR
%token STATIC
%token STRING
%token VOID
%token WHILE
%token ESCAPESEQUENCE

%token <token> BOOLLIT
%token <token> REALLIT
%token <token> DECLIT
%token <token> ID
%token <token> STRLIT

%type <_node> Program ProgramCycle FieldDecl FieldDeclCycle MethodDecl MethodHeader MethodBody MethodBodyCycle FormalParams FormalParamsCycle VarDecl VarDeclCycle Type Statement StatementCycle Assignment MethodInvocation MethodInvocationCycle ParseArgs Expr

%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT LEQ GT GEQ
%left PLUS MINUS
%left STAR DIV MOD
%right NOT SIGN
%left OCURV CCURV OSQUARE CSQUARE
%nonassoc IF
%nonassoc ELSE

%%
  /*Given grammar in EBNF form*/

  /*Ciclos é 0 ou mais ocorrências e são representados por {}*/
  Program: CLASS ID OBRACE ProgramCycle CBRACE                                  {;}
          ;
  ProgramCycle: ProgramCycle FieldDecl                                          {;}
              | ProgramCycle MethodDecl                                         {;}
              | ProgramCycle SEMI                                               {;}
              | %empty                                                          {;}
              ;


  FieldDecl: PUBLIC STATIC Type ID FieldDeclCycle SEMI                          {;}
            | error SEMI                                                        {;}
            ;
  FieldDeclCycle: FieldDeclCycle COMMA ID                                       {;}
                | %empty                                                        {;}
                ;

  MethodDecl: PUBLIC STATIC MethodHeader MethodBody                             {;}
            ;

  MethodHeader: Type ID OCURV FormalParams CCURV                                {;}
              | Type ID OCURV CCURV                                             {;}
              | VOID ID OCURV FormalParams CCURV                                {;}
              | VOID ID OCURV CCURV                                             {;}
              ;

  MethodBody: OBRACE MethodBodyCycle CBRACE                                     {;}
            ;
  MethodBodyCycle: MethodBodyCycle VarDecl                                      {;}
                  | MethodBodyCycle Statement                                   {;}
                  | %empty                                                      {;}
                  ;

  FormalParams: Type ID FormalParamsCycle                                       {;}
              | STRING OSQUARE CSQUARE ID                                       {;}
              ;
  FormalParamsCycle: FormalParamsCycle COMMA Type ID                            {;}
                    | %empty                                                    {;}
                    ;

  VarDecl: Type ID VarDeclCycle SEMI                                            {;}
          ;
  VarDeclCycle: VarDeclCycle COMMA ID                                           {;}
              | %empty                                                          {;}
              ;

  Type: BOOL                                                                    {;}
      | INT                                                                     {;}
      | DOUBLE                                                                  {;}
      ;

  Statement: OBRACE StatementCycle CBRACE                                       {;}
            | IF OCURV Expr CCURV Statement %prec IF                            {;}
            | IF OCURV Expr CCURV Statement ELSE Statement                      {;}
            | WHILE OCURV Expr CCURV Statement                                  {;}
            | DO Statement WHILE OCURV Expr CCURV SEMI                          {;}
            | PRINT OCURV Expr CCURV SEMI                                       {;}
            | PRINT OCURV STRLIT CCURV SEMI                                     {;}
            | SEMI                                                              {;}
            | Assignment SEMI                                                   {;}
            | MethodInvocation SEMI                                             {;}
            | ParseArgs SEMI                                                    {;}
            | RETURN SEMI                                                       {;}
            | RETURN Expr SEMI                                                  {;}
            | error SEMI                                                        {;}
            ;
 StatementCycle: StatementCycle Statement                                       {;}
              |%empty                                                           {;}
              ;

  Assignment: ID ASSIGN Expr                                                    {;}
            ;

  MethodInvocation: ID OCURV CCURV                                              {;}
                  | ID OCURV Expr MethodInvocationCycle CCURV                   {;}
                  | ID OCURV error CCURV                                        {;}
                  ;

  MethodInvocationCycle: MethodInvocationCycle COMMA Expr                       {;}
                      |%empty                                                   {;}
                      ;

  ParseArgs: PARSEINT OCURV ID OSQUARE Expr CSQUARE CCURV                       {;}
           | PARSEINT OCURV error CCURV                                         {;}
            ;

  Expr: Assignment                                                              {;}
      | MethodInvocation                                                        {;}
      | ParseArgs                                                               {;}
      | Expr AND Expr                                                           {;}
      | Expr OR Expr                                                            {;}
      | Expr EQ Expr                                                            {;}
      | Expr GEQ Expr                                                           {;}
      | Expr GT Expr                                                            {;}
      | Expr LEQ Expr                                                           {;}
      | Expr LT Expr                                                            {;}
      | Expr NEQ Expr                                                           {;}
      | Expr PLUS Expr                                                          {;}
      | Expr MINUS Expr                                                         {;}
      | Expr STAR Expr                                                          {;}
      | Expr DIV Expr                                                           {;}
      | Expr MOD Expr                                                           {;}
      | PLUS Expr %prec NOT                                                     {;}
      | MINUS Expr %prec NOT                                                    {;}
      | NOT Expr                                                                {;}
      | ID                                                                      {;}
      | ID DOTLENGTH                                                            {;}
      | BOOLLIT                                                                 {;}
      | DECLIT                                                                  {;}
      | REALLIT                                                                 {;}
      | OCURV error CCURV                                                       {;}
      ;

%%

int main(int argc, char** argv){
	if(argc>1){
		if(strcmp(argv[1],"-l")==0){
			erro = 1;
      syntax_flag = 0;
			yylex();
		}
		else
		{
      syntax_flag = 0;
			yylex();
		}
	}
	else{
   syntax_flag = 1;
   yyparse();
	}
	return 0;
}
