import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'auth/login_signup.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),

            const Text("Welcome to the yoga app!",style: TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.w700,
            ),),

            const SizedBox(
              height: 5,
            ),


            const SizedBox(
              height: 50,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_kxbbm812.json'),
            ),


            Expanded(
              child: Container(
                width: 450,

                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2
                      )
                    ],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40,
                          right: 40
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.white,
                        elevation: 2,
                        onPressed: (){
                          Get.to(()=> LoginView());
                        },

                        child: const Text("Get Started",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff274560),
                              fontWeight: FontWeight.w500
                          ),),),
                    )

                  ],
                ),
              ),
            ),

          ],

        ),
      ),
    ));
  }
}
