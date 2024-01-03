import 'package:client/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const AuthKit());
}

class AuthKit extends StatelessWidget {
  const AuthKit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "TitilliumWeb",
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/nest.svg',
              height: 90,
            ),
            const SizedBox(height: 15),
            Text(
              "Nest AuthKit",
              style: TextStyle(
                  fontSize: 30,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
