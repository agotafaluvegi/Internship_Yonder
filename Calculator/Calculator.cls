 
 /*------------------------------------------------------------------------
    File        : Calculator
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Thu Oct 12 11:00:58 EEST 2017
    Notes       : Construiti clasele calculator, calculatorinput si calculatorresult
                    • Clasa calculator sa aiba o metoda publica execute 
                      prin care sa se poata face un calcul si care sa primeasca 
                      ca si input o instanta a clasei calculatorinput aceasta 
                      metoda trebuie sa returneze un atribut al clasei calculatorresult 
                    • Folositi clase abstracte, overloading methods , interface, 
                      static constructor
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.
    
CLASS w3Thursday.Calculator.Calculator: 
    
    METHOD PUBLIC DECIMAL cExecute(INPUT myInput AS CLASS w3Thursday.Calculator.Calculatorinput):
        DEFINE VARIABLE myResult AS DECIMAL NO-UNDO INITIAL 0.
        
        CASE myInput:cOp:
            WHEN "+" THEN
                myResult = myInput:cInput1 + myInput:cInput2.
            WHEN "-" THEN  
                myResult = myInput:cInput1 - myInput:cInput2.
            WHEN "*" THEN  
                myResult = myInput:cInput1 * myInput:cInput2.
            WHEN "/" THEN  
                myResult = myInput:cInput1 / myInput:cInput2.
            END CASE.
        
        RETURN myResult.
    END METHOD.

END CLASS.