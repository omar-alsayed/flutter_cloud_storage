import 'dart:convert';
import 'package:databasewithflutter/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:stroke_text/stroke_text.dart';

final _mybox=Hive.box('signin_user');
var lst=[];



class signup2 extends StatelessWidget {
  const signup2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset:false,

      body:signup()
      ));
  }
}





class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();

}

class _signupState extends State<signup> {
  


late TextEditingController username;
late TextEditingController password;

var isusernameempty=true;
var ispasswordempty=true;

var check;
  
  
Future<dynamic> check_user(user,pass)async {

    var res=await http.post(
    Uri.parse('http://10.0.2.2:80/flutter/signup.php'),
    body:{"username":user,"password":pass}
    
    );

    var ress=jsonDecode(res.body);
  
  
check=ress;


if(ress=='signup'){
_mybox.put('signin_user','$user');


Navigator.push(
context,
MaterialPageRoute(builder: (context) =>const signinpage())
);
  
  
}

}
  
  
  
@override
void initState(){
  super.initState();
  username=TextEditingController();
  password=TextEditingController();

}
  
  @override
  void dispose() {
    username.dispose();
    password.dispose();

    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
     final height=MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:AssetImage("cloud.jpg"),
          fit:BoxFit.cover          )
      ),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:30),
            child: StrokeText(
              text: "cloudy",
              textStyle: TextStyle(
              fontSize: 50,
              color: Colors.white
              ),
              strokeColor: Colors.black,
              strokeWidth: 3,
            ),
          ),
          
          
            Padding(
              padding: const EdgeInsets.all(15.0),
              child:
              ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container( 
                color: Color.fromARGB(173, 17, 17, 17),
                width: double.infinity,
                height: height/11.8,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextField(
                     onChanged: (value) {
                        check=null;
                        value.isNotEmpty?isusernameempty=false:isusernameempty=true;

                        setState(() {});
                      },
                    controller: username,
                    decoration: InputDecoration(
                    hintText: "username",
                    hintStyle: TextStyle(color:const Color.fromARGB(255, 170, 170, 170)),
                    border: InputBorder.none,
                      enabledBorder: const OutlineInputBorder(
                      )),
                      style: TextStyle(color:Colors.white),
                      cursorColor:Colors.white),
                )),
            ),
          ),
          
          
          Padding(
              padding: const EdgeInsets.all(15.0),
              child:
              ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container( 
                color: Color.fromARGB(173, 17, 17, 17),
                width: double.infinity,
                height:height/11.8,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextField(
                    onChanged: (value) {
                    value.isNotEmpty?ispasswordempty=false:ispasswordempty=true;
                    setState(() {});
                    },
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration( 
                    hintText: "password",
                    hintStyle: TextStyle(color:const Color.fromARGB(255, 170, 170, 170)),
                    border: InputBorder.none,
                      enabledBorder: const OutlineInputBorder(
                      )),
                      style: TextStyle(color:Colors.white),
                      cursorColor:Colors.white),
                )),
            ),
          )
          
          
          ,
          
          
          
          Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(check!=null?'$check':'',style: TextStyle(fontSize: 15,color: Colors.red),)),
            ),
          
          
          
          SizedBox(height: 30)
          ,
            Container(
              width: width/1.1,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple ,
              disabledForegroundColor: const Color.fromARGB(18, 255, 255, 255),
              foregroundColor: Colors.white),
              
              
                onPressed: !isusernameempty&&!ispasswordempty?
                ()async{
                setState(() {});
                await check_user(username.text,password.text);
                }:null,
                child: Text("signup" , style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),)),
            ),

          
        ],
      ),
    );
  }
}