import 'package:flutter/material.dart';
import 'package:flutter_auth_app/screens/login_screen.dart';
import 'package:flutter_auth_app/screens/welcome_screen.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth App', 
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), 
        useMaterial3: false, 
      ),
      home: const AuthWidget(), 
    );
  }
}

// Виджет для управления авторизацией (переключение между экранами входа и приветствия)
class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  String? _loggedInEmail; // Email авторизованного пользователя, null если не авторизован

  // Обработчик успешного входа - устанавливает email и обновляет состояние
  void _onLoginSuccess(String email) {
    setState(() {
      _loggedInEmail = email;
    });
  }

  // Обработчик выхода - сбрасывает состояние авторизации
  void _onLogout() {
    setState(() {
      _loggedInEmail = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Если пользователь авторизован, показываем экран приветствия, иначе - входа
    if (_loggedInEmail != null) {
      return WelcomeScreen(email: _loggedInEmail!, onLogout: _onLogout);
    } else {
      return LoginScreen(onLoginSuccess: _onLoginSuccess);
    }
  }
}
