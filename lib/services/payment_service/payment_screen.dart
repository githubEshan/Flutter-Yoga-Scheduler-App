import 'package:csia/widgets/pay_button.dart';
import 'package:csia/widgets/proceed_button.dart';
import 'package:flutter/material.dart';
import 'package:csia/views/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/services.dart';

import '../../widgets/my_widgets.dart';

class PaymentScreen extends StatelessWidget {

  Widget buildTextField({
    required double leftPadding,
    required double rightPadding,
    required String hintText,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        top:1,
        left: leftPadding,
        right: rightPadding,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.grey[100],
          filled: true,
            border: OutlineInputBorder(
            borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
        )
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      iconWithTitle(text: 'Payment', func: () {}),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Pay fees for the yoga classes",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 180,
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: SweepGradient(
                      center: AlignmentDirectional(1, -1),
                      startAngle: 1.7,
                      endAngle: 3,
                      colors: const <Color>[Colors.deepPurple, Colors.pink],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "VISA",
                            style: TextStyle(
                              fontSize: 24.30,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "visa Electron",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "****\t\****\t****\t****\t 0001",
                        style: TextStyle(
                          fontSize: 24.3,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                    ]),
                              ),
                              SizedBox(height: 10,),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Expires",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "749374",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Expanded(child: Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          backgroundColor:
                          Colors.deepPurpleAccent,
                        ),
                      )
                      ),
                    ],
                  ),
                ),
Row(
  children: [
                Expanded(child: buildTextField(
                    leftPadding: 20,
                    rightPadding: 10,
                    hintText: 'Card Number'))]),

                Row(
                    children: [
                      Expanded(child: buildTextField(
                          leftPadding: 20,
                          rightPadding: 10,
                          hintText: 'Card Holder'))]),


                Row(
                  children: [
                    Expanded(
                        child: buildTextField(
                          hintText: 'Exp',
                          leftPadding: 20,
                          rightPadding: 10,
                        ),
                    ),
                      Expanded(
                        child: buildTextField(
                          hintText: 'CVV',
                          leftPadding: 10,
                          rightPadding: 10,
                        ),
                      ),
                    Expanded(
                      child: buildTextField(
                        hintText: '  Amount',
                        leftPadding: 10,
                        rightPadding: 10,

    ),
                    ),
                    ],
                ),


                Container(

                  color: Colors.deepPurple,
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 23),
                  child: ProceedButton(
                    label: 'Pay',

                  ),

                ),


              ],
            ),
          ],
        ));
  }
}
