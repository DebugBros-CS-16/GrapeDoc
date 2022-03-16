import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  _HomeNewsState createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'https://phys.org/tags/grape/',
      onWebViewCreated: (controller) {
        this.controller = controller;
      },
      onPageStarted: (url) {

        if (url.contains('https://phys.org/tags/grape/')){
          Future.delayed(const Duration(milliseconds: 300), (){
            controller.evaluateJavascript(
                "document.getElementsByTagName('header')[0].style.display='none'");
            controller.evaluateJavascript(
                "document.getElementsByTagName('footer')[0].style.display='none'");
          });
        }
      },
    );
  }
}
