import 'package:flutter/material.dart';


class photoclickesd extends StatefulWidget {
  const photoclickesd({this.path,this.date});
  final path;
  final date;
  
  
  @override
  State<photoclickesd> createState() => _photoclickesdState();
}

class _photoclickesdState extends State<photoclickesd> {
  
  
  
  
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        body: 
     Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          child:Image.network(widget.path),
        ),
        ElevatedButton(

          onPressed: (){
          Navigator.pop(context);
},
 child: Text("go back")),
Text("${widget.date}",style: TextStyle(color: Colors.white))
      ],
      
      )
    )));
  }
}