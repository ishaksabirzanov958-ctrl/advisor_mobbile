import 'package:flutter/material.dart';
// url_launcher жок болгондуктан, вакансиянын шилтемесин азырынча жөн эле
// текст катары көрсөтөбүз (кийин "url_launcher" пакетин кошуп, чыкылдатса
// браузерде ачылчу кылса болот).
import '../models/vacancy.dart';
import '../services/job_service.dart';

/*
 * БУЛ ЭКРАН ЭМНЕГЕ КЕРЕК (жөнөкөй сөз менен):
 *
 * Колдонуучу сурам жазат ("Java Backend" ж.б.), "Издөө" баскычын басат —
 * backend HH.ru'нун ачык API'сине кайрылып, чыныгы, учурдагы вакансияларды
 * табат жана бул жерге тизме катары кайтарат.
 */
class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final _queryController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  List<Vacancy> _vacancies = [];

  Future<void> _search() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await JobService.search(_queryController.text);
      setState(() => _vacancies = results);
    } catch (e) {
      setState(() => _errorMessage = 'Ката: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вакансия издөө (HH.ru)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _queryController,
                    decoration: const InputDecoration(
                      labelText: 'Мисалы: Java Backend',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _search,
                  child: const Text('Издөө'),
                ),
              ],
            ),
            if (_isLoading) const Padding(
              padding: EdgeInsets.only(top: 16),
              child: CircularProgressIndicator(),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 8),
            // Expanded — калган бүт орунду ээлейт, ошондо тизме толук көрүнөт.
            Expanded(
              // ListView.builder — тизме узун болсо да, экранга көрүнбөй турган
              // элементтерди түзбөй, тез иштейт (мисалы, вакансия көп болгондо).
              child: ListView.builder(
                itemCount: _vacancies.length,
                itemBuilder: (context, index) {
                  final vacancy = _vacancies[index];
                  return Card(
                    child: ListTile(
                      title: Text(vacancy.title),
                      subtitle: Text('${vacancy.employer}\n${vacancy.description}'),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
