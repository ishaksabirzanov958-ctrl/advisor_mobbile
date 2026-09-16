// material.dart — Flutter'дын Google Material Design стилиндеги баскыч, талаа
// ж.б. интерфейс элементтерин берет.
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

/*
 * БУЛ ЭКРАН ЭМНЕГЕ КЕРЕК (жөнөкөй сөз менен):
 *
 * Жаңы колдонуучу колдонмого биринчи жолу кирип, аты/email/сырсөзүн
 * жазып "Катталуу" баскычын басканда, ушул экран backend'ге сурам жиберет.
 */

// StatefulWidget — бул экран ичинде өзгөрүп турган абал (мисалы, талаага
// жазылган текст) бар дегенди билдирет.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // TextEditingController — талаага жазылган текстти "тартып алуу" үчүн керек.
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Катталуу процесси жүрүп жатканда "жүктөлүп жатат" индикаторун көрсөтүү үчүн.
  bool _isLoading = false;
  String? _errorMessage;

  // "Катталуу" баскычы басылганда чакырылат.
  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // try/catch — эгер сурам учурунда ката болсо (мисалы, интернет жок),
    // колдонмо кулабай, жөн эле каталык билдирүүсүн көрсөтөт.
    try {
      final success = await AuthService.register(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (success) {
        // Катталуу ийгиликтүү болсо — башкы экранга өтөбүз.
        if (!mounted) return; // экран жабылып калбаганын текшеребиз
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(userId: _usernameController.text),
          ),
        );
      } else {
        setState(() => _errorMessage = 'Катталуу ишке ашпады. Кайра аракет кылып көрүңүз.');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Ката: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Катталуу')),
      // Padding — экрандын четинен боштук калтырат, баары четке жабышып турбашы үчүн.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Колдонуучунун аты'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              // obscureText — сырсөздү жазганда чекиттер менен жашырат.
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Сырсөз'),
            ),
            const SizedBox(height: 24),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            // Эгер _isLoading true болсо — баскычтын ордуна айланып турган
            // индикаторду көрсөтөбүз, экинчи жолу баскычты басып жиберишпес үчүн.
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: const Text('Катталуу'),
                  ),
          ],
        ),
      ),
    );
  }
}
