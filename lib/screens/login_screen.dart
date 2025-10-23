import 'package:flutter/material.dart';

// Экран входа с формой авторизации
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLoginSuccess});

  final Function(String) onLoginSuccess; // Callback при успешном входе

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Ключ для формы валидации
  final _emailController = TextEditingController(); // Контроллер для поля email
  final _passwordController = TextEditingController(); // Контроллер для поля пароль
  bool _isLoading = false; // Флаг загрузки
  String? _errorMessage; // Сообщение об ошибке

  // Метод обработки входа
  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return; // Выход, если валидация не прошла
    }

    setState(() {
      _isLoading = true; // Показать индикатор загрузки
      _errorMessage = null; // Сброс ошибки
    });

    // Имитация асинхронной авторизации (1.5 секунды)
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isLoading = false; // Скрыть индикатор
    });

    // Проверка учетных данных
    if (_emailController.text == 'test@test.com' && _passwordController.text == 'qwerty123') {
      widget.onLoginSuccess(_emailController.text); // Успешный вход
    } else {
      setState(() {
        _errorMessage = 'Неверный логин или пароль'; 
      });
    }
  }

  // Заглушка для регистрации
  void _register() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Регистрация пока не реализована')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'), 
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400), 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email', 
                      border: OutlineInputBorder(), 
                    ),
                    keyboardType: TextInputType.emailAddress, 
                    validator: (value) { 
                      if (value == null || value.isEmpty) {
                        return 'Введите email'; 
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Введите корректный email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16), 
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Пароль',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true, 
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите пароль';
                      }
                      if (value.length < 6) {
                        return 'Пароль должен быть не менее 6 символов';
                      }
                      return null;
                    },
                  ),
                  if (_errorMessage != null) ...[ // Условное отображение ошибки
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red), 
                    ),
                  ],
                  const SizedBox(height: 16),
                  _isLoading
                      ? const CircularProgressIndicator() 
                      : Column(
                          children: [
                            ElevatedButton(
                              onPressed: _login, 
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48), 
                              ),
                              child: const Text('Войти'),
                            ),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: _register,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48),
                              ),
                              child: const Text('Зарегистрироваться'),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose(); // Освобождение ресурсов контроллера
    _passwordController.dispose();
    super.dispose();
  }
}
