import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateFormat outPutDateFormat =  DateFormat('dd-MM-yyyy');
final DateFormat monthFormat =  DateFormat('MMM, yyyy');
DateTime selectedDate = DateTime.now();
String today =  DateFormat('dd-MM-yyyy')
    .format(DateTime.now());

Future<String> selectDate(BuildContext context) async {
  String formattedDate="";
  final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectedDate) {

     formattedDate = outPutDateFormat.format(picked);
    print(formattedDate);
   // date = formattedDate;
    // setState(() {
    //   selectedDate = picked;
    // });
  }
  return formattedDate;
}
