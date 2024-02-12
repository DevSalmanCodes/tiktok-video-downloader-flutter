// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../data/status.dart';
import '../recources/colors.dart';
import '../recources/components/shimmer.dart';
import '../view_model/download_video_view_model.dart';

class DownloadVideoView extends StatefulWidget {
  const DownloadVideoView({super.key, required this.url});
  final String url;
  @override
  State<DownloadVideoView> createState() => _DownloadVideoViewState();
}

class _DownloadVideoViewState extends State<DownloadVideoView> {
  late DownloadVideoViewModel downloadVideoViewModel;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    downloadVideoViewModel = DownloadVideoViewModel();
    downloadVideoViewModel.getVideo(widget.url);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      if (kDebugMode) {
        print('Couldn\'t check connectivity status');
      }
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  bool _isConnectionPresent() {
    return _connectionStatus.toString() == "ConnectivityResult.wifi" ||
        _connectionStatus.toString() == "ConnectivityResult.mobile";
  }

  int _convertToMB(size) {
    return (size / (1024 * 1024)).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ChangeNotifierProvider(
        create: (context) => downloadVideoViewModel,
        child: Consumer<DownloadVideoViewModel>(
          builder: (context, provider, child) {
            switch (provider.apiResponse.status) {
              case STATUS.LOADING:
                return const ShimmerEffect();
              case STATUS.SUCCESS:
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              provider.apiResponse.data!.data.cover,
                              loadingBuilder: (BuildContext context,
                              
                                  Widget child, ImageChunkEvent? progress) {
                                if (progress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              provider.apiResponse.data!.data.title,
                              maxLines: 1,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                          '${_convertToMB(provider.apiResponse.data!.data.wmSize).toStringAsFixed(0)} MB'),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: provider.isDownloading
                            ? null
                            : () async {
                                if (_isConnectionPresent()) {
                                  await provider.downloadVideo(
                                      provider.apiResponse.data!.data.play);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "No internet connection.",
                                      backgroundColor: Colors.blue);
                                }
                              },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: provider.isDownloading
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: provider.progress / 100,
                                        backgroundColor:
                                            AppColors.secondaryColor,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${provider.progress.toStringAsFixed(0)}%',
                                      style: const TextStyle(
                                          color: AppColors.secondaryColor),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/download.svg',
                                      color: AppColors.secondaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    const Center(
                                      child: Text(
                                        "Download without watermark",
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return const Center(
                  child: Text("No video found"),
                );
            }
          },
        ),
      )),
    );
  }
}
