import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'NewPage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';




void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      home: MyHomePage(),
      routes: {
        '/NewPage': (context)=>NewPage(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends  State<MyHomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff8f8f8),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*0.43,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xfff5ceb8),
                  child: Container(
                    margin: EdgeInsets.only(right: 40, top: 20, bottom: 20),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('./asset/path.png'),
                        fit: BoxFit.contain
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: <Widget> [
                SizedBox( height: 100, ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(20),
                  child: Text("Hoşgeldin", style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700
                  ),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                  child: Row(
                    children: <Widget> [
                      Icon(Icons.search,
                      size: 30,),
                      SizedBox(width: 20,),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ara',
                            hintStyle: TextStyle(
                              fontSize: 20,
                            )
                          ),
                        )
                      )
                    ],
                  )
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: GridView.count(crossAxisCount: 2,
                  childAspectRatio: 0.85,
                    children: <Widget> [
                      categoryWidget('img1', "Diyet Tavsiyesi"),
                      categoryWidget('img2', "Kegel Egzersizi"),
                      categoryWidget('img3', "Meditasyon"),
                      categoryWidget('img4', "Yoga"),
                    ],

                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget> [
                      Column(
                        children: <Widget> [
                          IconButton(
                              icon: Icon(
                                FontAwesomeIcons.calendar,
                                color: Colors.black,
                              ),
                              onPressed: (){
                                Navigator
                                .push(context, MaterialPageRoute(
                                    builder: (context)=>takvimpage()
                                ),
                                );
                              }
                          ),

                          Text('Takvim'),
                        ],
                      ),
                      Column(
                        children: <Widget> [
                          FaIcon(FontAwesomeIcons.dumbbell, color: Colors.orange,),
                          Text('Egzersizler', style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ))
                        ],
                      ),
                      Column(
                        children: <Widget> [
                          IconButton(
                          icon: Icon(Icons.settings, color:Colors.black,
                          ),
                            onPressed: (){
                            Navigator
                            .push(context,MaterialPageRoute(builder: (context) => ayarlarpage()
                            ),
                            );
                            },
                          ),
                          Text('Ayarlar'),
                        ],
                        ),

                    ],
                  )
                )
              ],
            )
          ],
        ),
    );

  }
  Container categoryWidget( String img, String title)
  {
    return Container(
      margin: EdgeInsets.only(left:10, right: 10, bottom: 20),
      width: MediaQuery.of(context).size.width*0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          spreadRadius: 1,
          offset: Offset(0,10),
        )]

      ),
      child: InkWell(
        onTap: (){openPage('$img', '$title');},
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/$img.png'),
                    fit: BoxFit.contain
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              child: Text('$title', style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,

              ),
              textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),

    );

  }

  void openPage(String img, String title)
  {
  Navigator.pushNamed(context, '/NewPage',arguments: {'image': '$img', 'title':'$title'});
  }

  }


class takvimpage extends StatefulWidget {
  @override
  _takvimpageState createState() => _takvimpageState();
}

class _takvimpageState extends State<takvimpage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takvim'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,

              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => ListTile(
              title: Text(event),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: _eventController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (_eventController.text.isEmpty) return;
                if (_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay]
                      .add(_eventController.text);
                } else {
                  _events[_controller.selectedDay] = [
                    _eventController.text
                  ];
                }
                prefs.setString("events", json.encode(encodeMap(_events)));
                _eventController.clear();
                Navigator.pop(context);
              },
            )
          ],
        ));
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
    
  }
  
}
class ayarlarpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey,

        title: Text('Ayarlar', style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

              child: ListTile(

                title: Text("Esra Durgun", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,)),
                leading: CircleAvatar(
                 backgroundColor: Colors.blueGrey,
                ),
                trailing: Icon(Icons.edit, color:Colors.black,),
              )
            ),
            const SizedBox(height: 10.0),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget> [
                  ListTile(
                    leading: Icon(Icons.lock_outline, color: Colors.purple,),
                    title: Text("Şifreni değiştir"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, ),
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey.shade300,

                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.language, color: Colors.purple,),
                    title: Text("Uygulama Dilini Değiştir"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )
                ]
              ),
            ),
            const SizedBox(height: 10.0,),
            Text("Diğer Ayarlar", style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),),
            SwitchListTile(
              activeColor: Colors.purple,
                value: true,
                title: Text("Bildirimler"),
                onChanged: (val){},
            ),
            SwitchListTile(
              activeColor: Colors.purple,
              value: false,
              title: Text("Gece Modu"),
              onChanged: (val){},
            ),
            SwitchListTile(
              activeColor: Colors.purple,
              value: true,
              title: Text("Uygulama Sesleri"),
              onChanged: (val){},
            )
          ],
        ),
      )
    );
  }
}


