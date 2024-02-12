import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../data/response/api_response.dart';
import '../models/tiktok_model.dart';
import '../respository/get_video_repository.dart';

class DownloadVideoViewModel extends ChangeNotifier {
  double progress = 0;
  bool _isDownloading = false;
  bool get isDownloading => _isDownloading;
  final GetVideRepository _repository = GetVideRepository();
  ApiResponse<TikTokData> apiResponse = ApiResponse();
  setResponse(ApiResponse<TikTokData> response) {
    apiResponse = response;
    notifyListeners();
  }

  setLoading(bool value) {
    _isDownloading = value;
    notifyListeners();
  }

  Future<void> getVideo(url) async {
    setResponse(ApiResponse.loading());
    try {
      var res = await _repository.getVideo(url);
      setResponse(ApiResponse.success(TikTokData.fromJson(res)));
    } catch (e) {
      setResponse(ApiResponse.error("Error Occurred"));
    }
  }

  Future<void> downloadVideo(url) async {
    setLoading(true);

    Map<Permission, PermissionStatus> status =
        await [Permission.storage].request();
    if (status[Permission.storage]!.isGranted) {
      var dir = await DownloadsPathProvider.downloadsDirectory;
      if (dir != null) {
        String savename = const Uuid().v4();
        String savePath = "${dir.path}/$savename.mp4";

        try {
          setLoading(true);
          await Dio().download(url, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              progress = received / total * 100;
              notifyListeners();
              if (kDebugMode) {
                print(received / total * 100);
              }
            }
          });
          setLoading(false);
          Fluttertoast.showToast(
              msg: "Downloaded!", backgroundColor: Colors.blue);
          progress = 0;
          notifyListeners();
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
      }
    }
  }
}
