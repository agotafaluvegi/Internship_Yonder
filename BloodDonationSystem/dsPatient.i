
/*------------------------------------------------------------------------
    File        : dsPatient.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 17 11:35:10 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE TEMP-TABLE ttPatient LIKE Patient BEFORE-TABLE btPatient.

DEFINE DATASET dPatient FOR ttPatient.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
