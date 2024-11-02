enum Gender { female, male }

class UserModel {
  String? uid;
  String? name;
  String? username;
  String? email;
  String? avatar;
  String? password;
  DateTime? birthday;
  String? role;
  Gender? gender;
  String? about;
  bool? online;
  DateTime? emailVerifiedAt;
  DateTime? lastOnline;
  String? fcmToken;
  Map<String, bool>?
      typingStatus; // Map untuk menyimpan status typing per chat room

  UserModel({
    this.uid,
    this.name,
    this.username,
    this.email,
    this.avatar,
    this.password,
    this.birthday,
    this.role,
    this.about,
    this.online,
    this.typingStatus,
    this.emailVerifiedAt,
    this.lastOnline,
    this.gender = Gender.male,
    this.fcmToken,
  });

  factory UserModel.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid: documentId,
      username: data['username'] ?? 'Unknown User',
      name: data['name'] ?? 'Unknown User',
      email: data['email'] ?? 'Unknown Email',
      avatar: data['avatar'] ?? 'https://avatar.iran.liara.run/public',
    );
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    username = json['username'];
    avatar = json['avatar'];
    email = json['email'];
    password = json['password'];
    birthday = json['birthday']?.toDate();
    role = json['role'];
    about = json['about'];
    online = json['online'];
    gender = Gender.male;
    fcmToken = json['fcmToken'] ?? '';
    emailVerifiedAt = json['emailVerifiedAt']?.toDate();
    lastOnline = json['lastOnline']?.toDate();
    typingStatus = json['typingStatus'] != null
        ? Map<String, bool>.from(json['typingStatus'])
        : {}; // Konversi ke Map jika ada data
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['birthday'] = birthday;
    data['role'] = role;
    data['about'] = about;
    data['online'] = online;
    data['avatar'] = avatar;
    data['typingStatus'] = typingStatus;
    data['emailVerifiedAt'] = emailVerifiedAt;
    data['lastOnline'] = lastOnline;
    data['gender'] = gender.toString().split('.').last;
    data['fcmToken'] = fcmToken;

    return data;
  }

  //   to post

  toPostJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }

  toSignInJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  toSignUpJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, name: $name, username: $username, email: $email, avatar: $avatar, password: $password, birthday: $birthday, |';
  }
}
