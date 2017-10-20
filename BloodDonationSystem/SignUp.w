&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS FILL-IN-11 FILL-IN-6 FILL-IN-7 FILL-IN-12 ~
FILL-IN-8 FILL-IN-13 FILL-IN-9 FILL-IN-14 FILL-IN-15 FILL-IN-10 BUTTON-1 ~
FILL-IN-16 
&Scoped-Define DISPLAYED-OBJECTS FILL-IN-11 FILL-IN-6 FILL-IN-7 FILL-IN-12 ~
FILL-IN-8 FILL-IN-13 FILL-IN-9 FILL-IN-14 FILL-IN-15 FILL-IN-10 FILL-IN-16 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "Create" 
     SIZE 51 BY 1.19.

DEFINE VARIABLE FILL-IN-10 AS DATE FORMAT "99/99/99":U 
     LABEL "Last Donation" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-11 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Memorable Word" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-12 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Name" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-13 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Password" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-14 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Sex" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-15 AS CHARACTER FORMAT "X(256)":U 
     LABEL "User Name" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-16 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Weight" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-6 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Address" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-7 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Blood Group" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-8 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Contact Nr" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.

DEFINE VARIABLE FILL-IN-9 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Height" 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     FILL-IN-11 AT ROW 1.95 COL 98 COLON-ALIGNED WIDGET-ID 12
     FILL-IN-6 AT ROW 2 COL 16.2 COLON-ALIGNED WIDGET-ID 2
     FILL-IN-7 AT ROW 3.81 COL 16.2 COLON-ALIGNED WIDGET-ID 4
     FILL-IN-12 AT ROW 3.86 COL 98 COLON-ALIGNED WIDGET-ID 14
     FILL-IN-8 AT ROW 5.76 COL 16.2 COLON-ALIGNED WIDGET-ID 6
     FILL-IN-13 AT ROW 5.81 COL 98 COLON-ALIGNED WIDGET-ID 16 PASSWORD-FIELD 
     FILL-IN-9 AT ROW 7.62 COL 16.2 COLON-ALIGNED WIDGET-ID 8
     FILL-IN-14 AT ROW 7.67 COL 98 COLON-ALIGNED WIDGET-ID 18
     FILL-IN-15 AT ROW 9.57 COL 98 COLON-ALIGNED WIDGET-ID 20
     FILL-IN-10 AT ROW 9.67 COL 16.4 COLON-ALIGNED WIDGET-ID 10
     BUTTON-1 AT ROW 11.48 COL 18.4 WIDGET-ID 24
     FILL-IN-16 AT ROW 11.48 COL 98 COLON-ALIGNED WIDGET-ID 22
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 167.2 BY 14.29 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 14.29
         WIDTH              = 167.2
         MAX-HEIGHT         = 17.38
         MAX-WIDTH          = 167.2
         VIRTUAL-HEIGHT     = 17.38
         VIRTUAL-WIDTH      = 167.2
         RESIZE             = YES
         SCROLL-BARS        = NO
         STATUS-AREA        = NO
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = YES
         THREE-D            = YES
         MESSAGE-AREA       = NO
         SENSITIVE          = YES.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = NO.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 C-Win
ON CHOOSE OF BUTTON-1 IN FRAME DEFAULT-FRAME /* Create */
DO:
    RUN myCreate.p(FILL-IN-6:INPUT-VALUE, FILL-IN-7:INPUT-VALUE, FILL-IN-8:INPUT-VALUE, FILL-IN-9:INPUT-VALUE, FILL-IN-10:INPUT-VALUE, FILL-IN-11:INPUT-VALUE, FILL-IN-12:INPUT-VALUE, FILL-IN-13:INPUT-VALUE, FILL-IN-14:INPUT-VALUE, FILL-IN-15:INPUT-VALUE, FILL-IN-16:INPUT-VALUE).  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY FILL-IN-11 FILL-IN-6 FILL-IN-7 FILL-IN-12 FILL-IN-8 FILL-IN-13 
          FILL-IN-9 FILL-IN-14 FILL-IN-15 FILL-IN-10 FILL-IN-16 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE FILL-IN-11 FILL-IN-6 FILL-IN-7 FILL-IN-12 FILL-IN-8 FILL-IN-13 
         FILL-IN-9 FILL-IN-14 FILL-IN-15 FILL-IN-10 BUTTON-1 FILL-IN-16 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

