
/*------------------------------------------------------------------------
    File        : w2Thursday.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Thu Oct 05 11:31:54 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.
DEFINE VARIABLE cPathName AS CHARACTER NO-UNDO INITIAL "D:\workspace\HelloWorld\".
DEFINE VARIABLE cXMLName AS CHARACTER NO-UNDO INITIAL "D:\workspace\HelloWorld\myXML.txt".
DEFINE VARIABLE cJSONName AS CHARACTER NO-UNDO INITIAL "D:\workspace\HelloWorld\myJSON.json".
DEFINE STREAM s.
DEFINE VARIABLE text-string AS CHARACTER FORMAT "x(76)".
DEFINE VARIABLE cFileStream AS CHARACTER NO-UNDO.

DEFINE TEMP-TABLE ttCustomer LIKE Customer BEFORE-TABLE btCustomer.
DEFINE DATASET dCustomer FOR ttCustomer.
DEFINE DATA-SOURCE dsCustomer FOR Customer.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
/*Creati o functie care citeste toate recordurile dintr-o tabela la alegere 
si le tipareste intru fisier txt cate un record pe linie, creati apoi o a 
2 a functie care sa citeasca acest fisier si sa creeze in baza de date un 
record pentru fiecare linie din fisier*/
/*INPUT FROM "D:\workspace\HelloWorld\myfile.txt".
OUTPUT STREAM s TO myfile.txt.
DISPLAY cPathName FORMAT "x(50)".
RUN writeFile.
RUN readFile.

PROCEDURE writeFile:
    FOR EACH Customer NO-LOCK:
        /* Append a new line character to the end of the file */
        //PUT UNFORMATTED "~n ".
        PUT STREAM s name "~n ".
    END.
    OUTPUT STREAM s CLOSE.
    
    MESSAGE "The txt file was created"
        VIEW-AS ALERT-BOX.
END PROCEDURE.

PROCEDURE readFile:
    DEFINE VARIABLE iLittle AS INTEGER INITIAL 0.
    
    DO WHILE TRUE ON ENDKEY UNDO, LEAVE:
        IMPORT UNFORMATTED text-string.
        iLittle = iLittle + 1.
        IF (iLittle < 10) THEN DO:
            CREATE Customer.
            ASSIGN Customer.NAME = text-string.
        END.
    END.
    INPUT CLOSE.
    
    MESSAGE "The first 10 entries were added to the database"
        VIEW-AS ALERT-BOX.
END PROCEDURE.*/

/********************************************************************** */
/*Example*/
/*DEFINE VARIABLE cDir        AS CHARACTER NO-UNDO INITIAL 'D:\'.
DEFINE VARIABLE cFileStream AS CHARACTER NO-UNDO.

INPUT FROM OS-DIR (cDir) ECHO.

REPEAT:
    IMPORT cFileStream.
    FILE-INFO:FILE-NAME = cFileStream.
    DISPLAY cFileStream FORMAT "X(18)" LABEL 'name of the file'
            FILE-INFO:FULL-PATHNAME FORMAT "X(21)" LABEL 'FULL-PATHNAME'
            FILE-INFO:PATHNAME FORMAT "X(21)" LABEL 'PATHNAME'
            FILE-INFO:FILE-TYPE FORMAT "X(5)" LABEL 'FILE-TYPE'SKIP.
END.*/

/********************************************************************** */
/*Creati o functie care sa primeasca ca si input parameter un path din 
system (Ex: D:\) parcurgeti TOATE directoarele si fisierele din acest 
director si tipariti numele lor intron fisier .txt*/
/*INPUT FROM OS-DIR (cPathName) ECHO.
OUTPUT STREAM s TO fisier.txt .
RUN parcurge(INPUT cPathName).

PROCEDURE parcurge:
    DEFINE INPUT PARAMETER cMyPath AS CHARACTER NO-UNDO.
    
    REPEAT:
        IMPORT cFileStream.
        FILE-INFO:FILE-NAME = cFileStream.
        PUT STREAM s cFileStream FORMAT "X(18)" "~n ".
    END.
    OUTPUT STREAM s CLOSE.
    
    MESSAGE "The txt file was created"
        VIEW-AS ALERT-BOX.
END PROCEDURE.*/

