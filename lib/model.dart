class ModelView {
  String? id;
  String? title;
  String? desc;

  ModelView({this.id, this.title, this.desc});

  factory ModelView.fromJson(Map<String, dynamic> json) {
    return ModelView(title: json["title"], desc: json["desc"]);
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "desc": desc};
  }
}
