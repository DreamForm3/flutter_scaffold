/// HTTP method
enum HttpMethod {
  GET,
  POST,
  PUT,
  DELETE,
  OPTIONS,
  PATCH
}

String getHttpMethodName(HttpMethod method) {
  return method.toString().substring(method.toString().indexOf('.') + 1);
}