/********************************************************************** */
/*Example*/
/*DEFINE VARIABLE hDoc    AS HANDLE   NO-UNDO.
DEFINE VARIABLE hRoot   AS HANDLE   NO-UNDO.
DEFINE VARIABLE hRow    AS HANDLE   NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE   NO-UNDO.
DEFINE VARIABLE hText   AS HANDLE   NO-UNDO.
DEFINE VARIABLE hBuf     AS HANDLE   NO-UNDO.
DEFINE VARIABLE hDBFld  AS HANDLE   NO-UNDO.
DEFINE VARIABLE ix      AS INTEGER  NO-UNDO.

CREATE X-DOCUMENT hDoc.
CREATE X-NODEREF hRoot.
CREATE X-NODEREF hRow.
CREATE X-NODEREF hField.
CREATE X-NODEREF hText.

hBuf = BUFFER Customer:HANDLE.

/* Set up a root node */
hDoc:CREATE-NODE(hRoot,"Customers","ELEMENT").
hDoc:APPEND-CHILD(hRoot).

FOR EACH Customer WHERE Customer.CustNum < 5:
    hDoc:CREATE-NODE(hRow,"Customer","ELEMENT"). /* create a row node */
    hRoot:APPEND-CHILD(hRow).  /* put the row in the tree */
    hRow:SET-ATTRIBUTE("CustNum", STRING(Customer.CustNum)).
    hRow:SET-ATTRIBUTE("Name", Customer.Name).

    /* Add the other fields as tags in the xml */
    REPEAT ix = 1 TO hBuf:NUM-FIELDS:
        hDBFld = hBuf:BUFFER-FIELD(ix).
        IF hDBFld:NAME = "CustNum" OR  hDBFld:NAME = "Name" THEN NEXT.
    
        /* Create a tag with the field name */
        hDoc:CREATE-NODE(hField, hDBFld:NAME, "ELEMENT").
    
        /* Put the new field as next child of row */
        hRow:APPEND-CHILD(hField).

        /* Add a node to hold field value. The empty string ("") represents the
       value that will be set later. */
        hDoc:CREATE-NODE(hText, "", "TEXT").

        /* Attach the text to the field */
        hField:APPEND-CHILD(hText).
        hText:NODE-VALUE = STRING(hDBFld:BUFFER-VALUE).
    END.
END.

/* Write the XML node tree to an xml file */
hDoc:SAVE("file","cust.xml").

DELETE OBJECT hDoc.
DELETE OBJECT hRoot.
DELETE OBJECT hRow.
DELETE OBJECT hField.
DELETE OBJECT hText.*/

/********************************************************************** */
/*Transmiteti informatiile dintrun dataset intre 2 proceduri prin scrierea 
si citirea de pe disk a unui .xml si a unui .json.*/

/*INPUT FROM cXMLName.
OUTPUT STREAM s TO myXML.xml.*/

INPUT FROM "D:\workspace\HelloWorld\myJSON.json".
OUTPUT STREAM s TO myJSON.json.

BUFFER ttCustomer:ATTACH-DATA-SOURCE(DATA-SOURCE dsCustomer:HANDLE,?,?).
DATASET dCustomer:FILL(). //dCustomer:writeXML("empty", path, yes).

/*RUN writeXML(INPUT cXMLName).
RUN readXML(INPUT cXMLName).*/

RUN writeJSON(INPUT cJSONName).
RUN readJSON(INPUT cJSONName).

