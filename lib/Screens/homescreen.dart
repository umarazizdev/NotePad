import 'package:flutter/material.dart';
import 'package:flutternotepad/Colors/colors.dart';
import 'package:flutternotepad/Screens/Model/Handler/dbhandler.dart';
import 'package:flutternotepad/Screens/Model/notes.dart';
import 'package:flutternotepad/Screens/addnotes.dart';
import 'package:flutternotepad/Screens/detailscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchcontroller = TextEditingController();
  String search = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                textAlign: TextAlign.start,
                "Notepad",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Container(
                height: 42,
                decoration: BoxDecoration(
                    color: lightgreyclr,
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: searchcontroller,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: textgreyclr,
                      ),
                      hintText: "Search notes",
                      hintStyle: const TextStyle(color: textgreyclr)),
                  onChanged: ((String? value) {
                    setState(() {
                      search = value.toString();
                    });
                  }),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FutureBuilder(
                  future: notesList,
                  builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          // scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,

                          itemBuilder: ((context, index) {
                            final doc = snapshot.data![index];
                            String position =
                                snapshot.data![index].title.toString();
                            if (searchcontroller.text.isEmpty) {
                              return Dismissible(
                                  direction: DismissDirection.endToStart,
                                  onDismissed: ((DismissDirection direction) {
                                    dbHelper!.delete(snapshot.data![index].id!);
                                    notesList = dbHelper!.getNotesList();
                                    snapshot.data!
                                        .remove(snapshot.data![index]);
                                  }),
                                  background: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.red,
                                    ),
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: whiteclr,
                                    ),
                                  ),
                                  key: ValueKey<int>(snapshot.data![index].id!),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: SizedBox(
                                      height: 75,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  DetailScreen(
                                                    id: doc.id!,
                                                    detail: doc,
                                                    descriptioncontroller:
                                                        doc.description,
                                                    titlecontroller: doc.title,
                                                  )),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          color: lightgreyclr,
                                          child: ListTile(
                                            title: Text(
                                              snapshot.data![index].title
                                                  .toString(),
                                            ),
                                            subtitle: Text(
                                              snapshot.data![index].description
                                                  .toString(),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            } else if (position.toLowerCase().contains(
                                searchcontroller.text.toLowerCase())) {
                              return Dismissible(
                                  direction: DismissDirection.endToStart,
                                  onDismissed: ((DismissDirection direction) {
                                    dbHelper!.delete(snapshot.data![index].id!);
                                    notesList = dbHelper!.getNotesList();
                                    snapshot.data!
                                        .remove(snapshot.data![index]);
                                  }),
                                  background: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.red,
                                    ),
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: whiteclr,
                                    ),
                                  ),
                                  key: ValueKey<int>(snapshot.data![index].id!),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: SizedBox(
                                      height: 75,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  DetailScreen(
                                                    id: snapshot
                                                        .data![index].id!,
                                                    detail:
                                                        snapshot.data![index],
                                                    descriptioncontroller:
                                                        snapshot.data![index]
                                                            .description,
                                                    titlecontroller: snapshot
                                                        .data![index].title,
                                                  )),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          color: lightgreyclr,
                                          child: ListTile(
                                            title: Text(
                                              snapshot.data![index].title
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            ),
                                            subtitle: Text(
                                              snapshot.data![index].description
                                                  .toString(),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            } else {
                              return Container();
                            }
                          }),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: primaryclr,
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: FloatingActionButton(
          backgroundColor: primaryclr,
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const AddNotes())));
          }),
          child: const Icon(
            Icons.add,
            color: whiteclr,
            size: 35,
          ),
        ),
      ),
    );
  }
}
