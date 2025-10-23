import 'package:flutter/material.dart';

// Экран приветствия после успешной авторизации
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.email, required this.onLogout});

  final String email; 
  final VoidCallback onLogout; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добро пожаловать'), 
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400), 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Text(
                  'Добро пожаловать, $email!', 
                  textAlign: TextAlign.center, 
                  style: Theme.of(context).textTheme.headlineMedium, 
                ),
                const SizedBox(height: 32), 
                ElevatedButton(
                  onPressed: onLogout, // Обработчик выхода
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48), 
                  ),
                  child: const Text('Выйти'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
