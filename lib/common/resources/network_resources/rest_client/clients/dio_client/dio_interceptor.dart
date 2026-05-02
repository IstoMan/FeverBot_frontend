import 'package:dio/dio.dart';
import 'package:manifesto/common/resources/storage_resources/local_client.dart';
import 'package:manifesto/common/resources/storage_resources/local_keys.dart';

import 'dio_client.dart';

class DioInterceptor extends Interceptor {
  final DioClient client;
  final String? token;

  DioInterceptor(this.client, {this.token});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.clear();

    options.headers.addAll({
      "content-type": "application/json",
      "Authorization": "Bearer ${await LocalClient.getString(
        key: LocalKeys.accessToken,
      )}",
    });
    client.logRequest(options);
    super.onRequest(options, handler);
  }
}