PROCEDURE writeXML:
    DEFINE INPUT PARAMETER cMyXML AS CHARACTER NO-UNDO.
    
    DEFINE VARIABLE hDoc    AS HANDLE   NO-UNDO.
    DEFINE VARIABLE hRoot   AS HANDLE   NO-UNDO.
    DEFINE VARIABLE hRow    AS HANDLE   NO-UNDO.
    DEFINE VARIABLE hField  AS HANDLE   NO-UNDO.
    DEFINE VARIABLE hText   AS HANDLE   NO-UNDO.
    DEFINE VARIABLE hBuf    AS HANDLE   NO-UNDO.
    DEFINE VARIABLE hDBFld  AS HANDLE   NO-UNDO.
    DEFINE VARIABLE ix      AS INTEGER  NO-UNDO.

    CREATE X-DOCUMENT hDoc.
    CREATE X-NODEREF hRoot.
    CREATE X-NODEREF hRow.
    CREATE X-NODEREF hField.
    CREATE X-NODEREF hText.

    hBuf = TEMP-TABLE ttCustomer:DEFAULT-BUFFER-HANDLE.
    
    /* Set up a root node */
    hDoc:CREATE-NODE(hRoot,"Customers","ELEMENT").
    hDoc:APPEND-CHILD(hRoot).

    FOR EACH ttCustomer WHERE ttCustomer.CustNum < 5:
        hDoc:CREATE-NODE(hRow,"Customer","ELEMENT"). /* create a row node */
        hRoot:APPEND-CHILD(hRow).  /* put the row in the tree */
        hRow:SET-ATTRIBUTE("CustNum", STRING(ttCustomer.CustNum)).
        hRow:SET-ATTRIBUTE("Name", ttCustomer.Name).

        /* Add the other fields as tags in the xml */
        REPEAT ix = 1 TO hBuf:NUM-FIELDS:
            hDBFld = hBuf:BUFFER-FIELD(ix).
            IF hDBFld:NAME = "CustNum" OR  hDBFld:NAME = "Name" THEN NEXT.
    
            /* Create a tag with the field name */
            hDoc:CREATE-NODE(hField, hDBFld:NAME, "ELEMENT").
    
            /* Put the new field as next child of row */
            hRow:APPEND-CHILD(hField).

            /* Add a node to hold field value. The empty string ("") represents the
            value that will be set later. */
            hDoc:CREATE-NODE(hText, "", "TEXT").

            /* Attach the text to the field */
            hField:APPEND-CHILD(hText).
            hText:NODE-VALUE = STRING(hDBFld:BUFFER-VALUE).
        END.
    END.

    /* Write the XML node tree to an xml file */
    hDoc:SAVE("stream", "s").
    
    OUTPUT STREAM s CLOSE.
    
    DELETE OBJECT hDoc.
    DELETE OBJECT hRoot.
    DELETE OBJECT hRow.
    DELETE OBJECT hField.
    DELETE OBJECT hText.
    
    MESSAGE "The XML file was created"
        VIEW-AS ALERT-BOX.   
END PROCEDURE.

PROCEDURE readXML:
    DEFINE INPUT PARAMETER cMyXML AS CHARACTER NO-UNDO.
    
    DATASET dCustomer:READ-XML("file", cMyXML, "empty", ?, YES, ?, "IGNORE") NO-ERROR.
        
    INPUT CLOSE.
    
    MESSAGE "The data was loaded into the dataset"
        VIEW-AS ALERT-BOX.
END PROCEDURE.

PROCEDURE writeJSON:
    DEFINE INPUT PARAMETER cMyJSON AS CHARACTER NO-UNDO.

    DEFINE VARIABLE lRetOK AS LOGICAL NO-UNDO.
    lRetOK = DATASET dCustomer:WRITE-JSON("file", cMyJSON, TRUE).
    OUTPUT STREAM s CLOSE.
    IF lRetOK THEN
        MESSAGE "The JSON file was created"
        VIEW-AS ALERT-BOX.
END PROCEDURE.

PROCEDURE readJSON:
    DEFINE INPUT PARAMETER cMyJSON AS CHARACTER NO-UNDO.

    DEFINE VARIABLE lRetOK AS LOGICAL NO-UNDO.
    lRetOK = DATASET dCustomer:READ-JSON("file", cMyJSON, "MERGE").

    INPUT CLOSE.

    IF lRetOK THEN
        MESSAGE "The data was loaded into the dataset"
        VIEW-AS ALERT-BOX.
END PROCEDURE.