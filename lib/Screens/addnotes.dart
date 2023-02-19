import 'package:flutter/material.dart';
import 'package:flutternotepad/Colors/colors.dart';
import 'package:flutternotepad/Screens/Model/Handler/dbhandler.dart';
import 'package:flutternotepad/Screens/Model/notes.dart';
import 'package:flutternotepad/Screens/homescreen.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notesList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();

    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNotesList();
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
                minLines: 1,
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
                height: 25,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 90,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: primaryclr),
                    onPressed: () {
                      dbHelper!
                          .insert(NotesModel(
                              description: descriptioncontroller.text,
                              title: titlecontroller.text))
                          .then((value) {
                        setState(() {
                          notesList = dbHelper!.getNotesList();
                        });
                      }).onError((error, stackTrace) {
                        error.toString();
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const HomeScreen())),
                          (route) => false);
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: whiteclr, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
