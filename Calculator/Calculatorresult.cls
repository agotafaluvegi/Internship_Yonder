 
 /*------------------------------------------------------------------------
    File        : Calculatorresult
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Thu Oct 12 11:28:57 EEST 2017
    Notes       : Clasa calculatorresult trebuie sa aiba un constructor 
                  static si mai multe attribute cu eventualele rezultate 
                  ale calculului
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS w3Thursday.Calculator.Calculatorresult: 
    DEFINE PUBLIC STATIC VARIABLE cResult AS DECIMAL NO-UNDO.
    DEFINE PUBLIC STATIC VARIABLE cAlculator AS CLASS w3Thursday.Calculator.Calculator NO-UNDO.
    DEFINE PRIVATE STATIC VARIABLE cInput AS CLASS w3Thursday.Calculator.Calculatorinput NO-UNDO.
     
    CONSTRUCTOR STATIC Calculatorresult( ): 
        cAlculator = NEW w3Thursday.Calculator.Calculator ( ).
        cInput = NEW w3Thursday.Calculator.Calculatorinput ( ).
        cResult = cAlculator:cExecute(cInput).
        printResult().
    END CONSTRUCTOR. 
    
    METHOD PUBLIC STATIC VOID printResult():
        MESSAGE cInput:cInput1 " + " cInput:cInput2 " = " cResult VIEW-AS ALERT-BOX.
    END METHOD. 

END CLASS.