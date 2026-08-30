import 'dart:convert';

import 'package:dio/dio.dart';

class ApplePodcastAmpApi {
  Future<String?> getJwt() async {
    final dio = Dio();

    try {
      final pageResponse = await dio.get<String>(
        'https://podcasts.apple.com/jp/home',
      );
      final html = pageResponse.data ?? '';

      final jsNameReg = RegExp(r'index~[a-zA-Z0-9]+\.js');
      final jsNameMatch = jsNameReg.firstMatch(html);
      if (jsNameMatch == null) {
        return null;
      }
      final jsName = jsNameMatch.group(0)!;

      final jsResponse = await dio.get<String>(
        'https://podcasts.apple.com/assets/$jsName',
      );
      final jsText = jsResponse.data ?? '';

      final jwtReg = RegExp(
        r'eyJ[A-Za-z0-9\-_=]+\.[A-Za-z0-9\-_=]+\.[A-Za-z0-9\-_=]+',
      );
      final jwtMatch = jwtReg.firstMatch(jsText);
      if (jwtMatch == null) {
        return null;
      }

      return jwtMatch.group(0);
    } on DioException catch (e) {
      print('request failed: ${e.message}');
      return null;
    }
  }

  bool isJwtValid(String jwt) {
    try {
      final parts = jwt.split('.');
      if (parts.length != 3) return false;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> claims = jsonDecode(decoded);

      final exp = claims['exp'];
      if (exp == null) {
        return true;
      }

      final expiry = DateTime.fromMillisecondsSinceEpoch(
        (exp as int) * 1000,
        isUtc: true,
      );

      return DateTime.now().toUtc().isBefore(expiry);
    } catch (e) {
      return false;
    }
  }
}
