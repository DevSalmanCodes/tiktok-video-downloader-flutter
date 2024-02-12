import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:duration_button/duration_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../recources/colors.dart';
import '../utils/routes/route_names.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _urlController = TextEditingController();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _getClipboardText();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
    _urlController.dispose();
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

  bool _isValidUrl(String url) {
    RegExp tikTokUrlRegx =
        RegExp(r'https:\/\/(www\.|vm\.|vt\.)?tiktok\.com\/.*');
    return tikTokUrlRegx.hasMatch(url);
  }

  Future<void> _getClipboardText() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    String? clipboardText = clipboardData!.text;
    setState(() {
      _urlController.text = clipboardText!;
    });
  }

  void _handleDownloadButton() {
    if (_urlController.text.isNotEmpty && _isValidUrl(_urlController.text)) {
      if (!_isConnectionPresent()) {
        Fluttertoast.showToast(
            msg: "No internet connection.", backgroundColor: Colors.blue);
      } else {
        Navigator.pushNamed(context, RouteNames.downloadVideo,
            arguments: _urlController.text);
      }
    } else {
      Fluttertoast.showToast(msg: "Invalid URL", backgroundColor: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffix: GestureDetector(
                        onTap: _getClipboardText,
                        child: SvgPicture.asset(
                          'assets/icons/paste.svg',
                          height: 25,
                        ),
                      ),
                      hintText: "Paste the video URL",
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 2)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 2)),
                    ),
                    controller: _urlController,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                DurationButton(
                  borderRadius: BorderRadius.circular(10.0),
                  height: 70,
                  hoverColor: AppColors.primaryColor,
                  coverColor: Colors.transparent,
                  duration: const Duration(milliseconds: 500),
                  backgroundColor: AppColors.primaryColor,
                  onPressed: _handleDownloadButton,
                  child: const Center(
                      child: Text(
                    "Download",
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w700),
                  )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (!_isConnectionPresent())
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/no_internet.svg',
                    height: 40,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const Expanded(
                    child: Text(
                      'Please check your internet connection and try again!',
                    ),
                  )
                ],
              ),
            )
        ],
      )),
    );
  }
}
