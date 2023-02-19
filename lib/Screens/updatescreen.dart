import 'package:flutter/material.dart';
import 'package:flutternotepad/Screens/Model/Handler/dbhandler.dart';
import 'package:flutternotepad/Screens/homescreen.dart';

import '../Colors/colors.dart';
import 'Model/notes.dart';

class UpdateScreen extends StatefulWidget {
  final int myid;
  final String titlecontroller;
  final String descriptioncontroller;

  const UpdateScreen({
    super.key,
    required this.titlecontroller,
    required this.descriptioncontroller,
    required this.myid,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notesList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titlecontroller.text = widget.titlecontroller;
    descriptioncontroller.text = widget.descriptioncontroller;
    setState(() {});
    dbHelper = DBHelper();

    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNotesList();
  }

  clearText() {
    titlecontroller.clear();
    descriptioncontroller.clear();
  }

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundclr,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryclr),
        title: Text(
          "Note",
          style: TextStyle(
              fontSize: 25,
              color: Colors.black.withOpacity(0.75),
              fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              TextFormField(
                controller: titlecontroller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Title",
                    hintStyle: const TextStyle(
                        fontSize: 24, color: Color(0xff70787C))),
              ),
              TextFormField(
                maxLines: 6,
                controller: descriptioncontroller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Note something down",
                    hintStyle: const TextStyle(
                        fontSize: 16, color: Color(0xff70787C))),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 90,
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: primaryclr),
                      onPressed: () {
                        dbHelper!.update(NotesModel(
                            id: widget.myid,
                            description: descriptioncontroller.text,
                            title: titlecontroller.text));
                        setState(() {
                          notesList = dbHelper!.getNotesList();
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false);
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: whiteclr, fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 90,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[400]),
                      onPressed: () {
                        clearText();
                      },
                      child: const Text(
                        "Clear",
                        style: TextStyle(color: whiteclr, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
