import 'package:csia/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csia/views/bottom_nav_bar/yoga_event.dart';

class AddClass extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const AddClass({Key? key,
    required this.label,
    this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.to(CreateEventView()),
      child: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.deepPurple,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color:Colors.white,
                fontSize: 12,
              ),
            ),
          )
      ),
    );
  }
}
