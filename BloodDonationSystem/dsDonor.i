
/*------------------------------------------------------------------------
    File        : dsDonor.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 17 11:34:56 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE TEMP-TABLE ttDonor LIKE Donor BEFORE-TABLE btDonor.

DEFINE DATASET dDonor FOR ttDonor.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
