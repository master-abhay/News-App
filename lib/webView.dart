import 'package:flutter/material.dart';
import 'package:app_news/webViewStack.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'navigationControls.dart';

class WebView extends StatefulWidget {
  const WebView({super.key, required this.url});

  final String url;
  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {



  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(widget.url),
      );


    return Scaffold(
      appBar: AppBar(
        title: const Text("Early News"),
        actions: [
          NavigationControls(controller: controller),
        ],
        ),
      body: WebViewStack(controller: controller,),
    );
  }
}
