import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tiktok_video_downloader/data/network/base_api_request.dart';

import '../app_exceptions.dart';

class ApiRequestImpl extends BaseApiRequest {
  @override
  Future<dynamic> getGetApiRequest(String url) async {
    dynamic jsonResult;
    try {
      final res =
          await http.get(Uri.parse(url),headers: {
    'X-RapidAPI-Key': '82f246812cmsh4f7a7311e5cfc6dp1d6849jsn65494a8b8eb0',
    'X-RapidAPI-Host': 'tiktok-download-video1.p.rapidapi.com'
  });
      jsonResult = checkResponse(res);
    } on SocketException {
      throw FetchDataException("Error while communicating with server");
    }
    return jsonResult;
  }

  @override
  Future<dynamic> getPostApiRequest() async {
    throw UnimplementedError();
  }

  dynamic checkResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException("Bad request");
      case 401:
        throw UnAuthorisedException("Unauthorised");
      case 404:
        throw NotFoundException("Not found");
      case 500:
        throw ServerErrorException("Server error");
      default:
        throw FetchDataException("Something went wrong!");
    }
  }
}
