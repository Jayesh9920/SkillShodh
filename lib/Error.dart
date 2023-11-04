import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Error extends StatefulWidget {
  const Error({super.key});

  @override
  State<Error> createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(children: [Lottie.asset('images/error.json'),
      GestureDetector(onTap: (){
        Navigator.of(context).pushNamed('/home');
      },
          child: Container(child: Center(child: Text("Back to Home", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'somewhat'),)),width: 150, height: 45,decoration: BoxDecoration(color: Color(0xff3930eb), borderRadius: BorderRadius.circular(0)))),
    ],),),);
  }
}
