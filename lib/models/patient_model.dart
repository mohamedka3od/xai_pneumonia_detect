
class PatientModel{
late String id;
late String name;
late String date;
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
  date= json['date'];
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
class PatientInfoModel{
  late String mid;
  late String pid;
  late int week;
  late String date;
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
  }
  Map<String,dynamic>toMap(){
    return {
      'mid':mid,
      'pid':pid,
      'week':week,
      'date':date,
    };
  }


}