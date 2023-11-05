import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:skillshodh/Splash.dart';

class EditProfile extends StatefulWidget {
  static const String route = '/edit_profile';
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final bio = TextEditingController();
  final linkedin = TextEditingController();
  final topic = TextEditingController();
  final info = TextEditingController();
  List<dynamic> projects = [];
  List<String> colleges = <String>[
    'College',
    'IIT Kharagpur'
  ];
  List<String> years = <String>[
    'Year',
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th'
  ];
  String year = 'Year';
  String college = 'College';
  List<String> planguage = ['Python', 'Java',
    'C#',
    'PHP',
    'C++',
    'Ruby', 'Swift', 'TypeScript', 'Go',
    'Kotlin',
    'Rust', 'MATLAB',
    'R', 'Objective-C', 'Dart'];
  List<bool> planguagebool = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
  List<String> technical = [
    'Development and Operations',
    'Android Development',
    'AI and Data Science',
    'Blockchain',
    'QA',
    'Software Architecture',
    'ASP.NET Core',
    'Flutter',
    'Cyber Security',
    'UI/UX Design',
    'React Native',
    'Game Development',
    'Computer Science',
    'React',
    'Angular',
    'Go',
    'GraphQL',
    'Docker',
    'Kubernetes',
    'MongoDB',
    'AWS',
    'Computer Graphics'];
  List<bool> technicalbool = [false, false, false, false, false, false,false, false, false, false, false, false,false, false, false, false, false, false,false, false, false, false, false, false,false, false, false, false, false, false,false, false, false, false, false, false,false];
  List<String> others = ['Digital Marketing', 'Finance', 'Product Management', 'Supply chain', 'Consulting',
    'Quant'];
  List<bool> othersbool = [false, false, false, false, false, false];
  List<dynamic> selectedskills = [];
  List<dynamic> selectedskillslevel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: Column(children: [
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
            Spacer(),
            IconButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed('/welcome');
            }, icon: Icon(Icons.logout_sharp, size: 28, color: Color(0xff3930eb))),
            SizedBox(width: 30,)
          ],
        ),
      ),
      Text('Profile', style: TextStyle(fontSize: 35),),
      Container(
        height: MediaQuery.of(context).size.height-200,
        child: Row(children: [
          Container(width: (MediaQuery.of(context).size.width/2)-1, child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 10,),
              Container(width: (MediaQuery.of(context).size.width/2)-100,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CachedNetworkImage(
                      imageUrl: FirebaseAuth.instance.currentUser!.photoURL!,
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
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                    Container(width: 150, height: 50,child: TextField(
                      cursorColor: Colors.black,controller: fname, decoration: InputDecoration(fillColor: Colors.white, filled: true, contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),labelStyle: TextStyle(fontSize: 18, fontFamily: 'somewhat'),labelText: 'First Name', alignLabelWithHint: true, enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(5))),
                      style: TextStyle(fontSize: 18, fontFamily: 'somewhat'),)),
                    Container(width: 150, height: 50,child: TextField(
                      cursorColor: Colors.black,controller: lname, decoration: InputDecoration(fillColor: Colors.white, filled: true,contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),labelStyle: TextStyle(fontSize: 18, fontFamily: 'somewhat'),labelText: 'Last Name', alignLabelWithHint: true, enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(5))),
                      style: TextStyle(fontSize: 18, fontFamily: 'somewhat'),)),
                  ],
                ),
              ),


              SizedBox(height: 10,),

              Container(
                width: (MediaQuery.of(context).size.width/2)-100,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 170,
                      height: 50,
                      child: DropdownButtonFormField<String>(
                        value: college,
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            //
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)), // <-- SEE HERE
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                            BorderSide(color: Colors.black, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        dropdownColor: Colors.white,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            college = value!;
                          });
                        },
                        items: colleges
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: (value=='College' ? Colors.grey : Colors.black),
                                  fontSize: 16,
                                  fontFamily: 'somewhat'),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 50,
                      child: DropdownButtonFormField<String>(
                        value: year,
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            //
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)), // <-- SEE HERE
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                            BorderSide(color: Colors.black, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        dropdownColor: Colors.white,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            year = value!;
                          });
                        },
                        items: years
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: (value=='Year' ? Colors.grey : Colors.black),
                                  fontFamily: 'somewhat'),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(width: (MediaQuery.of(context).size.width/2)-100, height: 50, child: TextField(
                cursorColor: Colors.black,controller: linkedin, decoration: InputDecoration(fillColor: Colors.white, filled: true,contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),prefixIconConstraints: BoxConstraints(maxWidth: 60, maxHeight: 60), prefixIcon: Padding(padding: EdgeInsets.all(10), child: Image.asset('images/linkedIn.png')),labelText: 'LinkedIn Url', alignLabelWithHint: true, enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(5))),
                style: TextStyle(fontSize: 16, fontFamily: 'somewhat'),)),

              SizedBox(height: 20,),
              Container(width: (MediaQuery.of(context).size.width/2)-100, child: TextField(minLines: 2, maxLines: 4,
                cursorColor: Colors.black,controller: bio, decoration: InputDecoration(fillColor: Colors.white, filled: true,labelText: 'Your Bio', alignLabelWithHint: true, enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(5))),
                style: TextStyle(fontSize: 16, fontFamily: 'somewhat'),)),

              SizedBox(height: 10,),



              Container(width: (MediaQuery.of(context).size.width/2)-100, child: Row(children: [Text('Projects:', style: TextStyle(fontWeight: FontWeight.w200, fontFamily: 'somewhat', fontSize: 15),)],),),
              SizedBox(height: 10,),
              Container(width: (MediaQuery.of(context).size.width/2)-100,
                child: ListView.builder(physics: NeverScrollableScrollPhysics(), itemCount: projects.length, shrinkWrap: true, itemBuilder: (BuildContext context, int i){
                  return Card(child: Center(
                    child: Container(width: (MediaQuery.of(context).size.width/2)-120, child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Container(width: (MediaQuery.of(context).size.width/2)-180,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${i+1}.'+projects[i]['topic'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'somewhat')),
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(onPressed: (){
                            setState(() {
                              projects.removeAt(i);
                            });
                          }, icon: Icon(Icons.remove_circle, color: Colors.red, size: 23,)),
                          SizedBox(width: 10,)
                        ],
                      ),
                      Container(width: (MediaQuery.of(context).size.width/2)-140,child: Text('     '+projects[i]['info'], style: TextStyle(fontSize: 16, fontFamily: 'somewhat'),)),
                    ],),),
                  ),);
                }),
              ),
              SizedBox(height: 10,),

              Container(width: (MediaQuery.of(context).size.width/2)-100, height: 50, child: TextField(
                cursorColor: Colors.black,controller: topic, decoration: InputDecoration(fillColor: Colors.white, filled: true,contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),labelText: 'Project/Internship', alignLabelWithHint: true, enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(5))),
                style: TextStyle(fontSize: 18, fontFamily: 'somewhat'),)),
              SizedBox(height: 10,),
              Container(width: (MediaQuery.of(context).size.width/2)-100, child: TextField(minLines: 2,maxLines: 3,
                cursorColor: Colors.black,controller: info, decoration: InputDecoration(fillColor: Colors.white, filled: true, labelText: 'Project/Internship Description', alignLabelWithHint: true, enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(5))),
                style: TextStyle(fontSize: 18, fontFamily: 'somewhat'),)),
              SizedBox(height: 10,),
              GestureDetector(onTap: (){
                setState(() {
                  Map<String, String> map = {};
                  map['topic'] = topic.text;
                  map['info'] = info.text;
                  projects.add(map);
                  info.clear();
                  topic.clear();
                });
              },
                  child: Container(child: Center(child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'somewhat'),)),width: 80, height: 45,decoration: BoxDecoration(color: Color(0xff3930eb), borderRadius: BorderRadius.circular(0)))),
              SizedBox(height: 20,),






            ],),
          ),),





          Container(color: Colors.black, width: 2,),
          Container(height: MediaQuery.of(context).size.height-100,width: (MediaQuery.of(context).size.width/2)-1, child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 10,),
              (selectedskillslevel.isNotEmpty) ? Column(children: [Text('Selected Skills', style: TextStyle(fontFamily: 'somewhat', fontSize: 21),), SizedBox(height: 5,)],) : SizedBox(height: 0,),
              (selectedskillslevel.isNotEmpty) ? Container(width: (MediaQuery.of(context).size.width/2)-41,
                child: ListView.builder(shrinkWrap: true, itemCount: selectedskillslevel.length, itemBuilder: (BuildContext context, int z){
                  return Card(child: Container(height: 73,child: Column(
                    children: [
                      Row(children: [
                        SizedBox(width: 25,),
                        Container(width: 180, child: Text(selectedskillslevel[z]['skill'], style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'somewhat', color: Color(0xff3930eb)),)),
                        SizedBox(width: 25,),
                        Container(width: 300,
                          child: Column(
                            children: [
                              Slider(value: selectedskillslevel[z]['level'], onChanged: (valye){
                                setState(() {
                                  selectedskillslevel[z]['level'] = valye;
                                });
                              }, min: 0, max: 2, divisions: 2, activeColor: Color(0xffb319d4),),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('Begineer', style: TextStyle(fontSize: 14, fontFamily: 'somewhat', fontWeight: FontWeight.w600),), Text('Intermediate', style: TextStyle(fontSize: 14, fontFamily: 'somewhat', fontWeight: FontWeight.w600),), Text('Advance', style: TextStyle(fontSize: 14, fontFamily: 'somewhat', fontWeight: FontWeight.w600))],)
                            ],
                          ),
                        ),
                      ],),
                      SizedBox(height: 5,),
                    ],
                  ),),);
                }),
              ) : SizedBox(height: 0,),
              Row(
                children: [
                  SizedBox(width: 15,),
                  Text('Programming Languages', style: TextStyle(fontFamily: 'somewhat', fontSize: 20, color: Color(0xff3930eb)),),],
              ),
              Container(
                width: (MediaQuery.of(context).size.width/2)-41,
                child: GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: planguage.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                childAspectRatio: 2.5), itemBuilder: (BuildContext context, int i){
                  if(selectedskills.contains(planguage[i])){
                    planguagebool[i] = true;
                  }
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        planguagebool[i] = !planguagebool[i];
                      });
                      if(planguagebool[i]==true){
                        setState(() {
                          selectedskills.add(planguage[i]);
                          Map<String, dynamic> map = {};
                          map['skill'] = planguage[i];
                          map['level'] = 1;
                          selectedskillslevel.add(map);
                        });
                      }else{
                        setState(() {
                          selectedskills.remove(planguage[i]);
                          for(int h=0; h<selectedskillslevel.length; h++){
                            if(selectedskillslevel[h]['skill']==planguage[i]){
                              selectedskillslevel.removeAt(h);
                              break;
                            }
                          }
                        });
                      }
                    },
                    child: Card(child: Container(width: 100, height: 5,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 5,),
                        Container(width: (MediaQuery.of(context).size.width/8)-56,child: Text(planguage[i], style: TextStyle(fontFamily: 'somewhat', fontSize: 14),)),
                        Checkbox(side: BorderSide(width: 1, color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),activeColor: Color(0xff3930eb),value: planguagebool[i], onChanged: (value){
                          setState(() {
                            planguagebool[i] = value!;
                          });
                          if(planguagebool[i]==true){
                            setState(() {
                              selectedskills.add(planguage[i]);
                              Map<String, dynamic> map = {};
                              map['skill'] = planguage[i];
                              map['level'] = 1;
                              selectedskillslevel.add(map);
                            });
                          }else{
                            setState(() {
                              selectedskills.remove(planguage[i]);
                              for(int h=0; h<selectedskillslevel.length; h++){
                                if(selectedskillslevel[h]['skill']==planguage[i]){
                                  selectedskillslevel.removeAt(h);
                                  break;
                                }
                              }
                            });
                          }
                        })
                      ],),
                    ),),
                  );
                }),
              ),

              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 15,),
                  Text('Technical', style: TextStyle(fontFamily: 'somewhat', fontSize: 20, color: Color(0xff3930eb)),),],
              ),
              Container(
                width: (MediaQuery.of(context).size.width/2)-41,
                child: GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: technical.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2.5), itemBuilder: (BuildContext context, int i){
                  if(selectedskills.contains(technical[i])){
                    technicalbool[i] = true;
                  }
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        technicalbool[i] = !technicalbool[i];
                      });
                      if(technicalbool[i]==true){
                        setState(() {
                          selectedskills.add(technical[i]);
                          Map<String, dynamic> map = {};
                          map['skill'] = technical[i];
                          map['level'] = 1;
                          selectedskillslevel.add(map);
                        });
                      }else{
                        setState(() {
                          selectedskills.remove(technical[i]);
                          for(int h=0; h<selectedskillslevel.length; h++){
                            if(selectedskillslevel[h]['skill']==technical[i]){
                              selectedskillslevel.removeAt(h);
                              break;
                            }
                          }
                        });
                      }
                    },
                    child: Card(child: Container(width: 100, height: 5,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 5,),
                        Container(width: (MediaQuery.of(context).size.width/8)-56,child: Text(technical[i], style: TextStyle(fontFamily: 'somewhat', fontSize: 14),)),
                        Checkbox(side: BorderSide(width: 1, color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),activeColor: Color(0xff3930eb),value: technicalbool[i], onChanged: (value){
                          setState(() {
                            technicalbool[i] = value!;
                          });
                          if(technicalbool[i]==true){
                            setState(() {
                              selectedskills.add(technical[i]);
                              Map<String, dynamic> map = {};
                              map['skill'] = technical[i];
                              map['level'] = 1;
                              selectedskillslevel.add(map);
                            });
                          }else{
                            setState(() {
                              selectedskills.remove(technical[i]);
                              for(int h=0; h<selectedskillslevel.length; h++){
                                if(selectedskillslevel[h]['skill']==technical[i]){
                                  selectedskillslevel.removeAt(h);
                                  break;
                                }
                              }
                            });
                          }
                        })
                      ],),
                    ),),
                  );
                }),
              ),


              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 15,),
                  Text('Other', style: TextStyle(fontFamily: 'somewhat', fontSize: 20, color: Color(0xff3930eb)),),],
              ),
              Container(
                width: (MediaQuery.of(context).size.width/2)-41,
                child: GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: others.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2.5), itemBuilder: (BuildContext context, int i){
                  if(selectedskills.contains(others[i])){
                    othersbool[i] = true;
                  }
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        othersbool[i] = !othersbool[i];
                      });
                      if(othersbool[i]==true){
                        setState(() {
                          selectedskills.add(others[i]);
                          Map<String, dynamic> map = {};
                          map['skill'] = others[i];
                          map['level'] = 1;
                          selectedskillslevel.add(map);
                        });
                      }else{
                        setState(() {
                          selectedskills.remove(others[i]);
                          for(int h=0; h<selectedskillslevel.length; h++){
                            if(selectedskillslevel[h]['skill']==others[i]){
                              selectedskillslevel.removeAt(h);
                              break;
                            }
                          }
                        });
                      }
                    },
                    child: Card(child: Container(width: 100, height: 5,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 5,),
                        Container(width: (MediaQuery.of(context).size.width/8)-56,child: Text(others[i], style: TextStyle(fontFamily: 'somewhat', fontSize: 14),)),
                        Checkbox(side: BorderSide(width: 1, color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),activeColor: Color(0xff3930eb),value: othersbool[i], onChanged: (value){
                          setState(() {
                            othersbool[i] = value!;
                          });
                          if(othersbool[i]==true){
                            setState(() {
                              selectedskills.add(others[i]);
                              Map<String, dynamic> map = {};
                              map['skill'] = others[i];
                              map['level'] = 1;
                              selectedskillslevel.add(map);
                            });
                          }else{
                            setState(() {
                              selectedskills.remove(others[i]);
                              for(int h=0; h<selectedskillslevel.length; h++){
                                if(selectedskillslevel[h]['skill']==others[i]){
                                  selectedskillslevel.removeAt(h);
                                  break;
                                }
                              }
                            });
                          }
                        })
                      ],),
                    ),),
                  );
                }),
              ),

              SizedBox(height: 30,)

            ],),
          ),)
        ],),
      ),
      SizedBox(height: 10,),
      Row(children: [
        Spacer(),
        GestureDetector(onTap: (){
          String? email =
              FirebaseAuth.instance.currentUser?.email;
          FirebaseFirestore.instance.collection('users').doc(email).set({
            'fname': fname.text,
            'lname': lname.text,
            'bio': bio.text,
            'college': college,
            'year': year,
            'lurl':linkedin.text,
            'projects': projects,
            'skills':selectedskills,
            'skillslevel': selectedskillslevel,
            'purl':FirebaseAuth.instance.currentUser?.photoURL
          }).then((value) {
            Navigator.of(context).pushNamed('/home');
          });
        },
            child: Container(child: Center(child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'somewhat'),)),width: 80, height: 45,decoration: BoxDecoration(color: Color(0xff3930eb), borderRadius: BorderRadius.circular(0)))),
        SizedBox(width: 30,)
      ],)

    ],),),);
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if(user==null){
      Navigator.of(context).pushNamed('/home');
    }else{
      String? email =
          FirebaseAuth.instance.currentUser?.email;
      FirebaseFirestore.instance.collection('users').doc(email).get().then((DocumentSnapshot docs) {
        if(docs.exists){
          setState(() {
            fname.text = docs['fname'];
            lname.text = docs['lname'];
            bio.text = docs['bio'];
            college = docs['college'];
            year = docs['year'];
            linkedin.text = docs['lurl'];
            projects = docs['projects'];
            selectedskills = docs['skills'];
            selectedskillslevel = docs['skillslevel'];
          });
        }
      });
    }
  }
}
