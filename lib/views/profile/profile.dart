import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csia/controller/data_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/payment_service/payment_screen.dart';
import '../../utils/app_color.dart';
import '../../widgets/my_widgets.dart';
import '../../widgets/pay_button.dart';
import '../home/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

//keeping it not editable unless user clicks on the edit icon
  bool isNotEditable = true;

  DataController? dataController;

  String image = '';

  @override
  initState(){
    super.initState();
    dataController = Get.find<DataController>();

    firstNameController.text = dataController!.myDocument!.get('first');
    lastNameController.text = dataController!.myDocument!.get('last');

    //getting data from firebase and using Dart's try catch error process
    try{
      descriptionController.text = dataController!.myDocument!.get('desc');
    }catch(e){
      descriptionController.text = '';
    }

    try{
      image = dataController!.myDocument!.get('image');
    }catch(e){
      image = '';
    }

    try{
      locationController.text = dataController!.myDocument!.get('location');
    }catch(e){
      locationController.text = '';
    }




  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(
                      left: Get.width * 0.75, top: 20, right: 20),
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: const Image(
                          image: AssetImage('assets/sms.png'),
                          width: 28,
                          height: 25,
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/menu.png'),
                        width: 23.33,
                        height: 19,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 90, horizontal: 20),
                  width: Get.width,
                  height: isNotEditable? 240: 310,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(top: 35),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.deepPurple,
                          borderRadius: BorderRadius.circular(70),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff7DDCFB),
                              Color(0xffBC67F2),
                              Color(0xffACF6AF),
                              Color(0xffF95549),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: image.isEmpty? CircleAvatar(
                                  radius: 56,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                    'assets/profile.png',
                                  )
                              ): CircleAvatar(
                                  radius: 56,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                    image,
                                  )
                              ),
                              // child: Image.asset(
                              //   'assets/profilepic.png',
                              //   fit: BoxFit.contain,
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isNotEditable?Text(
                      "${firstNameController.text} ${lastNameController.text}",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ):
                    Container(
                      width: Get.width*0.6,
                      child: Row(
                        children: [
                          Expanded(child: TextField(
                            controller: firstNameController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'First Name',

                            ),
                          ),),

                          SizedBox(
                            width: 10,
                          ),

                          Expanded(child: TextField(
                            controller: lastNameController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Last Name',

                            ),
                          ),),
                        ],
                      ),
                    ),
                    isNotEditable? Text(
                      "${locationController.text}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff918F8F),
                      ),
                    ):
                    Container(
                      width: Get.width*0.6,
                      child: TextField(
                        controller: locationController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Location',

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isNotEditable?Container(
                      width: 270,
                      child: Text(
                        '${descriptionController.text}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: -0.3,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ): Container(
                      width: Get.width*0.6,
                      child: TextField(
                        controller: descriptionController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Description',

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    PayButton(
                      label: "Proceed to payment",
                      onTap: () =>
                          Get.to(
                            (PaymentScreen()),
                          ),
                    ),
                  ],
                ),),


              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 105, right: 35),

                  child: InkWell
                    (
                    onTap: (){


                      if(isNotEditable ==false){
                        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'first': firstNameController.text,
                          'last': lastNameController.text,
                          'location':locationController.text,
                          'desc': descriptionController.text
                        },SetOptions(merge: true)).then((value) {
                          Get.snackbar('Profile Updated', 'Profile has been updated successfully.',
                              colorText: Colors.white,
                              backgroundColor: Colors.blue);
                        });
                      }


                      setState(() {
                        isNotEditable = !isNotEditable;
                      });





                    },
                    child: isNotEditable? Image(
                      image: AssetImage('assets/edit.png'),
                      width: screenwidth * 0.04,
                    ): Icon(Icons.check,color: Colors.black,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}