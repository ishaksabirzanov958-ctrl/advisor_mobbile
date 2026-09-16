import 'package:flutter/material.dart';
import '../models/roadmap_response.dart';
import '../services/roadmap_service.dart';

/*
 * БУЛ ЭКРАН ЭМНЕГЕ КЕРЕК (жөнөкөй сөз менен):
 *
 * Колдонуучу каалаган ролдун атын жазат ("AI-Powered Backend Engineer" ж.б.),
 * "Түз" баскычын басат — backend Neo4j графынан анын жетишпеген көндүмдөрүн
 * тапып, Spring AI аркылуу окуу планын түзүп, ушул жерге кайтарат.
 */
class RoadmapScreen extends StatefulWidget {
  final String userId; // катталган колдонуучунун аты

  const RoadmapScreen({super.key, required this.userId});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  final _roleController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  RoadmapResponse? _result; // натыйжаны бул жерде сактайбыз, ал келгенде экранга чыгарабыз

  Future<void> _generate() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _result = null;
    });

    try {
      final result = await RoadmapService.generate(
        userId: widget.userId,
        targetRole: _roleController.text,
      );
      setState(() => _result = result);
    } catch (e) {
      setState(() => _errorMessage = 'Ката: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Окуу жол картасы')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // SingleChildScrollView — тарбактыгы жогорку, экран сыйдырбаган
        // маалыматты (мисалы, узун roadmapText) жылдырып көрсөтөт.
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _roleController,
                decoration: const InputDecoration(
                  labelText: 'Каалаган роль (мисалы, Java Backend Engineer)',
                ),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _generate,
                      child: const Text('Жол картасын түз'),
                    ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              ],
              // Эгер натыйжа бар болсо гана — аны экранга чыгарабыз.
              if (_result != null) ...[
                const SizedBox(height: 24),
                Text(
                  'Жетишпеген көндүмдөр:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // .map().toList() ар бир көндүмдү өзүнчө "чип" (тегерек баскыч) катары көрсөтөт.
                Wrap(
                  spacing: 8,
                  children: _result!.missingSkills
                      .map((skill) => Chip(label: Text(skill)))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Окуу планы:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(_result!.roadmapText),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
