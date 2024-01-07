import 'package:client/res/navigator.dart';
import 'package:client/viewmodels/auth/auth_viewmodel.dart';
import 'package:client/views/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const AuthKit(),
    ),
  );
}

class AuthKit extends StatelessWidget {
  const AuthKit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorHelper.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0),
        fontFamily: "TitilliumWeb",
        useMaterial3: false,
      ),
      home: const OnboardingScreen(),
    );
  }
}
