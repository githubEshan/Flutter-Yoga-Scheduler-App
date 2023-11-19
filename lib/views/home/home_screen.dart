

import 'package:csia/views/scheduled_classes/all_scheduled_classes.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';

import 'package:csia/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csia/views/bottom_nav_bar/yoga_event.dart';
import 'package:csia/widgets/add_event.dart';
import 'package:csia/widgets/my_widgets.dart';
import 'package:intl/intl.dart';

import '../../utils/app_color.dart';
import '../../widgets/add_event.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/events_feed_widget.dart';
import '../bottom_nav_bar/yoga_event.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List dataList =[];
  DateTime _selectedDate = DateTime.now();
  DataController dataController = Get.find<DataController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.03),
      body: SafeArea(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(),
                    Container(
                      margin: const EdgeInsets.only(right: 5, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Today's Yoga Classes",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                        DateFormat.yMMMd()
                                            .format(DateTime.now()),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ])),
                          ScheduledScreen(
                              label: "Schedule a class",
                              onTap: () =>
                                  Get.to(
                                    (CreateEventView()),
                                  ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: DatePicker(
                        DateTime.now(),
                        height: 100,
                        width: 70,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Colors.deepPurple,
                        dateTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                        monthTextStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                        dayTextStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                        onDateChange: (date) {
                          _selectedDate = date;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),const SizedBox(
                      height: 20,
                    ),
                    EventsFeed(),
                    Obx(()=> dataController.isUsersLoading.value? Center(child: CircularProgressIndicator(),) : EventsIJoined())
                  ],
                ),
              ))),
    );
  }
}
