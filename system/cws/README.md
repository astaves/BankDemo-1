# cws

This directory contains the files for CICS Web Services. 

The files were generated using the command the following command run with this as the current directory:

    ```
    LS2JS pgmint=commarea pgmname=..\..\sources\cobol\core\ADDCUST.cbl reqmem=..\..\sources\copybook\CBANKVCS.cpy respmem=..\..\sources\copybook\ADDRESP.cpy uri=/bankdemo/addcust wsbind=wsbind\JSONPIPE\addcust.wsbind json-schema-request=schema\addcustreq.json json-schema-response=schema\addcustresp.json
    ```

Sample cURL test command, adjust the server and port if necessary:

    ```
    curl -H "Content-Type: application/json" -X POST http://localhost:55220/bankdemo/addcust -d "{ \"addcust\": { \"BCS_RECORD\": { \"BCS_REC_PID\": \"z1001\", \"BCS_REC_NAME\": \"ABCDEFGHIJKLMNOPQRSTU\", \"BCS_REC_NAME_FF\": \"ABCDEFGHIJKLMNOPQRSTUVW\", \"BCS_REC_SIN\": \"ABCDEFGH\", \"BCS_REC_ADDR1\": \"ABCDEFGHIJKLMNOPQRSTUVW\", \"BCS_REC_ADDR2\": \"ABCDEFGHIJKLM\", \"BCS_REC_STATE\": \"ON\", \"BCS_REC_CNTRY\": \"CANADA\", \"BCS_REC_POST_CODE\": \"ABCDE\", \"BCS_REC_TEL\": \"12345678901\", \"BCS_REC_EMAIL\": \"ABCDEFGHIJKLMNOPQRSTUVWXYZAB\", \"BCS_REC_SEND_MAIL\": \"\", \"BCS_REC_SEND_EMAIL\": \"\", \"BCS_REC_ATM_PIN\": \"1234\", \"BCS_REC_FILLER\": \"\" }}}"
    ```