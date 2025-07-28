class TodoModel {
  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.v,
  });

  final String? id;
  final String? title;
  final String? description;
  final int? v;

  factory TodoModel.fromJson(Map<String, dynamic> json){
    return TodoModel(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "__v": v,
  };

}
