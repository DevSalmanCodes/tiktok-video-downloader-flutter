abstract class BaseApiRequest{
  Future<dynamic> getGetApiRequest(String url);
  Future<dynamic> getPostApiRequest();
}