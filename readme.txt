{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf820
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww12600\viewh7800\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 This program needs JFlex (http://www.jflex.de/) and Byacc/J (http://byaccj.sourceforge.net/)\
\
copied both jflex-1.6.1.jar and yacc.exe to the folder\
\
to run\
\
1. 	generate lexer source file Yylex.java by executing at the src folder the command:\
	java -jar jflex-1.6.1.jar calc.flex\
	\
2. 	generate parser files Parser.java and ParserVal.java by\
	yacc -J calc.y\
	\
3. 	compile sources\
	javac -cp jflex-1.6.1.jar *.java\
	\
4.	run program\
	java Calculator}