# integrate-zendesk-saprefund

This is an apim interface. RPA post csv file on https://apim-uat.bo.tomtom-global.com/rpa/zendeskrefund with header key, if key is correct then
 message is sent to service bus queue. From Service bus queue message is posted to biztalk on a receive location having sb_messaging adapter,
 biztalk transfom the message to idoc and send to sap


![image](https://github.com/tomtom-internal/integrate-zendesk-saprefund/assets/83761186/4c61eb12-a90d-454f-a6e1-842d672f1510)

