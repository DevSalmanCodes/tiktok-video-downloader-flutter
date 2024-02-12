import '../data/network/api_request_impl.dart';
import '../data/network/base_api_request.dart';

class GetVideRepository {
  final BaseApiRequest _apiRequest = ApiRequestImpl();

  Future<dynamic> getVideo(url) async {
    final res = await _apiRequest
        .getGetApiRequest('https://www.tikwm.com/api/?url=$url?hd=1');
    return res;
  }
}
