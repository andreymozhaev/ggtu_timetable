import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'day.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final databaseReference = Firestore.instance;
  bool _week = true;
  String _weekLabel = "Верхняя неделя";
  String _weekValue = 'top';
  DocumentSnapshot _group;
  PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Кафедра", style: TextStyle(fontSize: 22)),
            Text("Информатики",
                style: TextStyle(fontSize: 22, color: Colors.blue))
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: Drawer(child: _buildGroupList(context)),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          day(_group, 'monday', _weekValue),
          day(_group, 'tuesday', _weekValue),
          day(_group, 'wednesday', _weekValue),
          day(_group, 'thursday', _weekValue),
          day(_group, 'friday', _weekValue),
          day(_group, 'saturday', _weekValue)
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              _week = !_week;
              if (_week) {
                _weekLabel = "Верхняя неделя";
                _weekValue = 'top';
              } else {
                _weekLabel = "Нижняя неделя";
                _weekValue = 'bottom';
              }
            });
          },
          label: Text(_weekLabel)),
    );
  }

  Widget _buildGroupList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: databaseReference.collection('groups').orderBy('name').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return DrawerHeader(
                child: Center(
                    child:
                        Text('Список групп', style: TextStyle(fontSize: 22))),
                decoration: BoxDecoration(color: Colors.blue));
          return _groupList(context, snapshot.data.documents);
        });
  }

  Widget _groupList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
        itemCount: snapshot.length + 1,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DrawerHeader(
                child: Center(
                    child:
                        Text('Список групп', style: TextStyle(fontSize: 22))),
                decoration: BoxDecoration(color: Colors.blue));
          } else {
            return ListTile(
                title: Text(snapshot[index - 1].data['name'],
                    style: TextStyle(fontSize: 22)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _group = snapshot[index - 1];
                  });
                });
          }
        });
  }
}
