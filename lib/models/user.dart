class UserCustom{
  final String? uid;
  UserCustom({this.uid});
}

class UserData{
  String? uid;
  String? name;
  String? sugars;
  int? strength;
  UserData({required this.sugars,required this.strength,required this.name,required this.uid});
}