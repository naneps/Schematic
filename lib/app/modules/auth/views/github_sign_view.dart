import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GithubSignInController extends GetxController {
  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    final clientId = dotenv.env['GITHUB_CLIENT_ID'];
    webViewController = WebViewController()
      ..loadRequest(
        Uri.parse(
            'https://github.com/login/oauth/authorize?client_id=$clientId&scope=read:user,user:email'),
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (url.startsWith('YOUR_REDIRECT_URL')) {
              final uri = Uri.parse(url);
              final code = uri.queryParameters['code'];
              if (code != null) {
                Get.back(result: code);
              } else {
                Get.back(result: 'Authorization failed');
              }
            }
          },
          onWebResourceError: (error) {
            Get.back(result: 'Authorization failed');
          },
          onHttpAuthRequest: (request) {
            print(request);
          },
          onPageFinished: (url) {
            print(url);
          },
        ),
      );
  }

  void refreshWeb() {
    webViewController.clearCache();
    webViewController.reload();
    // clear cache
  }
}

class GithubSignView extends GetView<GithubSignInController> {
  const GithubSignView({super.key});

  @override
  GithubSignInController get controller => Get.put(GithubSignInController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Sign In'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: controller.refreshWeb,
            ),
          ],
        ),
        body: WebViewWidget(
          controller: controller.webViewController,
        ),
      ),
    );
  }
}
