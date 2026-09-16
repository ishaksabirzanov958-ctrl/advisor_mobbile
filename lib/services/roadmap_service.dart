import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/roadmap_response.dart';

/*
 * БУЛ ФАЙЛ ЭМНЕГЕ КЕРЕК (жөнөкөй сөз менен):
 *
 * Backend'теги "/api/roadmap/generate" эндпоинтине сурам жиберип, колдонуучу
 * үчүн жеке окуу планын алат. Бул эндпоинт сырсөз талап кылат (SecurityConfig'те
 * ачык эмес), ошондуктан бул жерде Basic Auth (логин/сырсөз) кошобуз.
 */
class RoadmapService {
  static Future<RoadmapResponse> generate({
    required String userId,
    required String targetRole,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/roadmap/generate');

    // base64Encode менен логин:сырсөз'ду HTTP Basic Auth форматына айландырабыз —
    // серверге "мен ким экенимди" ушул аркылуу далилдейбиз.
    final credentials = base64Encode(
      utf8.encode('${ApiConfig.basicAuthUser}:${ApiConfig.basicAuthPassword}'),
    );

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $credentials',
      },
      body: jsonEncode({'userId': userId, 'targetRole': targetRole}),
    );

    if (response.statusCode == 200) {
      // jsonDecode — серверден келген JSON текстин Dart Map'ине айландырат.
      final Map<String, dynamic> json = jsonDecode(response.body);
      return RoadmapResponse.fromJson(json);
    } else {
      // Эгер сервер ката кайтарса — программаны токтотуп, каталык тууралуу билдирүү чыгарабыз.
      throw Exception('Roadmap алынбай калды: ${response.statusCode}');
    }
  }
}
