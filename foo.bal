import ballerina/http;
import ballerina/io;

public function main() returns error? {
    final http:Client clientEndpoint = 
                        check new ("http://postman-echo.com");
    
    io:println("GET request:");
    json resp = check clientEndpoint->get("/get?test=123");
    io:println(resp.toJsonString());

    io:println("\nGET request with Headers:");
    resp = check clientEndpoint->get("/get",
            {"Sample-Name": "http-client-connector"});
    io:println(resp.toJsonString());

    io:println("\nPOST request:");
    resp = check clientEndpoint->post("/post", "POST: Hello World");
    io:println(resp.toJsonString());

    io:println("\nUse custom HTTP verbs:");
    http:Response response = check clientEndpoint->execute(
                        "COPY", "/get", "CUSTOM: Hello World");

    io:println("Status code: " + response.statusCode.toString());
}
