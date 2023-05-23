      *****************************************************************
      *                                                               *
      * Copyright (C) 2010-2021 Micro Focus.  All Rights Reserved     *
      * This software may be used, modified, and distributed          *
      * (provided this notice is included without modification)       *
      * solely for internal demonstration purposes with other         *
      * Micro Focus software, and is otherwise subject to the EULA at *
      * https://www.microfocus.com/en-us/legal/software-licensing.    *
      *                                                               *
      * THIS SOFTWARE IS PROVIDED "AS IS" AND ALL IMPLIED             *
      * WARRANTIES, INCLUDING THE IMPLIED WARRANTIES OF               *
      * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE,         *
      * SHALL NOT APPLY.                                              *
      * TO THE EXTENT PERMITTED BY LAW, IN NO EVENT WILL              *
      * MICRO FOCUS HAVE ANY LIABILITY WHATSOEVER IN CONNECTION       *
      * WITH THIS SOFTWARE.                                           *
      *                                                               *
      *****************************************************************

      *****************************************************************
      * Program:     ADDCUST.CBL                                      *
      * Function:    Obtain User details                              *
      *              VSAM version                                     *
      *****************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID.
           ADDCUST.
       DATE-WRITTEN.
           September 2022.
       DATE-COMPILED.
           Today.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  WS-MISC-STORAGE.
         05  WS-PROGRAM-ID                         PIC X(8)
             VALUE 'ADDCUST'.
         05  WS-COMMAREA-LENGTH                    PIC 9(5).
         05  WS-RESP                               PIC S9(8) COMP.
         05  WS-RESP2                              PIC S9(8) COMP.
         05  WS-BNKCUST-RID                        PIC X(5).

       01 WS-BNKCUST-REC.
       COPY CBANKVCS.

       01  WS-COMMAREA.
       COPY ADDRESP.

      *COPY CABENDD.

       LINKAGE SECTION.
       01  DFHCOMMAREA                             PIC X(250).

      * COPY CENTRY.
       PROCEDURE DIVISION.

      *****************************************************************
      * Move the passed data to our area                              *
      *****************************************************************
           MOVE LENGTH OF WS-COMMAREA TO WS-COMMAREA-LENGTH.
           MOVE DFHCOMMAREA TO WS-BNKCUST-REC.

      *****************************************************************
      * Initialize our output area                                    *
      *****************************************************************
           MOVE SPACES TO WS-COMMAREA.

      *****************************************************************
      * Now attempt to get the requested record                       *
      *****************************************************************

           EXEC CICS WRITE FILE('BNKCUST')
                           FROM(WS-BNKCUST-REC)
                           LENGTH(LENGTH OF WS-BNKCUST-REC)
                           RIDFLD(BCS-REC-PID)
                           RESP(WS-RESP)
                           RESP2(WS-RESP2)
           END-EXEC.

      *****************************************************************
      * Did we get the record OK                                      *
      *****************************************************************
           IF WS-RESP IS EQUAL TO DFHRESP(NORMAL)
              STRING
                BCS-REC-NAME DELIMITED BY SIZE
                ' USER ADDED SUCCESSFULLY'
                             DELIMITED BY SIZE
              INTO RESPONSEMSG
              END-STRING
           ELSE
              STRING
                BCS-REC-NAME DELIMITED BY SIZE
                ' USER ADD FAILED'
                             DELIMITED BY SIZE
              INTO RESPONSEMSG
              END-STRING
           END-IF.

      *****************************************************************
      * Move the result back to the callers area                      *
      *****************************************************************
           
           MOVE WS-RESP     TO RESPONSERETCODE
           MOVE WS-RESP2    TO REASONRETCODE
           MOVE WS-COMMAREA TO DFHCOMMAREA(1:WS-COMMAREA-LENGTH).

      *****************************************************************
      * Return to our caller                                          *
      *****************************************************************

           EXEC CICS RETURN
           END-EXEC.
           GOBACK.



      * $ Version 5.99c sequenced on Wednesday 3 Mar 2011 at 1:00pm
