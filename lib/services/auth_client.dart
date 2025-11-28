import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final storage = const FlutterSecureStorage();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Read token from secure storage
    final token = await storage.read(key: 'auth_token');

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.headers['Content-Type'] = 'application/json';

    return _inner.send(request);
  }
}
