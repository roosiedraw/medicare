class UserModel {
  String? displayname;
  String? email;
  String? photoURL;

  //Constructor
  UserModel({this.displayname, this.email, this.photoURL});

  //create map
  UserModel.fromJson(Map<String, dynamic> json) {
    displayname = json["displayName"];
    email = json["email"];
    photoURL = json["photoURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["displayName"] = this.displayname;
    data["email"] = this.email;
    data["photoURL"] = this.photoURL;
    return data;
  }
}
