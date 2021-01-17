import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetcampus_mobil/screens/onboarding_screen.dart';
import 'package:meetcampus_mobil/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;
void main() async {
  //onboarding just to see once
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);

  //hide status bar
  await SystemChrome.setEnabledSystemUIOverlays([]);

  //disable rotation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'meetcampus',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: initScreen == 0 || initScreen == null ? 'first' : '/',
      routes: {
        '/': (context) => SplashScreen(),
        'first': (context) => OnboardingScreen(),
      },
    );
  }
}
