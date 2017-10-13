
/*------------------------------------------------------------------------
    File        : dsW3Friday.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Oct 13 12:18:46 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE TEMP-TABLE ttEmployee NO-UNDO LIKE Employee BEFORE-TABLE btEmployee.
DEFINE DATASET dEmployee FOR ttEmployee.
DEFINE QUERY qEmployee FOR Employee SCROLLING.
DEFINE DATA-SOURCE dsEmployee FOR QUERY qEmployee.
BUFFER ttEmployee:ATTACH-DATA-SOURCE(DATA-SOURCE dsEmployee:HANDLE,?,?).
QUERY qEmployee:QUERY-PREPARE("FOR EACH Employee"). // WHERE Employee.EmpNum < 10").
DATASET dEmployee:FILL().

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
