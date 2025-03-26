class UserInfo {
  UserInfo({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  final int? id;
  final String? title;
  final String? body;
  final int? userId;

  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      userId: json["userId"],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['userId'] = this.userId;
    return data;
  }
}
