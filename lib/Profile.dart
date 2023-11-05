import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'getter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'dart:html' as html;

class Profile extends StatefulWidget {
  static String route = '/profile';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String fname = '', lname = '', bio = '', college='', year ='', lurl = '', purl='';
  List<dynamic> projects = [];
  List<dynamic> skillslevel = [];
  List<dynamic> selectedskills = [];
  List<Users> list = [];
  List<String> lists = [];
  bool error = false;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      for(var element in querySnapshot.docs){
        String id = element.reference.id.toString();
        if(selectedskills.isEmpty){
          if(lists.contains(id)){
          }else{
            if(profmail==id){

            }else{
              Users user = Users(fname: element['fname'], lname: element['lname'], bio: element['bio'], college: element['college'], year: element['year'], lurl: element['lurl'], skills: element['skills'], skillslevel: element['skillslevel'], projects: element['projects'], mail: id, purl: element['purl']);
              setState(() {
                list.add(user);
                lists.add(id);
              });
            }

          }
        }else{
          int y=0;
          for(int t=0; t<selectedskills.length; t++){
            if(element['skills'].contains(selectedskills[t])){
              if(lists.contains(id)){
              }else{
                if(profmail==id){

                }else{
                  Users user = Users(fname: element['fname'], lname: element['lname'], bio: element['bio'], college: element['college'], year: element['year'], lurl: element['lurl'], skills: element['skills'], skillslevel: element['skillslevel'], projects: element['projects'], mail: id, purl: element['purl']);
                  setState(() {
                    list.insert(0, user);
                    lists.insert(0, id);
                  });
                }
              }
            }else{
              if(lists.contains(id)){
              }else{
                if(profmail==id){

                }else{
                  Users user = Users(fname: element['fname'], lname: element['lname'], bio: element['bio'], college: element['college'], year: element['year'], lurl: element['lurl'], skills: element['skills'], skillslevel: element['skillslevel'], projects: element['projects'], mail: id, purl: element['purl']);
                  setState(() {
                    list.add(user);
                    lists.add(id);
                  });
                }
              }
            }
          }
        }





      }
    });
    return Scaffold(body: Column(children: [
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
      Container(height: MediaQuery.of(context).size.height-70, child: Row(children: [

        error ? Container(width: 5*(MediaQuery.of(context).size.width/7)-1, child: Center(child: Lottie.asset('images/nodata.json'),),) :
        Container(width: 5*(MediaQuery.of(context).size.width/7)-1, child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 3*(MediaQuery.of(context).size.width/7)-2.5, child: SingleChildScrollView(child: Column(children: [
            SizedBox(height: 20,),
            Row(children: [SizedBox(width: 50), CachedNetworkImage(
              imageUrl: purl,
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
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            ), SizedBox(width: 30,), Column(children: [Text(fname+' '+lname, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
            Text(college+', '+year+' Year', style: TextStyle(fontSize: 22),)],)
            ],),
            IconButton(onPressed: (){
              html.window.open(lurl,"_blank");
            }, icon: Image.asset('images/link.png', width: 120,)),
            Padding(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 0), child: Text(bio, style: TextStyle(fontSize: 18),),)
            
          ],),),),
          Container(color: Colors.black, width: 1.5,),
          Container(width: 2*(MediaQuery.of(context).size.width/7), child: SingleChildScrollView(child: Column(children: [
            SizedBox(height: 10,),
            (skillslevel.isNotEmpty) ? Column(children: [Text('Skills', style: TextStyle(fontFamily: 'somewhat', fontSize: 24),), SizedBox(height: 5,)],) : SizedBox(height: 0,),
            (skillslevel.isNotEmpty) ? Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0), child: Container(
              child: ListView.builder(shrinkWrap: true, itemCount: skillslevel.length, itemBuilder: (BuildContext context, int z){
                return Card(child: Container(height: 60,child: Column(
                  children: [
                    Row(children: [
                      SizedBox(width: 10,),
                      Container(width: (MediaQuery.of(context).size.width/7)-10, child: Text(skillslevel[z]['skill'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'somewhat', color: Color(0xff3930eb)),)),
                      SizedBox(width: 10,),
                      Container(width: (MediaQuery.of(context).size.width/7)-40,
                        child: Slider(value: skillslevel[z]['level'], onChanged: null, min: 0, max: 2, divisions: 2, activeColor: Color(0xffb319d4),),
                      ),
                    ],),
                    SizedBox(height: 5,),
                  ],
                ),),);
              }),
            ),) : SizedBox(height: 0,),
            (projects.isNotEmpty) ? Column(children: [Text('Projects', style: TextStyle(fontFamily: 'somewhat', fontSize: 24),), SizedBox(height: 5,)],) : SizedBox(height: 0,),
            (projects.isNotEmpty) ? Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0), child: Container(
              child: ListView.builder(physics: NeverScrollableScrollPhysics(), itemCount: projects.length, shrinkWrap: true, itemBuilder: (BuildContext context, int i){
                return Card(child: Center(
                  child: Container(width: 2*(MediaQuery.of(context).size.width/7)-20, child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Container(width: 2*(MediaQuery.of(context).size.width/7)-90,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${i+1}.'+projects[i]['topic'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'somewhat')),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(width: (MediaQuery.of(context).size.width/2)-140,child: Text('     '+projects[i]['info'], style: TextStyle(fontSize: 16, fontFamily: 'somewhat'),)),
                  ],),),
                ),);
              }),
            ),) : SizedBox(height: 0,)
          ],),),)
        ],)),


        Container(width: 2, color: Colors.black,),
        Container(width: 2*(MediaQuery.of(context).size.width/7)-1, child: SingleChildScrollView(child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: list.length, itemBuilder: (BuildContext context, int i){
              return GestureDetector(onTap: (){
                profmail = list[i].mail;
                Navigator.of(context).pushNamed('/profile/'+profmail);
              }, child: Card(child: Container(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 10,),
                Row(children: [
                  SizedBox(width: 10,),
                  CachedNetworkImage(
                    imageUrl: list[i].purl,
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
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: 3*(MediaQuery.of(context).size.width/16) - 60,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(list[i].fname+' '+list[i].lname, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                      Text(list[i].year+' Year, '+list[i].college, style: TextStyle(fontSize: 12, color: Colors.grey),)
                    ],),
                  )
                ],),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text((list[i].skills.toString().replaceAll('[', '').replaceAll(']', '').length>85) ? list[i].skills.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', ' |').substring(0,85)+'...' : list[i].skills.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', ' |'), style: TextStyle(color: Colors.indigo),),
                ),
                SizedBox(height: 15,)
              ],),)));
            }),
          )
        ],),),)
      ],),)
    ],),);
  }

  @override
  void initState() {
    if(profmail==''){

    }else{
      FirebaseFirestore.instance.collection('users').doc(profmail).get().then((DocumentSnapshot documentSnapshot) {
        if(documentSnapshot.exists){
          setState(() {
            fname = documentSnapshot['fname'];
            lname = documentSnapshot['lname'];
            bio = documentSnapshot['bio'];
            college = documentSnapshot['college'];
            year = documentSnapshot['year'];
            lurl = documentSnapshot['lurl'];
            purl = documentSnapshot['purl'];
            projects = documentSnapshot['projects'];
            skillslevel = documentSnapshot['skillslevel'];
            selectedskills = documentSnapshot['skills'];
            print(selectedskills);
          });
        }else{
          setState(() {
            error = true;
          });
        }
      });
    }
  }
}
