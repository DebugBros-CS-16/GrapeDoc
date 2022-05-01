import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grapedoc_test/services/t_key.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  late WebViewController controller;

  void loadHtml() async {
    final html = await rootBundle.loadString("assets/local_html/PrivacyPolicy.html");

    final url = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();

    controller.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(TKeys.policy.translate(context)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions:[
          IconButton(
              onPressed: null,
              padding: const EdgeInsets.only(right: 20.0),
              icon: const Icon(
                Icons.admin_panel_settings_sharp,
                color: Colors.white,
              )
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        padding: const EdgeInsets.all(10.0),
        decoration: (
            BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.black12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            )
        ),
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            this.controller = controller;

            loadHtml();
          },
        ),
      ),
    );
  }
}
