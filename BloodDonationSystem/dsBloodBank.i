
/*------------------------------------------------------------------------
    File        : dsBloodBank.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 17 11:34:35 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE TEMP-TABLE ttBloodBank LIKE BloodBank BEFORE-TABLE btBloodBank.

DEFINE DATASET dBloodBank FOR ttBloodBank.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
