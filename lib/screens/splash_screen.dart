import 'package:flutter/material.dart';
import 'package:fsi_app/screens/home_page.dart';
import 'package:fsi_app/screens/login_screen.dart';
import 'package:fsi_app/widgets/navigation.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({Key? key}) : super(key: key);

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigation.withNoReturn(context, LoginScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/esusu_pay_gif.gif',
          height: 150,
        ),
      ),
    );
  }
}
