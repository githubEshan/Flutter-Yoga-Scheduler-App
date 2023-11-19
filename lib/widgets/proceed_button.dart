import 'package:csia/services/payment_service/payment_screen.dart';
import 'package:csia/utils/app_color.dart';
import 'package:csia/views/scheduled_classes/all_scheduled_classes.dart';
import 'package:csia/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csia/views/bottom_nav_bar/yoga_event.dart';

class ProceedButton extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const ProceedButton({Key? key, required this.label, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.to(ScheduledScreen()),
      child: Container(
          width: 200,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.deepPurple,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color:Colors.white,
                fontSize: 15,
              ),
            ),
          )
      ),
    );
  }
}
