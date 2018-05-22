To run...
1. generate lexer source file Yylex.java by executing at the src folder the command:
   java -jar jflex-1.6.1.jar calc.flex
	
2. generate parser files Parser.java and ParserVal.java by
   yacc -J calc.y
	
3. compile sources
   javac -cp jflex-1.6.1.jar *.java

4. run program
   java Calculator
