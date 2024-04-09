class UserData{

final String Name;
final String Email;
final String userId;
final String cardInfo;


const UserData({

  required this.Name,
  required this.Email,
  required this.userId,
  required this.cardInfo,



});

Map<String, dynamic> toJson () => {


     'Email':Email,
      'Name' :Name,
      'userId':userId,
      'cardInfo':cardInfo,
     
};





}