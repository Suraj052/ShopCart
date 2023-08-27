
class UserData
{
  String Name;
  String Email;
  String Password;
  String Mobile;
  String Address ;
  String PhotoUrl ;

  UserData({

    required this.Name,
    required this.Email,
    required this.Password,
    required this.Mobile,
    this.Address='',
    this.PhotoUrl=''
  });

  static UserData fromJson(Map<String,dynamic>? json)=>
    UserData(
      Name: json!['Name'],
      Email: json['Email'],
      Password: json['Password'],
      Mobile: json['Mobile'],
      Address : json['Address'],
      PhotoUrl: json['PhotoUrl']
    );

  Map<String,dynamic> toJson()=>
      {
        'Name': Name,
        'Email' : Email,
        'Password':Password,
        'Mobile' : Mobile,
        'Address' : Address,
        'PhotoUrl': PhotoUrl
      };
}