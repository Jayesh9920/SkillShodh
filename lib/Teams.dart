import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
class Teams extends StatefulWidget {
  static const String route = '/teams';
  const Teams({super.key});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  String month="", date="", time="";
  final create = TextEditingController();
  final join = TextEditingController();
  String code = '';
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  List<dynamic> mteams = [];
  List<String> mteamsss = [];
  String selectedteamcode = '';
  String selectedteamname = '';
  List<dynamic> chats = [];
  List<String> chatsss = [];
  String mail = '';
  String loggedname = '';
  String loggedpurl = '';
  final mess = TextEditingController();
  String tempteamname = '';
  bool isuser = false;
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      setState(() {
        isuser = true;
      });
      String mail = FirebaseAuth.instance.currentUser!.email!;
      FirebaseFirestore.instance.collection('users').doc(mail).get().then((DocumentSnapshot sds) {
        setState(() {
          loggedname = sds['fname']+' '+sds['lname'];
          loggedpurl = sds['purl'];
        });
      });
    }else{
      setState(() {
        isuser = false;
      });
    }
    if(user!=null){
      String mail = FirebaseAuth.instance.currentUser!.email!;
      FirebaseFirestore.instance.collection('MyTeams').doc(mail).collection('Teams').get().then((QuerySnapshot querySnapshot) {
        for(var element in querySnapshot.docs){
          String id = element.reference.id.toString();
          if(mteamsss.contains(id)){

          }else{
            Map<String, String> mk = {};
            mk['code'] = element['code'];
            mk['name'] = element['name'];
            setState(() {
              mteams.add(mk);
              mteamsss.add(element['code']);
            });
          }

        }
      });
    }
    if(user!=null){
      mail = FirebaseAuth.instance.currentUser!.email!;
      (selectedteamcode=='') ? null : FirebaseFirestore.instance.collection('Teams').doc(selectedteamcode).collection('Chats').get().then((QuerySnapshot querySnapshot) {
        for(var element in querySnapshot.docs){
          String id = element.reference.id.toString();
          if(chatsss.contains(id)){

          }else{
            Map<String, String> mk = {};
            mk['purl'] = element['purl'];
            mk['name'] = element['name'];
            mk['message'] = element['message'];
            mk['mail'] = element['mail'];
            mk['id'] = id;
            setState(() {
              chats.insert(0, mk);
              chatsss.insert(0, id);
              print(chats);
            });
          }

        }
      });
    }
    return Scaffold(body: isuser ? SingleChildScrollView(child:
    Column(children: [
      Container(color: Color(0xfff8f4f8), child: Row(children: [
        SizedBox(width: 10,),
        GestureDetector(onTap: (){
          Navigator.of(context).pushNamed('/home');
        },child: Row(children: [Image.asset('images/iii.png', height: 60,),
          Text('S', style: TextStyle(fontSize: 45, fontFamily: 'somewhat', color: Color(0xff3930eb), fontWeight: FontWeight.w600),),
          Text('kill', style: TextStyle(fontSize: 30, fontFamily: 'somewhat', color: Color(0xff3930eb), fontWeight: FontWeight.w600),),
          Text('S', style: TextStyle(fontSize: 45, fontFamily: 'somewhat', color: Colors.black, fontWeight: FontWeight.w600),),
          Text('hodh', style: TextStyle(fontSize: 30, fontFamily: 'somewhat', color: Colors.black, fontWeight: FontWeight.w600),),
        ],),),
        Spacer(),
        Container(width: 150, height: 35,child: TextField(
          cursorColor: Colors.black,controller: create, decoration: InputDecoration(fillColor: Colors.white, filled: true, contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),labelStyle: TextStyle(fontSize: 18, fontFamily: 'somewhat'),hintText: 'Team Name', enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(5))),
          style: TextStyle(fontSize: 18, fontFamily: 'somewhat'),)),
        SizedBox(width: 20,),
        GestureDetector(onTap: ()async{
          String mail = FirebaseAuth.instance.currentUser!.email!;
          setState(() {
            code = getRandomString(6);
          });
          if(create.text!=''){
            FirebaseFirestore.instance.collection('Teams').doc(code).collection('Details').doc('basic').set({
              'name': create.text,
              'code': code
            }).then((value) {
              FirebaseFirestore.instance.collection('MyTeams').doc(mail).collection('Teams').doc(code).set({
                'name': create.text,
                'code': code
              }).then((value) {
                FirebaseFirestore.instance.collection('codes').doc(code).set(
                    {'code': code,
                      'name': create.text}).then((value) {
                  create.clear();
                });
              });
            });
          }
        },
            child: Container(child: Center(child: Text("Create Team", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'somewhat'),)),width: 100, height: 35,decoration: BoxDecoration(color: Color(0xff3930eb), borderRadius: BorderRadius.circular(0)))),
        SizedBox(width: 20,),
        Container(width: 150, height: 35,child: TextField(
          cursorColor: Colors.black,controller: join, decoration: InputDecoration(fillColor: Colors.white, filled: true,contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),labelStyle: TextStyle(fontSize: 18, fontFamily: 'somewhat'),hintText: 'Team Code', enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(5))),
          style: TextStyle(fontSize: 18, fontFamily: 'somewhat'),)),
        SizedBox(width: 20,),
        GestureDetector(onTap: ()async{
          String mail = FirebaseAuth.instance.currentUser!.email!;
          if(join.text!=''){
            FirebaseFirestore.instance.collection('codes').doc(join.text).get().then((DocumentSnapshot ddcc) {
              tempteamname = ddcc['name'];
              FirebaseFirestore.instance.collection('MyTeams').doc(mail).collection('Teams').doc(join.text).set({
                'name': tempteamname,
                'code': join.text
              }).then((value) {
                join.clear();
              });
            });
          }
        },
            child: Container(child: Center(child: Text("Join Team", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'somewhat'),)),width: 100, height: 35,decoration: BoxDecoration(color: Color(0xff3930eb), borderRadius: BorderRadius.circular(0)))),
      SizedBox(width: 50,)
      ],),),
      SizedBox(height: 25,),
      (selectedteamname=='') ? SizedBox(height: 0,) : Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(selectedteamname, style: TextStyle(fontSize: 28),), SizedBox(width: 10,),Text(selectedteamcode, style: TextStyle(fontSize: 21),),IconButton(onPressed: (){
        Clipboard.setData(ClipboardData(text: selectedteamcode));
      }, icon: Icon(Icons.copy)),],),
      (selectedteamname=='') ? Container(child: Column(children: [Text('Select Team to see discussion', style: TextStyle(color: Color(0xffb319d4), fontSize: 30),),SizedBox(height: 30,),
        (mteams.length==0) ? Text("You haven't created or joined any team", style: TextStyle(fontSize: 23),) : Container(width: (MediaQuery.of(context).size.width)/5, child: ListView.builder(shrinkWrap: true, itemCount: mteams.length, itemBuilder: (BuildContext context, int y){
          return Card(child: TextButton(onPressed: (){
            setState(() {
              chats.clear();
              chatsss.clear();
              selectedteamcode = mteams[y]['code'];
              selectedteamname = mteams[y]['name'];
            });
          }, child: Text(mteams[y]['name'], style: TextStyle(fontSize: 23),)));
        }),),
      ],),) : Container(height: MediaQuery.of(context).size.height-200, width: 14*(MediaQuery.of(context).size.width)/15, child: Row(children: [
        Container(width: 150, child: Column(children: [Text('My Teams', style: TextStyle(color: Color(0xffb319d4), fontSize: 21, fontWeight: FontWeight.w600)),SizedBox(height: 30,),
          Container(width: 150, child: ListView.builder(shrinkWrap: true, itemCount: mteams.length, itemBuilder: (BuildContext context, int y){
            return Card(child: TextButton(onPressed: (){
              setState(() {
                chats.clear();
                chatsss.clear();
                selectedteamcode = mteams[y]['code'];
                selectedteamname = mteams[y]['name'];
              });
            }, child: Text(mteams[y]['name'], style: TextStyle(fontSize: 21),)));
          }),),
        ],),),
        Container(width: (14*(MediaQuery.of(context).size.width)/30)-153,),
        Container(width: (14*(MediaQuery.of(context).size.width)/30)-1,child: Column(children: [
          Container(height: 50, child: Text('Discussion', style: TextStyle(fontSize: 25, color: Color(0xffb319d4)),),),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0), child: Container(color: Colors.white, height: MediaQuery.of(context).size.height-308,
            child: ListView.builder(shrinkWrap: true,
                reverse: true,
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int g){
              return Row(mainAxisAlignment: (mail == chats[g]['mail'])
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,children: [
                    Container(width: (13*(MediaQuery.of(context).size.width)/80),
                      child: Wrap(alignment: (mail == chats[g]['mail'])
                          ? WrapAlignment.end
                          : WrapAlignment.start,
                      children: [
                        Card(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(child: Padding(padding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5), child: Column(children: [
                    Row(children: [CachedNetworkImage(
                      imageUrl: chats[g]['purl'],
                      progressIndicatorBuilder: (_, url, download) {
                        if (download.progress != null) {
                          final percent = download.progress! * 100;
                          return Center(
                            child: CircularProgressIndicator(
                                color: const Color(0xff8a8989),
                                value: percent),
                          );
                        }

                        return const Text("");
                      },
                      imageBuilder: (context, imageProvider) =>
                          Container(
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),Text('  '+chats[g]['name'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),],),
                          Row(children: [Container(width: (10*(MediaQuery.of(context).size.width)/80), child: Text(chats[g]['message'], style: TextStyle(fontSize: 16),),)],)
                        ],)),),)
                      ],),)
              ],);
            }),),),
          SizedBox(height: 3,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0), child: Container(height: 1, color: Color(0xffb319d4),),),
          Container(height: 3,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0), child: Container(color: Colors.white, child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Container(width: 300, height: 50,child: TextField(
            cursorColor: Colors.black,controller: mess, decoration: InputDecoration(fillColor: Colors.white, filled: true, contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),labelStyle: TextStyle(fontSize: 18, fontFamily: 'somewhat '),hintText: 'Type message...', enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(5))),
            style: TextStyle(fontSize: 18, fontFamily: 'somewhat'),)),
            GestureDetector(onTap: (){
              if(loggedname!=''){
                int mon = DateTime.now().month;
                int cuurdate = DateTime.now().day;
                date = cuurdate.toString();
                int hour = DateTime.now().hour;
                int hours = hour;
                int minute = DateTime.now().minute;
                String state = "";
                if(hour<12){
                  state = "a.m.";
                }else{state = "p.m.";}
                if(hour>12){
                  hour = hour-12;
                }
                if(minute<10){
                  time = "$hour:0$minute $state";
                }else{
                  time = "$hour:$minute $state";
                }
                int sec = DateTime.now().second;
                String amonth = (mon<10) ? "0$mon" : "$mon";
                String adate = (cuurdate<10) ? "0$cuurdate" : "$cuurdate";
                String ahour = (hours<10) ? "0$hours" : "$hours";
                String aminute = (minute<10) ? "0$minute" : "$minute";
                String asecond = (sec<10) ? "0$sec" : "$sec";


                String newid = amonth+adate+ahour+aminute+asecond;
                FirebaseFirestore.instance.collection('Teams').doc(selectedteamcode).collection('Chats').doc(newid).set(
                    {
                      'name': loggedname,
                      'message': mess.text,
                      'purl': loggedpurl,
                      'mail': mail
                    }).then((value) => mess.clear());
              }
            },
                child: Container(child: Center(child: Text("Send", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'somewhat'),)),width: 100, height: 35,decoration: BoxDecoration(color: Color(0xff3930eb), borderRadius: BorderRadius.circular(0)))),
          ],),),),

        ],),)
      ],),)
    ],),) :

    Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(height: 60, color: Color(0xfff8f4f8),
        child: Row(
          children: [
            SizedBox(width: 10,),
            GestureDetector(onTap: (){
              Navigator.of(context).pushNamed('/home');
            },child: Row(children: [Image.asset('images/iii.png', height: 60,),
              Text('S', style: TextStyle(fontSize: 45, fontFamily: 'somewhat', color: Color(0xff3930eb), fontWeight: FontWeight.w600),),
              Text('kill', style: TextStyle(fontSize: 30, fontFamily: 'somewhat', color: Color(0xff3930eb), fontWeight: FontWeight.w600),),
              Text('S', style: TextStyle(fontSize: 45, fontFamily: 'somewhat', color: Colors.black, fontWeight: FontWeight.w600),),
              Text('hodh', style: TextStyle(fontSize: 30, fontFamily: 'somewhat', color: Colors.black, fontWeight: FontWeight.w600),),
            ],),),
          ],
        ),
      ),
    SizedBox(height: 200,),
    Center(child: Text('Please login to access this page', style: TextStyle(fontSize: 28, color: Color(0xffb319d4))),
    ),
    SizedBox(height: 15,),
    GestureDetector(onTap: (){
    Navigator.of(context).pushNamed('/home');
    },
    child: Container(child: Center(child: Text("Home", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'somewhat'),)),width: 100, height: 35,decoration: BoxDecoration(color: Color(0xff3930eb), borderRadius: BorderRadius.circular(0)))),

    ],)
    );
  }
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
