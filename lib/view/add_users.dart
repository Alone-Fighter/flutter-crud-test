import 'dart:developer';
import 'package:mc_crud_test/component/region_picker.dart';
import 'package:mc_crud_test/controller/homescreen_controller.dart';
import 'package:mc_crud_test/main.dart';
import 'package:mc_crud_test/services/input_formatters.dart';
import 'package:mc_crud_test/services/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../component/custom_textfield.dart';
import '../model/region.dart';

class AddUsers extends StatefulWidget {
  final bool isEdit;
  const AddUsers({super.key, required this.isEdit});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers>
    with AutomaticKeepAliveClientMixin {
  var homeScreenController = Get.find<HomeScreenController>();
  final _paymentCard = PaymentCard();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.others;
    homeScreenController.bank.addListener(_getCardTypeFrmNumber);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    homeScreenController.bank.removeListener(_getCardTypeFrmNumber);
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(homeScreenController.bank.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }
  Future<void> chooseRegions() async {
    dismissKeyboard(context);

    final regions = await homeScreenController.store.getRegions();

    final route = MaterialPageRoute<Region>(
      fullscreenDialog: true,
      builder: (_) => RegionPicker(regions: regions),
    );

    if (!mounted) return;
    final selectedRegion = await Navigator.of(context).push<Region>(route);

    if (selectedRegion != null) {
      log('Region selected: $selectedRegion');
      homeScreenController.regionController.text =
      "(+${selectedRegion.prefix})";
      setState(() => homeScreenController.region = selectedRegion);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: homeScreenController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  CustomTextField(
                    text: 'First Name',
                    controller: homeScreenController.fName,
                    validator: homeScreenController.fnameValidator,
                  ),
                  CustomTextField(
                    text: 'Last Name',
                    controller: homeScreenController.lName,
                    validator: homeScreenController.lnameValidator,
                  ),
                  CustomTextField(
                    enable: true,
                    text: 'Date Of Birth',
                    controller: homeScreenController.dateOfBirth,
                    validator: homeScreenController.dateodbirthValidator,
                    suffixIcon: InkWell(
                      onTap: ()async{
                        DateTime? pickedate = await showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(DateTime.now().year - 100),lastDate: DateTime(DateTime.now().year + 50));
                        if(pickedate != null){
                          homeScreenController.dateOfBirth.text = pickedate.toString().substring(0,10);
                        }
                        else{

                        }
                      },
                      child: const Icon(Icons.calendar_month,size: 40,),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            spreadRadius: 0.1,
                            offset: const Offset(0, 1),
                          )
                        ]
                    ),
                    width: Get.width * 0.8,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: const EdgeInsets.only(bottom: 10, right: 3, left: 3),
                    child: FormBuilderTextField(
                      onChanged: (val)async{
                        homeScreenController.phoneValidate();
                      },
                      controller: homeScreenController.phoneNumber,
                      validator: (String? value) =>
                      homeScreenController.phoneNumberValid
                          ? null
                          : "The phone number entered is not valid",
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: chooseRegions,
                                child: SizedBox(
                                  width: 45,
                                  height: 50,
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      controller:
                                      homeScreenController.regionController,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                      decoration: InputDecoration(
                                        hintText: '(+${homeScreenController.region!.prefix})',
                                        hintStyle: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'PhoneNumber',
                        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                        border: InputBorder.none,
                      ), name: '',
                    ),),
                  CustomTextField(
                    text: 'Email',
                    controller: homeScreenController.email,
                    validator: homeScreenController.emailValidator,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            spreadRadius: 0.1,
                            offset: const Offset(0, 1),
                          )
                        ]
                    ),
                    width: Get.width * 0.8,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: const EdgeInsets.only(bottom: 10, right: 3, left: 3),
                    child: FormBuilderTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                        CardNumberInputFormatter()
                      ],
                      controller: homeScreenController.bank,
                      onSaved: (String? value) {
                        _paymentCard.number = CardUtils.getCleanedNumber(value!);
                      },
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      validator: CardUtils.validateCardNum,
                      decoration: InputDecoration(
                        suffixIcon: CardUtils.getCardIcon(_paymentCard.type),
                        hintText: 'BankAccountNumber',
                        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                        border: InputBorder.none,
                      ), name: '',
                    ),),
                  InkWell(
                    onTap: () {
                      widget.isEdit ? homeScreenController.editData() : homeScreenController.submit();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                        child: Text('Submit',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
