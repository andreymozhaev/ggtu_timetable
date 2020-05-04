import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtu_timetable/help.dart';

Widget day(DocumentSnapshot group, String dayOfWeek, String week) {
  if (group == null)
    return Container(child: Center(child: Image.asset('assets/ggtu.png')));
  var day = group.data['weeks'][week][dayOfWeek];
  if (day == null ||
      day[0] == null && day[1] == null && day[2] == null && day[3] == null)
    return Column(children: <Widget>[
      Container(
          child: ListTile(
        title: Center(
          child: Text(weekDay[dayOfWeek],
              style: TextStyle(fontSize: 22, color: Colors.blue)),
        ),
      )),
      Expanded(child: Image.asset('assets/sampo.png'))
    ]);
  int _count = 0;
  _count = group.data['weeks'][week][dayOfWeek].length;
  return ListView.builder(
      itemCount: _count + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            title: Center(
              child: Text(weekDay[dayOfWeek],
                  style: TextStyle(fontSize: 22, color: Colors.blue)),
            ),
          );
        }
        if (group.data['weeks'][week][dayOfWeek][index - 1] == null)
          return ListTile(
              );
        return ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text((index).toString(),
                  style: TextStyle(fontSize: 22, color: Colors.white))),
          title: Text(
            (group.data['weeks'][week][dayOfWeek][index - 1]['name'] != null)
                ? group.data['weeks'][week][dayOfWeek][index - 1]['name'] + " ("+
                    lessonType[group.data['weeks'][week][dayOfWeek][index - 1]
                        ['type']]+")"
                : '',
          ),
          subtitle: Text((group.data['weeks'][week][dayOfWeek][index - 1]
                      ['teacher'] !=
                  null)
              ? group.data['weeks'][week][dayOfWeek][index - 1]['teacher']
              : ''),
          trailing: Text((group.data['weeks'][week][dayOfWeek][index - 1]
                      ['cabinet'] !=
                  null)
              ? group.data['weeks'][week][dayOfWeek][index - 1]['cabinet']
              : ''),
        );
      });
}
