class NoteModel {
  final String? id; // MongoDB _id will be a string
  final String? notes;

  NoteModel({
    this.id,
    this.notes,
  });

  // Convert JSON map to NoteModel
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    print('${json["userId"]}');
    return NoteModel(
      id: json['_id'] ?? json['id'],
      notes: json['notes'],
    );
  }

  // Convert NoteModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'notes': notes,
    };
  }
}
