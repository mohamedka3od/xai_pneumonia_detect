
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel{
late String id;
late String name;
late String date;
late DateTime dateTime;
late String? email;
late String? phone;
late int? age;
late String? gender;
late String? notes;
late String? imageUrl;
late bool important;
PatientModel({
  this.id='',
  required this.name,
  required this.date,
  this.email,
  this.phone,
  this.age,
  this.gender,
  this.notes,
  this.imageUrl,
});

PatientModel.fromJson(Map<String,dynamic>?json)
{
  id = json!['id'];
  email = json['email'];
  name = json['name'];
  phone = json['phone'];
  date= json['date'];
  dateTime= (json['dateTime'] as Timestamp).toDate();
  age = json['age'];
  gender = json['gender'];
  notes = json['notes'];
  imageUrl= json['imageUrl'];
  important = json['important'];
}

Map<String,dynamic>toMap()
{
  return{
    'id':id,
    'name' : name,
    'email' : email,
    'imageUrl':imageUrl,
    'phone' : phone,
    'date':date,
    'dateTime':DateTime.now(),
    'age':age,
    'gender':gender,
    'notes':notes,
    'important':false,
  };
}

}
class PatientInfoModel{
  late String mid;
  late String pid;
  late int week;
  late String date;
  late DateTime dateTime;
  PatientInfoModel({
    required this.mid,
    required this.pid,
    required this.week,
    required this.date,
});
  PatientInfoModel.fromJson(Map<String,dynamic>?json){
    mid = json!['mid'];
    pid= json['pid'];
    week = json['week'];
    date = json['date'];
    dateTime= (json['dateTime'] as Timestamp).toDate();
  }
  Map<String,dynamic>toMap(){
    return {
      'mid':mid,
      'pid':pid,
      'week':week,
      'date':date,
      'dateTime':DateTime.now(),
    };
  }


}