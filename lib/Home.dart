import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'EditProfile.dart';
import 'getter.dart';
import 'package:skillshodh/Profile.dart';
import 'main.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleSignInAccount? user;
  bool showload = false;
  List<String> planguage = ['Python', 'Java',
    'C#',
    'PHP',
    'C++',
    'Ruby', 'Swift', 'TypeScript',
    'Kotlin',
    'Rust', 'MATLAB',
    'R', 'Objective-C', 'Dart'];
  List<bool> planguagebool = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];
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
  List<Users> searchlist = [];
  List<Users> list = [];
  List<String> lists = [];
  List<dynamic> selectedskills = [];
  bool showprog = true;
  bool showtech = false;
  bool showother = false;
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      for(var element in querySnapshot.docs){
        String id = element.reference.id.toString();
        if(selectedskills.isEmpty){
          if(lists.contains(id)){

          }else{
            Users user = Users(fname: element['fname'], lname: element['lname'], bio: element['bio'], college: element['college'], year: element['year'], lurl: element['lurl'], skills: element['skills'], skillslevel: element['skillslevel'], projects: element['projects'], mail: id, purl: element['purl']);
            setState(() {
              list.add(user);
              lists.add(id);
              searchlist.add(user);
            });
          }
        }else{
          int y=0;
          for(int t=0; t<selectedskills.length; t++){
            if(element['skills'].contains(selectedskills[t])){
              y+=1;
              if(y==selectedskills.length){
                if(lists.contains(id)){

                }else{
                  Users user = Users(fname: element['fname'], lname: element['lname'], bio: element['bio'], college: element['college'], year: element['year'], lurl: element['lurl'], skills: element['skills'], skillslevel: element['skillslevel'], projects: element['projects'], mail: id, purl: element['purl']);
                  setState(() {
                    list.add(user);
                    lists.add(id);
                    searchlist.add(user);
                  });
                }
              }
            }
          }
        }





      }
    });
    return Scaffold(body: Column(children: [
      Container(height: 75,
        child: Row(
          children: [
            SizedBox(width: 10,),
            Image.asset('images/iii.png', height: 60,),
            Text('S', style: TextStyle(fontSize: 45, fontFamily: 'somewhat', color: Color(0xff3930eb), fontWeight: FontWeight.w600),),
            Text('kill', style: TextStyle(fontSize: 30, fontFamily: 'somewhat', color: Color(0xff3930eb), fontWeight: FontWeight.w600),),
            Text('S', style: TextStyle(fontSize: 45, fontFamily: 'somewhat', color: Colors.black, fontWeight: FontWeight.w600),),
            Text('hodh', style: TextStyle(fontSize: 30, fontFamily: 'somewhat', color: Colors.black, fontWeight: FontWeight.w600),),
            SizedBox(width: 130,),

            Container(height: 40, width: 350,child: TextField(textAlign: TextAlign.center,
              cursorColor: Colors.black,controller: search, decoration: InputDecoration(contentPadding: EdgeInsets.zero,prefixIconConstraints: BoxConstraints(maxHeight: 120, maxWidth: 120), prefixIcon: Lottie.asset('images/search.json', width: 50), hintText: 'Search', hintStyle: TextStyle(fontSize: 20), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffb319d4), width: 2), borderRadius: BorderRadius.circular(5))),
              style: TextStyle(fontSize: 20, height: 1),)),
            Spacer(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(onTap: (){}, child: Row(
                  children: [
                    Image.asset('images/team.png', width: 28,),
                    Text('  Teams', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff3930eb)),),
                  ],
                )),
              ),
            ),
            showload ? Lottie.asset('images/load.json', width: 100) : isuser ? Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return EditProfile();
                    }));
                  },
                  child: Row(
                    children: [
                      Image.asset('images/edit.png', width: 28,),
                      Text(' Edit Profile', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff3930eb)),),
                    ],
                  ),
                ),
              ),
            ) :
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      showload = true;
                    });
                    user = kIsWeb ? await (GoogleSignIn().signIn()) : await (GoogleSignIn().signIn());
                    String? mail = user?.email;
                    if (mail != null) {
                      final GoogleSignInAuthentication? googleauth =
                      await user?.authentication;
                      final credential = GoogleAuthProvider.credential(
                          accessToken: googleauth?.accessToken,
                          idToken: googleauth?.idToken);

                      await FirebaseAuth.instance
                          .signInWithCredential(credential).catchError((e){
                        if(e.code == 'user-disabled'){
                          GoogleSignIn().signOut();
                          try {
                            GoogleSignIn().disconnect();
                          } catch (e) {}
                          FirebaseAuth.instance.signOut();
                          setState(() {
                            //showban = true;
                          });
                        }else{
                          //Fluttertoast.showToast(msg: e.toString());
                        }

                      });
                      if (FirebaseAuth.instance.currentUser != null) {
                        setState(() {
                          isuser = true;
                        });
                        String? email =
                            FirebaseAuth.instance.currentUser?.email;
                        FirebaseFirestore.instance.collection('users').doc(email).get().then((DocumentSnapshot docs){
                          if(docs.exists){
                            setState(() {
                              isaccess = true;
                              showload = false;
                            });
                          }else{
                            setState(() {
                              isaccess = false;
                              showload = false;
                            });
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return EditProfile();
                            }));
                          }
                        });
                      } else {}
                    }
                  },
                  child: Row(
                    children: [
                      Text('Login', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff3930eb)),),
                    ],
                  ),
                ),
              ),
            ),
            Card(child: Container(height: 45, width: 45, child: IconButton(onPressed: (){}, icon: Image.asset('images/bell.png', height: 23,))),),
            SizedBox(width: 30,)
          ],
        ),
      ),
      SizedBox(height: 30,),
      Container(height: MediaQuery.of(context).size.height-150, child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: (MediaQuery.of(context).size.width/4)-1, child: SingleChildScrollView(child: Column(children: [
          Text('Filters', style: TextStyle(fontFamily: 'somewhat', fontSize: 23, color: Colors.black, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),),

          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              setState(() {
                showprog = !showprog;
              });
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Text('Programming Languages', style: TextStyle(fontFamily: 'somewhat', fontSize: 20, color: Color(0xff3930eb)),),
              showprog ? Icon(Icons.keyboard_arrow_down_sharp, size: 35,) : Icon(Icons.keyboard_arrow_right_sharp, size: 35,)
              ],
            ),
          ),
          showprog ? Container(
            width: (MediaQuery.of(context).size.width/4)-31,
            child: GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: planguage.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
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
                      list.clear();
                      lists.clear();
                      searchlist.clear();
                    });
                  }else{
                    setState(() {
                      selectedskills.remove(planguage[i]);
                      list.clear();
                      lists.clear();
                      searchlist.clear();
                    });
                  }
                },
                child: Card(child: Container(height: 5,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 5,),
                    Container(width: (MediaQuery.of(context).size.width/8)-61, child: Text(planguage[i], style: TextStyle(fontFamily: 'somewhat', fontSize: 14),)),
                    Checkbox(side: BorderSide(width: 1, color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),activeColor: Color(0xff3930eb),value: planguagebool[i], onChanged: (value){
                      setState(() {
                        planguagebool[i] = value!;
                      });
                      if(planguagebool[i]==true){
                        setState(() {
                          selectedskills.add(planguage[i]);
                          list.clear();
                          lists.clear();
                          searchlist.clear();
                        });
                      }else{
                        setState(() {
                          selectedskills.remove(planguage[i]);
                          list.clear();
                          lists.clear();
                          searchlist.clear();
                        });
                      }
                    })
                  ],),
                ),),
              );
            }),
          ) : SizedBox(height: 0,),

          SizedBox(height: 15,),
          GestureDetector(
            onTap: (){
              setState(() {
                showtech = !showtech;
              });
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Text('Technical', style: TextStyle(fontFamily: 'somewhat', fontSize: 20, color: Color(0xff3930eb)),),
                showtech ? Icon(Icons.keyboard_arrow_down_sharp, size: 35,) : Icon(Icons.keyboard_arrow_right_sharp, size: 35,)
              ],
            ),
          ),
          showtech ? Container(
            width: (MediaQuery.of(context).size.width/4)-31,
            child: GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: technical.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
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
                      list.clear();
                      lists.clear();
                      searchlist.clear();
                    });
                  }else{
                    setState(() {
                      selectedskills.remove(technical[i]);
                      list.clear();
                      lists.clear();
                      searchlist.clear();
                    });
                  }
                },
                child: Card(child: Container(height: 5,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 5,),
                    Container(width: (MediaQuery.of(context).size.width/8)-61,child: Text(technical[i], style: TextStyle(fontFamily: 'somewhat', fontSize: 14),)),
                    Checkbox(side: BorderSide(width: 1, color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),activeColor: Color(0xff3930eb),value: technicalbool[i], onChanged: (value){
                      setState(() {
                        technicalbool[i] = value!;
                      });
                      if(technicalbool[i]==true){
                        setState(() {
                          selectedskills.add(technical[i]);
                          list.clear();
                          lists.clear();
                          searchlist.clear();
                        });
                      }else{
                        setState(() {
                          selectedskills.remove(technical[i]);
                          list.clear();
                          lists.clear();
                          searchlist.clear();
                        });
                      }
                    })
                  ],),
                ),),
              );
            }),
          ) : SizedBox(height: 0,),


          SizedBox(height: 15,),
          GestureDetector(
            onTap: (){
              setState(() {
                showother = !showother;
              });
            },
            child: Row(
              children: [
                SizedBox(width: 15,),
                Text('Other', style: TextStyle(fontFamily: 'somewhat', fontSize: 20, color: Color(0xff3930eb))),
                showother ? Icon(Icons.keyboard_arrow_down_sharp, size: 35,) : Icon(Icons.keyboard_arrow_right_sharp, size: 35,)
              ],
            ),
          ),
          showother ? Container(
            width: (MediaQuery.of(context).size.width/4)-31,
            child: GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: others.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
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
                      list.clear();
                      lists.clear();
                      searchlist.clear();

                    });
                  }else{
                    setState(() {
                      selectedskills.remove(others[i]);
                      list.clear();
                      lists.clear();
                      searchlist.clear();
                    });
                  }
                },
                child: Card(child: Container(height: 5,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 5,),
                    Container(width: (MediaQuery.of(context).size.width/8)-61,child: Text(others[i], style: TextStyle(fontFamily: 'somewhat', fontSize: 14),)),
                    Checkbox(side: BorderSide(width: 1, color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),activeColor: Color(0xff3930eb),value: othersbool[i], onChanged: (value){
                      setState(() {
                        othersbool[i] = value!;
                      });
                      if(othersbool[i]==true){
                        setState(() {
                          selectedskills.add(others[i]);
                          list.clear();
                          lists.clear();
                          searchlist.clear();
                        });
                      }else{
                        setState(() {
                          selectedskills.remove(others[i]);
                          list.clear();
                          lists.clear();
                          searchlist.clear();
                        });
                      }
                    })
                  ],),
                ),),
              );
            }),
          ) : SizedBox(height: 0,),

        ],),),),
        Container(width: 2,color: Colors.black,),



        Container(width: 3*(MediaQuery.of(context).size.width/4)-1, child: SingleChildScrollView(child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: searchlist.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1.2), itemBuilder: (BuildContext context, int i){
              return GestureDetector(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  profmail = searchlist[i].mail;
                  print(profmail);
                  return Profile();
                }));
              }, child: Card(child: Container(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 10,),
                Row(children: [
                  SizedBox(width: 10,),
                  CachedNetworkImage(
                    imageUrl: searchlist[i].purl,
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
                    width: 3*(MediaQuery.of(context).size.width/16) - 80,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(searchlist[i].fname+' '+searchlist[i].lname, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                      Text(searchlist[i].year+' Year, '+searchlist[i].college, style: TextStyle(fontSize: 12, color: Colors.grey),)
                    ],),
                  )
                ],),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text((searchlist[i].skills.toString().replaceAll('[', '').replaceAll(']', '').length>85) ? searchlist[i].skills.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', ' |').substring(0,85)+'...' : searchlist[i].skills.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', ' |'), style: TextStyle(color: Colors.indigo),),
                )
              ],),)));
            }),
          )
        ],),),),
      ],),)
    ],));
  }

@override
  void initState() {
    search.clear();
    searchlist.clear();
    lists.clear();
    list.clear();
    search.addListener(() {
      setState(() {
        if (search.text == '') {
          searchlist.clear();
          for (int h = 0; h < list.length; h++) {
            searchlist.add(list[h]);
          }
        } else {
          searchlist.clear();
          for (int g = 0; g < list.length; g++) {
            if ((list[g].fname.toLowerCase()+" "+list[g].lname.toLowerCase()).contains(
                search.text.toLowerCase())) {
              searchlist.add(list[g]);
            }
          }
        }
      });
    });
    User? user = FirebaseAuth.instance.currentUser;
    Future.delayed(const Duration(milliseconds: 1000), () {
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
    });
  }
}
