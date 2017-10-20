 
 /*------------------------------------------------------------------------
    File        : daGeneric
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Wed Oct 18 10:54:12 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS daGeneric: 
    METHOD PUBLIC VOID FetchData (INPUT dsGenericHandle AS HANDLE, INPUT filter AS CHAR):
        DEFINE VARIABLE genericBufferHandle AS HANDLE NO-UNDO.
        DEFINE VARIABLE queryHandleGeneric AS HANDLE NO-UNDO.
        DEFINE VARIABLE filterName AS CHARACTER NO-UNDO.
        DEFINE VARIABLE filterQuery AS CHARACTER NO-UNDO.
        DEFINE VARIABLE iIndex AS INTEGER NO-UNDO.
        
        filterName = ENTRY(1, filter, ",").
        filterQuery = ENTRY(2, filter, ",").
        
/*        MESSAGE filterName + " + " + filterQuery*/
/*        VIEW-AS ALERT-BOX.                      */
        
        genericBufferHandle = dsGenericHandle:GET-BUFFER-HANDLE(filterName).
        
        dsGenericHandle:FILL().
        
        CREATE QUERY queryHandleGeneric.
        queryHandleGeneric:SET-BUFFERS(genericBufferHandle).
        queryHandleGeneric:QUERY-PREPARE("FOR EACH " + filterName + " " + filterQuery).
        queryHandleGeneric:FORWARD-ONLY = TRUE.
        queryHandleGeneric:QUERY-OPEN() NO-ERROR.
        
        REPEAT WITH FRAME y:
            queryHandleGeneric:GET-NEXT().
            IF queryHandleGeneric:QUERY-OFF-END THEN
              LEAVE.
              
/*            IF filterName = "ttDonation" THEN                                     */
/*                DISPLAY genericBufferHandle:BUFFER-FIELD ("ID"):BUFFER-VALUE ().  */
/*            ELSE                                                                  */
/*                DISPLAY genericBufferHandle:BUFFER-FIELD ("Name"):BUFFER-VALUE ().*/
        END.

        queryHandleGeneric:QUERY-CLOSE().
        DELETE OBJECT queryHandleGeneric.      
     END METHOD.
    
    METHOD PUBLIC VOID StoreData (INPUT dsGenericHandle AS HANDLE):
        DEFINE VARIABLE genericBufferHandle AS HANDLE NO-UNDO.
        genericBufferHandle = dsGenericHandle:GET-BUFFER-HANDLE().
        
        IF genericBufferHandle:AVAILABLE THEN
            IF genericBufferHandle:NAME = "ttDonation" THEN DO:
                IF genericBufferHandle:BUFFER-FIELD ("DonatorID"):BUFFER-VALUE () = 4 THEN
                    genericBufferHandle:BUFFER-FIELD ("DonatorID"):BUFFER-VALUE () = 6.
            END.
            ELSE 
                IF genericBufferHandle:BUFFER-FIELD ("Name"):BUFFER-VALUE () = "Andre" THEN
                    genericBufferHandle:BUFFER-FIELD ("Name"):BUFFER-VALUE () = "Unicorn".
     
        IF genericBufferHandle:ROW-STATE = ROW-MODIFIED THEN DO:
            MESSAGE "Updates applied"
            VIEW-AS ALERT-BOX.
            genericBufferHandle:BEFORE-BUFFER:SAVE-ROW-CHANGES ().
        END.
    END METHOD.
END CLASS.