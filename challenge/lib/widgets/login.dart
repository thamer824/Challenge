// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   late SignupData _data;
//   Future<String?> _onLogin(BuildContext context, LoginData data) async {
//     print(data);
//     return 'Logi syuc';
//   }

//   Future<String?> _onSignup(BuildContext context, SignupData data) async {
//     try {
//       final res = await Amplify.Auth.signUp(
//         username: data.name!,
//         password: data.password!,
//         options: CognitoSignUpOptions(
//           userAttributes: {
//             CognitoUserAttributeKey.email: data.name!,
//           },
//         ),
//       );
//       _data = data;
//       // Handle successful sign up
//       return null;
//     } on AuthException catch (e) {
//       return 'Sign up failed: ${e.message}';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: 'Awesome',
//       onLogin: (LoginData data) => _onLogin(context, data),
//       onRecoverPassword: (_) => Future.value(''),
//       onSignup: (SignupData data) => _onSignup(context, data),
//       theme: LoginTheme(primaryColor: Theme.of(context).primaryColor),
//       onSubmitAnimationCompleted: () {
//         Navigator.of(context)
//             .pushReplacementNamed('/confirm', arguments: _data);
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SignupData? _data;
  bool _isSignedIn = false;

  Future<String?> _onLogin(LoginData data) async {
    try {
      final res = await Amplify.Auth.signIn(
        username: data.name,
        password: data.password,
      );

      _isSignedIn = res.isSignedIn;
    } on AuthException catch (e) {
      if (e.message.contains('already a user which is signed in')) {
        await Amplify.Auth.signOut();
        return 'Problem logging in. Please try again.';
      }

      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  Future<String?> _onSignup(BuildContext context, SignupData data) async {
    try {
      final res = await Amplify.Auth.signUp(
        username: data.name!,
        password: data.password!,
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: data.name!,
          },
        ),
      );
      _data = data;
      // Handle successful sign up
      return null;
    } on AuthException catch (e) {
      return 'Sign up failed: ${e.message}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Welcome',
      onLogin: _onLogin,
      onRecoverPassword: (_) => Future.value(''),
      onSignup: (SignupData data) => _onSignup(context, data),
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed(
          _isSignedIn ? '/dashboard' : '/confirm',
          arguments: _data,
        );
      },
    );
  }
}
