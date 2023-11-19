import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:csia/controller/data_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../utils/app_color.dart';
import '../../widgets/my_widgets.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  DateTime? date = DateTime.now();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController frequencyEventController = TextEditingController();
  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);

  var selectedFrequency = -2;

  void resetControllers() {
    dateController.clear();
    timeController.clear();
    titleController.clear();
    locationController.clear();
    descriptionController.clear();
    endTimeController.clear();
    startTimeController.clear();
    frequencyEventController.clear();
    startTime = TimeOfDay(hour: 0, minute: 0);
    endTime = TimeOfDay(hour: 0, minute: 0);
    setState(() {});
  }

  var isCreatingEvent = false.obs;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      date = DateTime(picked.year, picked.month, picked.day, date!.hour,
          date!.minute, date!.second);
      dateController.text = '${date!.day}-${date!.month}-${date!.year}';
    }
    setState(() {});
  }

  startTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      startTime = picked;
      startTimeController.text =
          '${startTime.hourOfPeriod > 9 ? "" : '0'}${startTime.hour > 12 ? '${startTime.hour - 12}' : startTime.hour}:${startTime.minute > 9 ? startTime.minute : '0${startTime.minute}'} ${startTime.hour > 12 ? 'PM' : 'AM'}';
    }
    print("start ${startTimeController.text}");
    setState(() {});
  }

  endTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      endTime = picked;
      endTimeController.text =
          '${endTime.hourOfPeriod > 9 ? "" : "0"}${endTime.hour > 9 ? "" : "0"}${endTime.hour > 12 ? '${endTime.hour - 12}' : endTime.hour}:${endTime.minute > 9 ? endTime.minute : '0${endTime.minute}'} ${endTime.hour > 12 ? 'PM' : 'AM'}';
    }

    print(endTime.hourOfPeriod);
    setState(() {});
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // List<File> media = [];
  // List thumbnail = [];
  // List<bool> isImage = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeController.text = '${date!.hour}:${date!.minute}:${date!.second}';
    dateController.text = '${date!.day}-${date!.month}-${date!.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                iconWithTitle(text: 'Schedule a Yoga Class', func: () {}),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                myTextField(
                    bool: false,
                    icon: 'assets/4DotIcon.png',
                    text: 'Yoga Class Name',
                    controller: titleController,
                    validator: (String input) {
                      if (input.isEmpty) {
                        Get.snackbar('Opps', "Yoga class name is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }

                      if (input.length < 3) {
                        Get.snackbar(
                            'Opps', "Yoga class name should be 3+ characters.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    },
                    colorText: Colors.white),

                SizedBox(
                  height: 20,
                ),
                myTextField(
                    bool: false,
                    icon: 'assets/location.png',
                    text: 'Location of the class',
                    controller: locationController,
                    validator: (String input) {
                      if (input.isEmpty) {
                        Get.snackbar(
                            'Opps', "Location of the class is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }

                      if (input.length < 3) {
                        Get.snackbar('Opps', "Location is Invalid.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    },
                    colorText: Colors.white),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 355,
                  child: iconTitleContainer(
                    isReadOnly: true,
                    path: 'assets/Frame1.png',
                    text: 'Date',
                    controller: dateController,
                    validator: (input) {
                      if (date == null) {
                        Get.snackbar('Opps', "Date of the class is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    },
                    onPress: () {
                      _selectDate(context);
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Container(
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: AppColors.genderTextColor),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      Get.bottomSheet(StatefulBuilder(builder: (ctx, state) {
                        return Container(
                          width: double.infinity,
                          height: Get.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                children: [
                                  selectedFrequency == 10
                                      ? Container()
                                      : SizedBox(
                                          width: 5,
                                        ),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      selectedFrequency = -1;

                                      state(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: selectedFrequency == -1
                                            ? Colors.blue
                                            : Colors.black.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Once",
                                          style: TextStyle(
                                              color: selectedFrequency != -1
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                                  selectedFrequency == 10
                                      ? Container()
                                      : SizedBox(
                                          width: 5,
                                        ),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      selectedFrequency = 0;

                                      state(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: selectedFrequency == 0
                                            ? Colors.blue
                                            : Colors.black.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Daily",
                                          style: TextStyle(
                                              color: selectedFrequency != 0
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                                  selectedFrequency == 10
                                      ? Container()
                                      : SizedBox(
                                          width: 10,
                                        ),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      state(() {
                                        selectedFrequency = 1;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selectedFrequency == 1
                                            ? Colors.blue
                                            : Colors.black.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Alternate",
                                          style: TextStyle(
                                              color: selectedFrequency != 1
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                                  selectedFrequency == 10
                                      ? Container()
                                      : SizedBox(
                                          width: 10,
                                        ),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                children: [
                                  selectedFrequency == 10
                                      ? Container()
                                      : SizedBox(
                                          width: 10,
                                        ),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      state(() {
                                        selectedFrequency = 2;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selectedFrequency == 2
                                            ? Colors.blue
                                            : Colors.black.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Weekly",
                                          style: TextStyle(
                                              color: selectedFrequency != 2
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                                  selectedFrequency == 10
                                      ? Container()
                                      : SizedBox(
                                          width: 10,
                                        ),
                                  Expanded(
                                      child: InkWell(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selectedFrequency == 3
                                            ? Colors.blue
                                            : Colors.black.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Separately scheduled",
                                          style: TextStyle(
                                              color: selectedFrequency != 3
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      state(() {
                                        selectedFrequency = 3;
                                      });
                                    },
                                  )),
                                  selectedFrequency == 10
                                      ? Container()
                                      : SizedBox(
                                          width: 5,
                                        ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                    minWidth: Get.width * 0.8,
                                    onPressed: () {
                                      frequencyEventController.text =
                                          selectedFrequency == -1
                                              ? 'Once'
                                              : selectedFrequency == 0
                                                  ? 'Daily'
                                                  : selectedFrequency == 1
                                                      ? 'Alternate'
                                                      : selectedFrequency == 2
                                                          ? 'Weekly'
                                                          : 'Separately scheduled';
                                      Get.back();
                                    },
                                    child: Text(
                                      "Select",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }));
                    },
                    validator: (String? input) {
                      if (input!.isEmpty) {
                        Get.snackbar('Opps', "Frequency is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    },
                    controller: frequencyEventController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 3),
                      errorStyle: TextStyle(fontSize: 0),
                      hintStyle: TextStyle(
                        color: AppColors.genderTextColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Frequency of the yoga class',
                      prefixIcon: Image.asset(
                        'assets/repeat.png',
                        cacheHeight: 20,
                      ),
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),

                // myTextField(
                //     bool: false,
                //     icon: 'assets/repeat.png',
                //     text: 'Frequecy of event',
                //     controller: frequencyEventController,
                //     validator: (String input){
                //       if(input.isEmpty){
                //         Get.snackbar('Opps', "Frequency is required.",colorText: Colors.white,backgroundColor: Colors.blue);
                //         return '';
                //       }
                //     }
                // ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconTitleContainer(
                        path: 'assets/time.png',
                        text: 'Start Time',
                        controller: startTimeController,
                        isReadOnly: true,
                        validator: (input) {},
                        onPress: () {
                          startTimeMethod(context);
                        }),
                    iconTitleContainer(
                        path: 'assets/time.png',
                        text: 'End Time',
                        isReadOnly: true,
                        controller: endTimeController,
                        validator: (input) {},
                        onPress: () {
                          endTimeMethod(context);
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    myText(
                        text: 'Details/Health problems',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 149,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: AppColors.genderTextColor),
                  ),
                  child: TextFormField(
                    maxLines: 5,
                    controller: descriptionController,
                    validator: (input) {
                      if (input!.isEmpty) {
                        Get.snackbar('Opps', "Details are required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 25, left: 15, right: 15),
                      hintStyle: TextStyle(
                        color: AppColors.genderTextColor,
                      ),
                      hintText:
                          'Please add any medical/health issues faced or any other issues thus the instructor can plan beforehand accordingly ',
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(8.0),
                      // ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => isCreatingEvent.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: 42,
                        width: double.infinity,
                        child: elevatedButton(
                            onpress: () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              isCreatingEvent(true);

                              DataController dataController = Get.find();

                              Map<String, dynamic> eventData = {
                                'event_name': titleController.text,
                                'location': locationController.text,
                                'date':
                                    '${date!.day}-${date!.month}-${date!.year}',
                                'start_time': startTimeController.text,
                                'end_time': endTimeController.text,
                                'frequency_of_event':
                                    frequencyEventController.text,
                                'description': descriptionController.text,
                                'joined': [
                                  FirebaseAuth.instance.currentUser!.uid
                                ],
                                'uid': FirebaseAuth.instance.currentUser!.uid,
                                'inviter': [
                                  FirebaseAuth.instance.currentUser!.uid
                                ]
                              };

                              await dataController
                                  .createEvent(eventData)
                                  .then((value) {
                                print("Class is done");
                                isCreatingEvent(false);
                                resetControllers();
                              });
                            },
                            text: 'Schedule Class'),
                      )),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
