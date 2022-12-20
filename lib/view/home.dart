import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_crud_test/controller/homescreen_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(() =>const AddUsers(isEdit: false,));
              },
              child: const Icon(Icons.add)),
          body: Obx(() {
            return ListView.builder(
              itemCount: homeScreenController.userList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  alignment: Alignment.topLeft,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'First Name : ${homeScreenController.userList[index].firstName}'),
                              Text(
                                  'Last Name : ${homeScreenController.userList[index].lastName}'),
                              Text(
                                  'DateOfBirth : ${homeScreenController.userList[index].dateOfBirth}'),
                              Text(
                                  'PhoneNumber : ${homeScreenController.userList[index].phoneNumber}'),
                              Text(
                                  'Email : ${homeScreenController.userList[index].email}'),
                              Text(
                                  'BankAccountNumber : ${homeScreenController.userList[index].bankAccountNumber}'),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    homeScreenController.fillText(index);
                                  }, child: const Icon(Icons.edit)),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: 'Delete',
                                      middleText: 'Are you Sure?',
                                      actions: [
                                        InkWell(
                                          onTap: (){
                                            homeScreenController.delete(
                                                homeScreenController.userList[index].id
                                                    .toString());
                                          },
                                          child: const Icon(Icons.assignment_turned_in_outlined,color: Colors.green,size: 35,),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Get.back();
                                          },
                                          child: const Icon(Icons.cancel_outlined,color: Colors.red,size: 35,),
                                        ),
                                      ],
                                    );

                                  },
                                  child: const Icon(Icons.delete)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          })),
    );
  }
}
