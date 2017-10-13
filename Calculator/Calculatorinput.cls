 
 /*------------------------------------------------------------------------
    File        : Calculatorinput
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Thu Oct 12 11:28:45 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS w3Thursday.Calculator.Calculatorinput INHERITS Progress.Windows.WindowContainer: 
    DEFINE PUBLIC VARIABLE cInput1 AS INTEGER NO-UNDO.
    DEFINE PUBLIC VARIABLE cInput2 AS INTEGER NO-UNDO.
    DEFINE PUBLIC VARIABLE cOp AS CHARACTER NO-UNDO.
    //DEFINE PUBLIC VARIABLE ui AS WIDGET-HANDLE.
    
    CONSTRUCTOR Calculatorinput( ): 
        RUN w3Thursday/Calculator/C-Win.w(OUTPUT cInput1, OUTPUT cInput2, OUTPUT cOp).
    END CONSTRUCTOR.
    
    /*METHOD PUBLIC INTEGER getcInput():
        RETURN cInput.
    END METHOD.*/

END CLASS.