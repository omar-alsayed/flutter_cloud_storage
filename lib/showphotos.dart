import 'dart:io';
import 'package:databasewithflutter/signin_page.dart';
import 'package:databasewithflutter/whenphotoclicked.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exif/exif.dart';

void main() {
  runApp(showphoto_scaffold());
}


class showphoto_scaffold extends StatelessWidget {
  const showphoto_scaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child:showphoto() ));
  }
}



class showphoto extends StatefulWidget {
  const showphoto({super.key});

  @override
  State<showphoto> createState() => _showphotoState();
  
}

class _showphotoState extends State<showphoto> {
  

var path;
var date;
var username=Hive.box('signin_user').get('signin_user');

  
      Future<List> getphtos() async{
      var ress;
      var res=await http.post(
      Uri.parse('http://10.0.2.2:80/flutter/return_photos.php'),
      body: {"username": username}
      );
      ress=jsonDecode(res.body);
      return ress;
  }
  
  
  
  
    select_photo()async{////////
    final ImagePicker picker = ImagePicker();
    
    
    ////photo extract sec
    var photo=await picker.pickImage(source: ImageSource.gallery);
    String imagename=File(photo!.path).path.split('/').last;
    var thephoto=base64Encode(File(photo.path).readAsBytesSync());


    //get the date of the photo
    final exifData = await readExifFromBytes(File(photo.path).readAsBytesSync());
    final dateTag = exifData['Image DateTime'];
    final dateString = dateTag.toString();
    
    ///////insert data into db
    await http.post(
      Uri.parse('http://10.0.2.2:80/flutter/insert.php'),
      body:{"username":username,"imagename":imagename,"thephoto":"${thephoto}","date":"${dateString}"}
      );

  }
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 67, 20, 91),
      onPressed: () async{
        await select_photo();
        setState(() {});
        },
      child: Icon(Icons.add),
        ),
        
        
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 78, 0, 92),
          leading: IconButton(onPressed: (){
            
            Hive.box('signin_user').put('signin_user',null);
            setState(() {});
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => signinpage()));
            
          },
          icon:Icon(Icons.logout_outlined))),
          
        body: Container(width:double.infinity,height: double.infinity,
        color: Colors.purple,
        child:FutureBuilder(
          future: getphtos(),
          builder: (context, snapshot) {
              var lst=snapshot.data;
              
            if(snapshot.hasData){
            return MasonryGridView.builder(
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2
                ),
              itemCount:lst!.length,
              itemBuilder: (BuildContext context,index) {
                
                return InkWell(
                  onTap: () {
                    path='http://10.0.2.2:80/flutter/.${lst[index]['path']}';
                    date=lst[index]['date'];
                  Navigator.push(
                context,
                      MaterialPageRoute(builder: (context) => photoclickesd(path:path,date:date)));
                  },
                    child:Container(
                    child:Image.network("http://10.0.2.2:80/flutter/.${lst[index]['path']}")));
                  });
                  
                }
                else
              return Center(child: CircularProgressIndicator());
                      }
                      
          
  )
    ));
  }
}

