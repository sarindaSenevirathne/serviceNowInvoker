import ballerina/http;
import ballerina/log;

configurable string basePath = ?;
configurable string tokenUrl = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string username = ?;
configurable string password = ?;

final http:Client snClient = check new (basePath,
    auth = {
        tokenUrl: tokenUrl,
        clientId: clientId,
        clientSecret: clientSecret,
        username: username,
        password: password
    }
);

service / on new http:Listener(9090) {
    resource function post events(@http:Payload json payload, @http:Header string X\-Hub\-Signature) returns json|error {
       
        json|error response = snClient->post("/api/wso2/scripted_wum?ni.nolog.id=cstestrepo", payload, {"X-Hub-Signature": X\-Hub\-Signature});
        if response is error {
            log:printError("Error in posting to SN", response);
        } else {
            do {
                json issue = check payload.issue;
                string url = check issue.url;
                log:printInfo(string `Successfully posted to SN: ${url}`);
            } on fail {
                log:printError("Unexpected error!");
            }
        }
        return {};

    }
}
