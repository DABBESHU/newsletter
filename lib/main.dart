import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/news_controller.dart';
import 'controllers/theme_controller.dart';
import 'repositories/news_repository.dart';
import 'services/api_service.dart';
import 'utils/theme.dart';
import 'views/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider(
          create:
              (context) => NewsController(
                repository: NewsRepository(apiService: ApiService()),
              ),
        ),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return MaterialApp(
            title: 'NewsWave',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
