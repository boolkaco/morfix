import 'package:flutter/material.dart';
import 'package:morfix/constants/app_constants.dart';
import 'package:morfix/screens/widgets.dart/navigation_controls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message.message,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      )
      ..loadRequest(Uri.parse(AppConstants.hostName));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //     centerTitle: true,
        //     title: const Text(AppConstants.appTitle),
        //     actions: [
        //       NavigationControl(controller: controller),
        //     ]),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            loadingPercentage < 100
                ? LinearProgressIndicator(
                    color: Colors.red,
                    value: loadingPercentage / 100.0,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
