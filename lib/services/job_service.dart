import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/vacancy.dart';

/*
 * БУЛ ФАЙЛ ЭМНЕГЕ КЕРЕК (жөнөкөй сөз менен):
 *
 * Backend'теги "/api/jobs/search" эндпоинти аркылуу HH.ru'дан чыныгы
 * вакансияларды издейт. Бул эндпоинт сырсөзсүз ачык (SecurityConfig'те
 * permitAll кылып койгонбуз), ошондуктан бул жерде Basic Auth керек эмес.
 */
class JobService {
  static Future<List<Vacancy>> search(String query) async {
    // Uri.parse'дын ичинде queryParameters колдонуу query'ди туура
    // "URL-коддоо" менен кошот (мисалы, боштуктарды %20'га айландырат).
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/jobs/search')
        .replace(queryParameters: {'text': query});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Сервер массив (JSON тизме) кайтарат, аны Dart List'ине чечмелейбиз.
      final List<dynamic> jsonList = jsonDecode(response.body);
      // .map(...) ар бир элементти Vacancy объектисине айландырат,
      // .toList() натыйжаны кадимки тизмеге чогултат.
      return jsonList.map((item) => Vacancy.fromJson(item)).toList();
    } else {
      throw Exception('Вакансияларды издөө учурунда ката: ${response.statusCode}');
    }
  }
}
