import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_crud_test/model/region.dart';
import 'package:mc_crud_test/services/dio_services.dart';
import 'package:mc_crud_test/services/store.dart';
import 'package:mc_crud_test/view/add_users.dart';
import 'package:phone_number/phone_number.dart';

import '../model/users_model.dart';

class HomeScreenController extends GetxController {

  RxList<UsersModel> userList = RxList();
  final formKey = GlobalKey<FormState>();
  final store = Store(PhoneNumberUtil());
  Region? region = Region('IR', 98, 'Iran');
  bool phoneNumberValid = false;
  String idEdit = '';



  // text editing controller
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController regionController = TextEditingController();

  // validations
  var emailValidator = (String? value) => value!.isEmail ? null : "The email entered is not valid";
  var fnameValidator = (String? value) => value!.isNotEmpty ? null : " Please enter your First Name";
  var lnameValidator = (String? value) => value!.isNotEmpty ? null : " Please enter your Last Name";
  var dateodbirthValidator = (String? value) => value!.isNotEmpty ? null : " Please enter your Date Of Birth";
  var bankValidator = (String? value) => value!.isNotEmpty ? null : " Please enter your Bank Account Number";


  @override
  onInit() async{
    super.onInit();
    getHomeUsers();
  }

  // get all data from database
  void getHomeUsers ()async{
    userList.clear();
    var response =await DioService().getData();
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        userList.add(UsersModel.fromJson(element));
      });
    }
  }

  //clear text field for after add and edit
  void clearText(){
    fName.text = '';
    lName.text = '';
    dateOfBirth.text = '';
    phoneNumber.text = '';
    email.text = '';
    bank.text = '';
    region = Region('IR', 98, 'Iran');
   }

   // validating phone number
  Future<void> phoneValidate() async {
    final isValid = await store.validate(
      phoneNumber.text,
      region: region,
    );
    phoneNumberValid = isValid;
    log('isValid : $isValid');
    // Get.snackbar(
    //   'Notif',
    //   "Validation Status: ${isValid ? 'Valid' : 'Invalid'}",
    //   icon: Icon(
    //     isValid ? Icons.check_circle : Icons.cancel,
    //     size: 20,
    //     color: isValid ? Colors.green : Colors.red,
    //   ),
    //   backgroundColor: Colors.white,
    // );
  }




  // add user to data base method
  void submit ()async{
    if(formKey.currentState!.validate()) {
      Map<String,dynamic> map = {
        'FName' : fName.text,
        'Lname' : lName.text,
        'DateOfBirth' : dateOfBirth.text,
        'PhoneNumber' : phoneNumber.text,
        'Email' : email.text,
        'BankAccountNumber' : bank.text,
        'Region' : '${region!.name}  ${region!.code}  ${region!.prefix}',

      };
      var response = await DioService().postData(map);
      if(response.data == 'Submit Successful'){
        getHomeUsers();
        clearText();
        Get.back();
        Get.snackbar('Success', response.data,backgroundColor: Colors.blueAccent.withOpacity(0.3),colorText: Colors.black,icon: const Icon(Icons.task_alt,color: Colors.green,));

      }
      else{
        Get.snackbar('Error', response.data,backgroundColor: Colors.blueAccent.withOpacity(0.3),colorText: Colors.black,icon: const Icon(Icons.error,color: Colors.red,));
      }
    }

  }


  // delete user from data base method
  void delete(String id)async{
    var response = await DioService().deleteData(id);
    if(response.data == "Delete Successful"){
      Get.snackbar('Success', response.data,backgroundColor: Colors.blueAccent.withOpacity(0.3),colorText: Colors.black,icon: const Icon(Icons.task_alt,color: Colors.green,));
    }
    else{
      Get.snackbar('Error', response.data,backgroundColor: Colors.blueAccent.withOpacity(0.3),colorText: Colors.black,icon: const Icon(Icons.error,color: Colors.red,));
    }
    getHomeUsers();
  }

  //fill text field for edit
  void fillText(int id){
    fName.text = userList[id].firstName!;
    lName.text = userList[id].lastName!;
    dateOfBirth.text = userList[id].dateOfBirth!;
    phoneNumber.text = userList[id].phoneNumber!;
    email.text = userList[id].email!;
    bank.text = userList[id].bankAccountNumber!;
    List regionInfo = userList[id].region!.split('  ');
    region = Region(regionInfo[1], int.parse(regionInfo[2]), regionInfo[0]);
    regionController.text = '(+${region!.prefix})';
    idEdit = userList[id].id!;
    phoneValidate();
    log(region!.name);
    Get.to(()=>const AddUsers(isEdit: true,));
  }

  // edit user method
  void editData()async{
    if(formKey.currentState!.validate()) {
      Map<String,dynamic> map = {
        'id' : idEdit,
        'FName' : fName.text,
        'Lname' : lName.text,
        'DateOfBirth' : dateOfBirth.text,
        'PhoneNumber' : phoneNumber.text,
        'Email' : email.text,
        'BankAccountNumber' : bank.text,
        'Region' : '${region!.name}  ${region!.code}  ${region!.prefix}',
      };
      log(map.toString());
      var response = await DioService().editData(map);
      if(response.data == 'Edit Successful'){
        getHomeUsers();
        clearText();
        Get.back();
        Get.snackbar('Success', response.data,backgroundColor: Colors.blueAccent.withOpacity(0.3),colorText: Colors.black,icon: const Icon(Icons.task_alt,color: Colors.green,));

      }
      else{
        Get.snackbar('Error', response.data,backgroundColor: Colors.blueAccent.withOpacity(0.3),colorText: Colors.black,icon: const Icon(Icons.error,color: Colors.red,));
      }
    }
  }


}