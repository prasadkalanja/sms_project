import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../model/Event.dart';
import '../model/Env.dart';

class ViewEvent extends StatefulWidget {
  @override
  _ViewEventState createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  late Future<List<Events>>events;
  final eventKey=GlobalKey<_ViewEventState>();
@override
void initstate(){
super.initState();
events=getEvent();
}
  Future<List<Events>>getEvent() async{
    // final  url = 'http://192.168.31.45/sm_system/student_list.php';
    final  response = await http.get(Uri.parse("${Env.URL_PREFIX}/get_event.php"));
    final items=json.decode(response.body).cast<Map<String,dynamic>>();
    List<Events>events=items.map<Events>((json){
      return Events.fromJson(json);
    }).toList();
    // count=students.length;
    // print(students[0].phone_no);
    //  // print(stude
    //  nts[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);
    return events;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: eventKey,
      appBar: AppBar(
        title: Text("Events"),
      ),
      body:Scrollbar(
        child:
        FutureBuilder<List<Events>>(
          future: events,
          builder: (ctx, snapshot){
            //show loading spinner
            //if(!snapshot.hasData) return CircularProgressIndicator();
            //render student list
            Alignment.center;
            return
              ListView.builder(
                  itemCount:snapshot.data!.length,
                  itemBuilder:(ctx,int index){
                    var data=snapshot.data![index];
                    String _imageString=data.image!;

                    Uint8List _byteImage;
                    _byteImage=Base64Decoder().convert(_imageString);
                    // final data=snapshot.data as String;
                    return Card(
                      child: ListTile(
                        leading: Image.memory(_byteImage),
                        trailing: Icon(Icons.view_list),
                        title: Text(
                          data.event_name!, style: TextStyle(fontSize: 20),),
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(students:data)),
                          // );
                        },
                      ),
                    );

                  });
          },

        ),
      ),
    );
  }
}
