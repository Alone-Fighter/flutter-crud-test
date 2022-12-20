class UsersModel {
  String? id;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phoneNumber;
  String? email;
  String? bankAccountNumber;
  String? region;

  UsersModel({
    this.id,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.phoneNumber,
    this.email,
    this.bankAccountNumber,
    this.region,
  });

  UsersModel.fromJson(Map<String,dynamic> element){
    id = element["id"];
    firstName = element["FName"];
    lastName = element["Lname"];
    dateOfBirth = element["DateOfBirth"];
    phoneNumber = element["PhoneNumber"];
    email = element["Email"];
    bankAccountNumber = element["BankAccountNumber"];
    region = element['Region'];
  }
  Map<String,dynamic> toJson() => {
    'id' : id,
    'FName' : firstName,
    'Lname' : lastName,
    'DateOfBirth' : dateOfBirth,
    'PhoneNumber' : phoneNumber,
    'Email' : email,
    'BankAccountNumber' : bankAccountNumber,
    'Region' : region,
  };
}
