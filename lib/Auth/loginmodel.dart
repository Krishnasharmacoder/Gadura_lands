// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String message;
    String token;
    User user;

    LoginModel({
        required this.message,
        required this.token,
        required this.user,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user.toJson(),
    };
}

class User {
    String uniqueId;
    String name;
    String email;
    String phone;
    String role;

    User({
        required this.uniqueId,
        required this.name,
        required this.email,
        required this.phone,
        required this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        uniqueId: json["unique_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "unique_id": uniqueId,
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
    };
}
