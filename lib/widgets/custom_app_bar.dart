import 'package:csia/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';
import 'my_widgets.dart';

Widget CustomAppBar(){
  return Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 160,
                        height: 17,
                        child: myText(
                            text: 'IA',
                            style: TextStyle(
                                color: AppColors.deepPurple,
                                fontWeight: FontWeight.bold,fontSize: 16)),
                      ),
                      Spacer(),
                      Container(
                        width: 24,
                        height: 22,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => HomeScreen());
                          },
                          child: Image.asset('assets/Frame.png'),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.04,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 22,
                          height: 20,
                          child: Image.asset(
                            'assets/menu.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                
}