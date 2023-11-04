import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'getter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String fname = '', lname = '', bio = '', college='', year ='', lurl = '', purl='';
  List<dynamic> projects = [];
  List<dynamic> skillslevel = [];
  List<String> selectedskills = [];
  List<Users> list = [];
  List<String> lists = [];
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
      SizedBox(height: 40,),
      Container(height: MediaQuery.of(context).size.height-150, child: Row(children: [
        Container(width: 5*(MediaQuery.of(context).size.width/7)-1, child: SingleChildScrollView(child: Column(children: [
          CachedNetworkImage(
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
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
            errorWidget: (context, url, error) =>
            const Icon(Icons.error),
          ),
          Text(fname, style: TextStyle(fontSize: 32),)
        ],),),),
        Container(width: 2, color: Colors.black,),
        Container(width: 2*(MediaQuery.of(context).size.width/7)-1, child: SingleChildScrollView(child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: list.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 2.3), itemBuilder: (BuildContext context, int i){
              return GestureDetector(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  profmail = list[i].mail;
                  return Profile();
                }));
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
                    width: 3*(MediaQuery.of(context).size.width/16) - 80,
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
                )
              ],),)));
            }),
          )
        ],),),)
      ],),)
    ],),);
  }

  @override
  void initState() {
    FirebaseFirestore.instance.collection('users').doc(profmail).get().then((DocumentSnapshot documentSnapshot) {
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
    });
  }
}
