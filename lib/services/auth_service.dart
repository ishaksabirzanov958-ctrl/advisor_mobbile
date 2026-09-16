// dart:convert — JSON'ду Dart объектилерине жана тескерисинче айландыруу үчүн керек.
import 'dart:convert';
// http — HTTP-сурамдарды жиберүү үчүн негизги китепкана.
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

/*
 * БУЛ ФАЙЛ ЭМНЕГЕ КЕРЕК (жөнөкөй сөз менен):
 *
 * Бул класс backend'теги "/api/auth/register" эндпоинтине сурам жиберип,
 * жаңы колдонуучуну катайт. Java тарабындагы AuthController'дун Dart'тагы
 * "клиенти" сыяктуу.
 */
class AuthService {
  // Колдонуучуну катайт. Ийгиликтүү болсо true, ийгиликсиз болсо false кайтарат.
  static Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    // Uri.parse — сапты "дарек" (URL) объектисине айландырат.
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/auth/register');

    // http.post — серверге POST сурамын жиберет, дени JSON форматында.
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      // jsonEncode — Dart Map'ти JSON текстине айландырат (сервер so эле күтөт).
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    // statusCode 200 — баары жакшы дегенди билдирет.
    return response.statusCode == 200;
  }
}
