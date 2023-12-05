import 'dart:io';

class AdminModel {
  late String? name;
  late String? uId;
  late String? phoneNumber;
  late File? adminPhoto;

  AdminModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    uId = json['uId'];
    adminPhoto = json['adminPhoto'];
  }

  AdminModel({required this.name});
}
