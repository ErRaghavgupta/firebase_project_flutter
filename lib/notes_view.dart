import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_flutter/model.dart';
import 'package:flutter/material.dart';

class NotesApp extends StatelessWidget {
  NotesApp({super.key});

  FirebaseFirestore db = FirebaseFirestore.instance;
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text("NotesApp"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        //* Order by {key:value} {'title':
        stream: db.collection("notes").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error :- ${snapshot.hasError}");
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var model =
                    ModelView.fromJson(snapshot.data!.docs[index].data());
                return Card(
                  color: Colors.amberAccent,
                  child: ListTile(
                    onTap: () {
                      titleController.text = model.title!;
                      descController.text = model.desc!;
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 30),
                              children: [
                                TextField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: "Enter a title",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      fillColor: Colors.white,
                                      label: const Text(
                                        "Enter a title",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: descController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      fillColor: Colors.white,
                                      hintText: "Enter a desc",
                                      label: const Text(
                                        "Enter a desc",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amberAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    onPressed: () {
                                      db
                                          .collection("notes")
                                          .doc(snapshot.data!.docs[index].id)
                                          .update(ModelView(
                                                  title: titleController.text,
                                                  desc: descController.text)
                                              .toJson());
                                      titleController.clear();
                                      descController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Update Notes",
                                      textScaleFactor: 1.4,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          );
                        },
                      );
                    },
                    title: Text(model.title!),
                    subtitle: Text(model.desc!),
                    trailing: IconButton(
                        onPressed: () {
                          db
                              .collection("notes")
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Enter a title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          fillColor: Colors.white,
                          label: const Text(
                            "Enter a title",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: descController,
                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          fillColor: Colors.white,
                          hintText: "Enter a desc",
                          label: const Text(
                            "Enter a desc",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amberAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          db.collection("notes").add(ModelView(
                                  title: titleController.text,
                                  desc: descController.text)
                              .toJson());
                          titleController.clear();
                          descController.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Add Notes",
                          textScaleFactor: 1.4,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    ));
  }
}
