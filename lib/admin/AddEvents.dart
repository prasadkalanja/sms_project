
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import '../model/Env.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  bool visible=false;
// List<Asset> images= <Asset>[];
final ename=TextEditingController();
final edesc=TextEditingController();
final eDate=TextEditingController();
final FormKey=GlobalKey<FormState>();

void ClearText(){
  ename.clear();
  eDate.clear();
  edesc.clear();

}

  // final image=TextEditingController();
  // late final ImagePicker imagePicker;
  //  File? savedImage;
   // bool _load=false;
   File? _image;
  final picker=ImagePicker();
  Future Choiceimage()async{
    var pickedImage=await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image=File(pickedImage!.path);
    });
  }
Future UploadData()async{
    String name=ename.text;
    String date=eDate.text;
    String desc=edesc.text;


    var url=Uri.parse("${Env.URL_PREFIX}/event_upload.php");
    try{
      //List<int>imageBytes=_image!.readAsBytesSync();
      Uint8List imgbytes = await _image!.readAsBytes();
      String baseimage=base64Encode(imgbytes);

      var response=await http.post(url,
      body:{
        'image':baseimage,
        'Name':name,
        'Date':date,
        'Desc':desc,
      }
      );
      var msg = jsonDecode(response.body);
      print(msg);

      // If the Response Message is Matched.
      if(msg == 'Upload Success')
      {


        // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Event Upload Successful!!'),
              actions: <Widget>[
                TextButton(
                  child: new Text("OK"),
                  onPressed: () {
                    ClearText();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        // Navigator.of(context).pop();
        // FormField.currentState!.validate();
        // Navigate to Profile Screen & Sending Email to Next Screen.

        // Navigator.push(context, MaterialPageRoute(builder: (context)))
      }else
      {
        // If Email or Password did not Matched.
        // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });

        // Showing Alert Dialog with Response JSON Message.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Duplicate Entry'),
              actions: <Widget>[
                TextButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );}
    }catch(e){
      Fluttertoast.showToast(msg: "Error during converting to Base64");
      print("Error during converting to Base64");
      //there is error during converting file image to base64 encoding.
    }

  // var request = http.MultipartRequest('POST', Uri.parse("${Env.URL_PREFIX}/event_upload.php"));
  // request.files.add(http.MultipartFile('image',
  //     File(_image).readAsBytes().asStream(), File(_image).lengthSync(),
  //     filename: _image.split("/").last));
  // request.fields['name']=ename.toString();
  // request.fields['desc']=edesc.toString();
  // request.fields['date']=eDate.toString();
  //       //var data= {'Name':name,'Desc':desc,'Date':date,'image':bytes};
  // var res = await request.send();
  //
  // if(res.statusCode==200){
  //   print("Image Uploaded");
  // }else{
  //   print("Upload Failed");
  // }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(

          leading:InkWell(
            onTap: ()=>Navigator.pop(context, false),
            child:Icon(Icons.arrow_back),
          ),
          // actions: [
          //   IconButton(onPressed:(){},
          //       icon:Icon(Icons.arrow_back)),
          // ],
          centerTitle: true,
          title: Text('Add Events',style:TextStyle(fontSize: 20,)),
        ),
      ),
      body: SingleChildScrollView(
           child: Form(
             key: FormKey,
             child: Column(
               children: [
                 Container(
                   padding: EdgeInsets.all(20),

                 ),
                 Container(
                   padding: EdgeInsets.all(20),
                   child: TextFormField(controller: ename,
                     validator:(valename){
                     if(valename!.isEmpty){
                       return "Data Required";
                     }
                     },
                     decoration: InputDecoration(
                       label: Text('Event_Name'),
                       hintText: 'Enter Event name',
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       )
                     ),

                   ),
                 ),

                 Container(
                   padding: EdgeInsets.all(20),
                   child: TextFormField(controller: eDate,
                     validator: (eDateval)
                     {
                       if(eDateval!.isEmpty)
                       {
                         return "Date requierd.";
                       }

                     },

                     decoration: InputDecoration(
                       hintText: 'Event_date',
                       label: Text('Event date'),
                       // fillColor: Colors.black12,
                       // filled: true,
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                     onTap: ()async{
                       DateTime? date =DateTime(1900);
                       FocusScope.of(context).requestFocus(new FocusNode());

                       date= await showDatePicker(
                         context: context,
                         initialDate: DateTime.now(),
                         firstDate: DateTime(1900),
                         lastDate: DateTime(2100),
                       );
                       eDate.text=date.toString().substring(0,10);
                     },
                   ),
                 ),
                 Container(
                   padding: EdgeInsets.all(20),
                   child: TextFormField(controller: edesc,
                     validator: (valdesc){
                     if(valdesc!.isEmpty){
                       return"Data Required";
                     }
                     },
                     decoration: InputDecoration(
                         label: Text('Event_Description'),
                         hintText: 'Enter Event description',
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                         )
                     ),

                   ),
                 ),
                     Container(
                       padding: EdgeInsets.all(20),
                       child:ElevatedButton(
                         onPressed:(){
                           Choiceimage();
                         },
                         child: Text('Select Image'),
                       ),
                     ),

                 Container(
                   child: _image== null ?Text("No Image Selected"):Image.file(_image!),
                     height: 150,
                     width: 150,
                     // child: GridView.count(crossAxisCount: 3,
                     // shrinkWrap: true,
                     // children:List.generate(images.length, (index){
                     //   Asset asset=images[index];
                     //   return AssetThumb(
                     //     asset: asset,
                     //     width: 300,
                     //     height: 300,
                     //   );
                     // }),
                     // )
                 ),
                 // Container(
                 //   width: 100,
                 // height: 100,
                 // child:savedImage==null
                 //     ?Text('No image selected')
                 //     // :Text("Image Selected"),
                 //     :Image.file(savedImage!,fit: BoxFit.cover,),
                 //
                 // ),
                 // Container(
                 // child: ElevatedButton(
                 //   onPressed: (){
                 //     _getFromGallery();
                 //   },
                 //  child: Text('Select Image'),
                 // ),
                 // ),
                 Container(
                   width: 250,
                  //color: Colors.grey,
                  padding: EdgeInsets.all(30),
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                     primary: Colors.purple),
                     child: Text('Submit'),
                     onPressed:()async{
                       if(FormKey.currentState!.validate()){
                         UploadData();
                       }

                     },
                   ),
                 ),
               ],

             ),
           ),
         ),
    );
  }
}
