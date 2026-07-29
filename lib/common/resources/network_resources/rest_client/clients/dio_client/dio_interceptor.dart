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
    final existingContentType = options.headers['content-type'] ??
        options.headers['Content-Type'] ??
        options.contentType;
    final existingAccept =
        options.headers['accept'] ?? options.headers['Accept'];

    options.headers.remove('Authorization');
    options.headers.remove('authorization');

    options.headers['Authorization'] =
        "Bearer ${await LocalClient.getString(key: LocalKeys.accessToken)}";

    if (existingAccept != null) {
      options.headers['Accept'] = existingAccept;
    }

    final isFormData = options.data is FormData;
    if (!isFormData &&
        (existingContentType == null ||
            existingContentType.toString().isEmpty)) {
      options.headers['content-type'] = 'application/json';
      options.contentType = 'application/json';
    } else if (existingContentType != null) {
      options.headers['content-type'] = existingContentType;
    }

    client.logRequest(options);
    super.onRequest(options, handler);
  }
}
