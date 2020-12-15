import 'package:cse310_blog_site/Auth/AuthWrapper.dart';
import 'package:cse310_blog_site/Screens/OnboardingScreen.dart';
import 'package:cse310_blog_site/Service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool loaded = sharedPreferences.getBool('loaded') == null
      ? false
      : sharedPreferences.getBool('loaded');
  runApp(
    MyApp(
      loaded: loaded,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool loaded;
  MyApp({
    this.loaded,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) =>
              AuthenticationService(firebaseAuth: FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: "Dev Blogs",
        debugShowCheckedModeBanner: false,
        home: !loaded ? App() : AuthenticationWrapper(),
      ),
    );
  }
}
