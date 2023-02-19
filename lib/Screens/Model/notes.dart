class NotesModel {
  int? id;
  String description;
  String title;
  NotesModel({
    this.id,
    required this.description,
    required this.title,
  });
  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        description = res['description'],
        title = res['title'];
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
