import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Home.dart';
import 'main.dart';

class Splash extends StatefulWidget {
  static const String route = '/welcome';
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Lottie.asset('images/skillbg.json', width: MediaQuery.of(context).size.width/2),
      Container(width: MediaQuery.of(context).size.width/2,child: Row(children: [
        Container(width: 130, child: Image.asset('images/iii.png', height: 130,)),
        Text('S', style: TextStyle(fontSize: 95, fontFamily: 'somewhat', color: Color(0xff3930eb), fontWeight: FontWeight.w600),),
        Text('kill', style: TextStyle(fontSize: 65, fontFamily: 'somewhat', color: Color(0xff3930eb), fontWeight: FontWeight.w600),),
        Text('S', style: TextStyle(fontSize: 95, fontFamily: 'somewhat', color: Colors.black, fontWeight: FontWeight.w600),),
        Text('hodh', style: TextStyle(fontSize: 65, fontFamily: 'somewhat', color: Colors.black, fontWeight: FontWeight.w600),),
      ],),)

    ],)));
  }
  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if(user==null){
    setState(() {
      isuser = false;
      isaccess = false;
    });
  }else{
    String? email =
        FirebaseAuth.instance.currentUser?.email;
    FirebaseFirestore.instance.collection('users').doc(email).get().then((DocumentSnapshot docs){
      if(docs.exists){
        setState(() {
          isuser = true;
          isaccess = true;
        });
      }else{
        setState(() {
          isuser = true;
          isaccess = false;
        });
      }
    });
  }
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushNamed('/home');
    });
  }
}
