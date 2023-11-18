import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

//late String id;
  late String firstname, lastname, email, id, phone; 
   String? state, zipcode, city, address;
  // double? latitude,longitude;
  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.state,
    required this.zipcode,
    required this.city,
    required this.address,
     

    
  });

  UserModel.fromMap(Map<String, dynamic>data)
  {
    id = data["id"];
    firstname = data['firstname'];
    lastname = data['lastname'];
    phone = data['phone'];
    email = data['email'];
    state = data['state'];
    zipcode = data['zipcode'];
    city = data['city'];
    address = data['address'];
    

  }

  Map<String, dynamic>toMap(){
    return{
      "id": id,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'email': email,
      'state': state,
      'zipcode': zipcode,
      'city': city,
      'address': address,
      'timestamp': Timestamp.now(),
      
    };
  }

}