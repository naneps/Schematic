import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';

class BaseProvider extends GetConnect {
  void handleRequestError(dynamic error) {
    if (error is SocketException) {
      print('No internet connection.');
    } else if (error is TimeoutException) {
      print('Request timed out.');
    } else {
      print('An error occurred: $error');
    }
  }

  void handleResponseError(Response response) {
    switch (response.statusCode) {
      case 401:
        print('Unauthorized access. Please log in again.');
        // Call your logout logic or navigate to logout page
        break;
      case 403:
        break;
      default:
        print('An error occurred with status code: ${response.statusCode}');
        // Display a generic error message or handle specific cases
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'https://jsonplaceholder.typicode.com';

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] = 'Bearer yourToken';
      return request;
    });

    httpClient.addResponseModifier<dynamic>((request, response) {
      handleResponseError(response);
      return response;
    });

    httpClient.addAuthenticator<dynamic>((request) async {
      return request;
    });
  }
}
