
/*------------------------------------------------------------------------
    File        : dsDonation.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 17 11:34:01 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE TEMP-TABLE ttDonation LIKE Donation BEFORE-TABLE btDonation.

DEFINE DATASET dDonation FOR ttDonation.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
