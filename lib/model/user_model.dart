class UserModel {
  UserModel({
    this.name,
    this.designation,
    this.state,
    this.phoneNumber,
    this.profilePic,
  });

  // fromJson method
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String?,
      designation: json['designation'] as String?,
      state: json['state'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profilePic: json['profilePic'] as String?,
    );
  }
  String? name;
  String? designation;
  String? state;
  String? phoneNumber;
  String? profilePic;

  // copyWith method
  UserModel copyWith({
    String? name,
    String? designation,
    String? state,
    String? phoneNumber,
    String? profilePic,
  }) {
    return UserModel(
      name: name ?? this.name,
      designation: designation ?? this.designation,
      state: state ?? this.state,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'designation': designation,
      'state': state,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
    };
  }
}
