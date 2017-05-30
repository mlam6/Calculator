/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2001 Gerwin Klein <lsf@jflex.de>                          *
 * All rights reserved.                                                    *
 *                                                                         *
 * This is a modified version of the example from                          *
 *   http://www.lincom-asg.com/~rjamison/byacc/                            *
 *                                                                         *
 * Thanks to Larry Bell and Bob Jamison for suggestions and comments.      *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
  import java.io.*;
  import static java.lang.Double.NEGATIVE_INFINITY;
  import static java.lang.Double.POSITIVE_INFINITY;
%}
      
%token NL          /* newline  */
%token <dval> NUM  /* a number */

%type <dval> eqn
%type <dval> comp
%type <dval> exp
%type <dval> term
%type <dval> fact
   
%left  EQ NE GE LE '<' '>' 
%left   '-' '+'
%left   '*' '/'
%right  '^'         /* exponentiation        */
      
%start input
%%

input:   /* empty string */
       | input line
       ;
line:	NL
	| eqn NL        { if($1 == POSITIVE_INFINITY) System.out.println(" = TRUE"); 
                            else if ($1 == NEGATIVE_INFINITY) System.out.println(" = FALSE");  
                            else System.out.println(" = " + $1);}
	;
eqn:	eqn EQ comp    { $$ = ($1 == $3? POSITIVE_INFINITY: NEGATIVE_INFINITY); }
        | eqn NE comp    { $$ = ($1 != $3? POSITIVE_INFINITY: NEGATIVE_INFINITY); }
        | eqn GE comp    { $$ = ($1 >= $3? POSITIVE_INFINITY: NEGATIVE_INFINITY); }
        | eqn LE comp    { $$ = ($1 <= $3? POSITIVE_INFINITY: NEGATIVE_INFINITY); }
	| comp          { $$ = $1; }
	;
comp:	comp '>' exp    { $$ = ($1 > $3? POSITIVE_INFINITY: NEGATIVE_INFINITY); }
	| comp '<' exp  { $$ = ($1 < $3? POSITIVE_INFINITY: NEGATIVE_INFINITY); }
	| exp           { $$ = $1; }
	;
exp:	exp '+' term    { $$ = $1 + $3; }
	| exp '-' term  { $$ = $1 - $3; }
	| term          { $$ = $1; }
	;
term:   term '*' fact   { $$ = $1 * $3; }
        | term '/' fact { $$ = $1 / $3; }
        | fact          { $$ = $1; }
        ;
fact:	fact '^' fact   { $$ = Math.pow($1, $3); }
	| exp           { $$ = $1; }
	| NUM           { $$ = $1; }
	| '(' exp ')'   { $$ = $2; }
	;

%%

  private Yylex lexer;


  private int yylex () {
    int yyl_return = -1;
    try {
      yylval = new ParserVal(0);
      yyl_return = lexer.yylex();
    }
    catch (IOException e) {
      System.err.println("IO error :"+e);
    }
    return yyl_return;
  }


  public void yyerror (String error) {
    System.err.println ("Error: " + error);
  }


  public Parser(Reader r) {
    lexer = new Yylex(r, this);
  }


  static boolean interactive;

  public static void main(String args[]) throws IOException {
    System.out.println("BYACC/Java with JFlex Calculator Demo");

    Parser yyparser;
    if ( args.length > 0 ) {
      // parse a file
      yyparser = new Parser(new FileReader(args[0]));
    }
    else {
      // interactive mode
      System.out.println("[Quit with CTRL-D]");
      System.out.print("Expression: ");
      interactive = true;
	    yyparser = new Parser(new InputStreamReader(System.in));
    }

    yyparser.yyparse();
    
    if (interactive) {
      System.out.println();
      System.out.println("Have a nice day");
    }
  }
