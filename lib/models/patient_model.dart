import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel{
late String id;
late String name;
late DateTime date;
late String? email;
late String? phone;
late int? age;
late String? gender;
late String? notes;
PatientModel({
  this.id='',
  required this.name,
  required this.date,
  this.email,
  this.phone,
  this.age,
  this.gender,
  this.notes
});

PatientModel.fromJson(Map<String,dynamic>?json)
{
  id = json!['id'];
  email = json['email'];
  name = json['name'];
  phone = json['phone'];
  date= (json['date'] as Timestamp).toDate();
  age = json['age'];
  gender = json['gender'];
  notes = json['notes'];
}

Map<String,dynamic>toMap()
{
  return{
    'id':id,
    'name' : name,
    'email' : email,
    'phone' : phone,
    'date':date,
    'age':age,
    'gender':gender,
    'notes':notes,
  };
}

}