import ballerina/http;

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
    resource function post events(@http:Payload json payload) returns json|error {
       
        return {};

    }
}
