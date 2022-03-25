import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/Provider/AuthProvider/auth_provider.dart';
import 'package:rest_api_app/Provider/Database/db_provider.dart';
import 'package:rest_api_app/Provider/TaskProvider/add_task_provider.dart';
import 'package:rest_api_app/Provider/TaskProvider/delete_task_provider.dart';
import 'package:rest_api_app/Styles/colors.dart';
import 'package:rest_api_app/splash.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => AddTaskProvider()),
        ChangeNotifierProvider(create: (_) => DeleteTaskProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: primaryColor,
            ),
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: primaryColor),
            primaryColor: primaryColor),
        home: const SplashScreen(),
      ),
    );
  }
}
