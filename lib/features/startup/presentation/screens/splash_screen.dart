import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_sense/core/constants/assets.dart';
import 'package:task_sense/core/extensions/context_extension.dart';

class SplashScreen extends StatefulWidget {
  static const String path = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      //context.push()
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createBody(context),
    );
  }

  _createBody(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.iconsLogo,
            height: 130,
            width: 130,
          ).animate().fadeIn().scale(duration: 600.ms).move(
              delay: 500.ms,
              duration: 600.ms) // runs after the above w/new duration
          ,
          const SizedBox(
            height: 12,
          ),
          Text(
            'Daily TO-DO App',
            style: GoogleFonts.sigmar(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
