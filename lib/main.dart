import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skillshodh/EditProfile.dart';
import 'package:skillshodh/Splash.dart';
import 'Profile.dart';
import 'Home.dart';
import 'firebase_options.dart';
bool isuser = false;
bool isaccess = false;
String profmail = 'solutionsstartapp@gmail.com';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyCiIHbdakKCuRnTbh5AD2iKlXkX8Nfa8Lk",
        authDomain: "skillshodh.firebaseapp.com",
        projectId: "skillshodh",
        storageBucket: "skillshodh.appspot.com",
        messagingSenderId: "812634494757",
        appId: "1:812634494757:web:4e6fa4bf6f3f6b1e9faccc",
        measurementId: "G-V2K4SD5P92"),);
  }else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill Shodh',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}
