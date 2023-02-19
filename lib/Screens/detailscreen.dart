import 'package:flutter/material.dart';
import 'package:flutternotepad/Colors/colors.dart';
import 'package:flutternotepad/Screens/updatescreen.dart';

import 'Model/notes.dart';

class DetailScreen extends StatefulWidget {
  final NotesModel detail;
  final int id;
  final String titlecontroller;
  final String descriptioncontroller;
  const DetailScreen({
    super.key,
    required this.detail,
    required this.titlecontroller,
    required this.descriptioncontroller,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  SizedBox spaceThingy = const SizedBox(
    height: 15,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundclr,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryclr),
        title: Text(
          "Notes Detail",
          style: TextStyle(
              fontSize: 25,
              color: Colors.black.withOpacity(0.75),
              fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.titlecontroller,
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline),
              ),
              spaceThingy,
              Text(
                widget.descriptioncontroller,
                style: const TextStyle(
                  fontSize: 16.5,
                ),
              ),
              spaceThingy,
              Center(
                child: SizedBox(
                  height: 50,
                  width: 90,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: primaryclr),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => UpdateScreen(
                                    myid: widget.id,
                                    descriptioncontroller:
                                        widget.descriptioncontroller,
                                    titlecontroller: widget.titlecontroller,
                                  ))));
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(color: whiteclr),
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
