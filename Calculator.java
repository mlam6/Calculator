/**
 *
 * @author milam
 */

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.InputStreamReader;

public class Calculator {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException {
        System.out.println("Interpreted Calculator with Flex and Yacc");
        System.out.println("Implemented using JFlex and BYACC/J");
        System.out.println("[Ctrl-D] or [Ctrl-C] to exit");

        Parser yyparser;
        if ( args.length > 0 ) {
            // parse a file
            yyparser = new Parser(new FileReader(args[0]));
        }
        else {
            yyparser = new Parser(new InputStreamReader(System.in));
        }

        yyparser.yyparse();
    }
}
