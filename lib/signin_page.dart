import 'dart:convert';
import 'package:databasewithflutter/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'showphotos.dart';
import 'package:stroke_text/stroke_text.dart';

final _mybox=Hive.box('signin_user');



class signinpage extends StatelessWidget {
  
  const signinpage({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
debugShowCheckedModeBanner: false,
      home:Scaffold(
resizeToAvoidBottomInset:false,
      body:signin()));
  }
}



class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
  
  
}

class _signinState extends State<signin> {
  

late TextEditingController username;
late TextEditingController password;

var check;


  
Future<dynamic> check_user(user,pass)async {

    var res=await http.post(
    Uri.parse('http://10.0.2.2:80/flutter/signin.php'),
    body:{"username":user,"password":pass}
    
    );

    var ress=jsonDecode(res.body);
  
  
check=ress;


if(ress=='signin'){
  _mybox.put('signin_user','$user');


Navigator.push(
context,
MaterialPageRoute(builder: (context) =>const showphoto()));
}

}
  
  
  
@override
void initState(){
  super.initState();
  username=TextEditingController();
  password=TextEditingController();

if(_mybox.get('signin')==null){
}


}
  
  @override
  void dispose() {
    username.dispose();
    password.dispose();

    super.dispose();
  }
  
  
  var isusernameempty=false;
  var ispasswordempty=false;
  
  
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:AssetImage("cloud.jpg"),
          fit:BoxFit.cover
          )),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          
          SizedBox(height: height/4),
          
          Container(
              width:width/1.06,
              height:height/1.7,
              child:Padding(
            padding: const EdgeInsets.only(bottom:20),
            child: Column(
                children: [
          
            Padding(
              padding: const EdgeInsets.only(bottom:20),
              child:StrokeText(
              text: "cloudy",
              textStyle: TextStyle(
              fontSize: 50,
              color: Colors.white
              ),
              strokeColor: Colors.black,
              strokeWidth: 3,
            )),
            
            
              Padding(
                padding: const EdgeInsets.all(1.0),
                child:
                ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container( 
                color: Color.fromARGB(173, 17, 17, 17),
                  width: double.infinity,
                  height: height/11.8,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextField(
                        onChanged: (value) {
                        check=null;
                        value.isNotEmpty?isusernameempty=true:isusernameempty=false;
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
            
            SizedBox(height: 8),
            
            Padding(
                padding: const EdgeInsets.all(1.0),
                child:
                ClipRRect(
              borderRadius: BorderRadius.circular(10), 
              child: Container( 
                color: Color.fromARGB(173, 17, 17, 17),
                  width:double.infinity,
                  height:height/11.8,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextField(
                      onChanged: (value) {
                        check=null;
                        value.isNotEmpty?ispasswordempty=true:ispasswordempty=false;
                        setState(() {});
                      },
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration( 
                      hintText: 'password',
                      hintStyle: TextStyle(color:const Color.fromARGB(255, 170, 170, 170)),
                      labelStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      enabledBorder: const OutlineInputBorder(
                      )),
                      style: TextStyle(color:Colors.white),
                      cursorColor:Colors.white),
                  )),
              ),
            ),
                        
                        
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(check!=null?'$check':'',style: TextStyle(fontSize: 15,color: Colors.red),)),
            ),

            SizedBox(height: height/80),
            
            Container(
              width: double.infinity,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple ,
              disabledForegroundColor: const Color.fromARGB(18, 255, 255, 255),
              foregroundColor: Colors.white
              ),
              
              onPressed:isusernameempty&&ispasswordempty?()async{
              setState(() {});
              await check_user(username.text,password.text);
              }:null,
              child: Text("signin" , style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)))),
            
            ])),///2dn col and con
            ),
            
            
            
            
            
            
          SizedBox(height: height/11),
          
          
          
          Container(
              decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white,
                  width:0.2
                  ))),
              // color:  Color.fromARGB(255, 0, 0, 0),
              width: double.infinity,
              height: height/15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
        
                StrokeText(
              text: "dont have an account?",
              textStyle: TextStyle(
              fontSize: 14,
              color: Colors.white
              ),
              strokeColor: Colors.black,
              strokeWidth: 2,
            ),
                  
                  TextButton(
                    
                    onPressed: (){
                    
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const signup2())
                );
                    
                    
                  }
                  
                  
                  , child: Text("signup" , style: TextStyle(color: Colors.purple),))
                  
                ],
              ),
            ),
          
          
        ]
      ),
    );
  }
}


