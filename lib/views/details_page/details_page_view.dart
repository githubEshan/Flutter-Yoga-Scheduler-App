import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csia/controller/data_controller.dart';
import 'package:csia/utils/date_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_color.dart';
import 'package:intl/intl.dart';

class DetailsPageView extends StatefulWidget {
  DocumentSnapshot eventData, user;

  DetailsPageView(this.eventData, this.user);

  @override
  _DetailsPageViewState createState() => _DetailsPageViewState();
}

class _DetailsPageViewState extends State<DetailsPageView> {
  DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    String image = '';

    try {
      image = widget.user.get('image');
    } catch (e) {
      image = '';
    }

    // DateTime d = DateTime.tryParse(widget.eventData.get('date'))!;

    // String formattedDate = formatDate(widget.eventData.get('date'));
    //DateFormat("dd-MMM").format(d);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 50, bottom: 20),
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'assets/Header.png',
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.eventData.get('event_name')}",
                        style: TextStyle(
                            fontSize: 25,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${widget.user.get('location')}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${widget.eventData.get('date')}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Location of the yoga class:   '
                    '${widget.eventData.get('location')}',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                "\Class Description:   ${widget.eventData.get('description')}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Column(
                children: [
                  Text(
                    "\Frequency:   ${widget.eventData.get('frequency_of_event')}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0xff0000FF), width: 1.5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  '${widget.eventData.get('start_time')}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column()
            ],
          ),
        ),
      ),
    );
  }
}
