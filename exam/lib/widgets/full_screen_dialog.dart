import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openwhyd_api_music_app/globals.dart' as globals;

class FullScreenDialog extends StatelessWidget {
  final TextEditingController nameTextFieldController = TextEditingController();
  final TextEditingController artistTextFieldController = TextEditingController();
  final TextEditingController linkTextFieldController = TextEditingController();
  //final int showNum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new track'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              TextField(
                controller: nameTextFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.my_library_music_rounded),
                  hintText: "Input name of new track",
                  labelText: "Track name",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: artistTextFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.account_circle),
                  hintText: "Input name of track artist",
                  labelText: "Artist name",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: linkTextFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.add_link),
                  hintText: "Input youtube link to track",
                  labelText: "Link",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      primary: Colors.white,
                    ),
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.teal,
                      primary: Colors.white,
                    ),
                    child: Text('ADD'),
                    onPressed: () {
                      addTrack (context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }

  Future<void> addTrack(BuildContext context) async {
    var findURL = "https://openwhyd.org/api/post?action=insert" +
        "&name=" + nameTextFieldController.text +
        " - " + artistTextFieldController.text +
        "&eId=" + linkTextFieldController.text //+
        // "&pl={name=" + +
        // "&id=" +  + "}"
    ;

    final response = await http.get(
        Uri.parse(findURL),
      headers: <String, String>{
        "Cookie": globals.cookieChange[0],
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      //jsonDecode(response.body);

      return showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: Column(
                children: [
                  Text(
                    "Track Added!",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          });
    } else {
      throw Exception('Failed to add track');
    }
  }

}
