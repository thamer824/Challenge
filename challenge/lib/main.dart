import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:challenge/amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'screens/entry.dart';
import 'screens/confirm.dart';
import 'screens/dashboard.dart';
import 'package:flutter_login/flutter_login.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/confirm') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                Confirm(data: settings.arguments as SignupData),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }
        if (settings.name == '/dashboard') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => Dashboard(),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }
        return MaterialPageRoute(builder: (_) => EntryScreen());
      },
    );
  }
}
