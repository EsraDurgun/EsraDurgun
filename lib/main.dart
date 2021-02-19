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
                          Icon(Icons.settings),
                          Text('Ayarlar')
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
  Map<DateTime,List<dynamic>> _events;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _events = {};

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
        backgroundColor: Color(0xffc7b8f5),

      ),
      body: SingleChildScrollView(

        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            TableCalendar(
              events: _events,
                calendarStyle: CalendarStyle(
                  todayColor: Color(0xffc7b8f5),
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color:Colors.orange,

                  )
                ),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Color(0xffc7b8f5),
                    borderRadius: BorderRadius.circular(20.0),

                  ),
                  formatButtonTextStyle: TextStyle(
                    color:Colors.white,

                  ),
                  formatButtonShowsNext: false,

                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date,events) =>
                      Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,

                        ),
                        child: Text(date.day.toString(), style: TextStyle(color:Colors.white),),
                      ),

                ),
                calendarController: _controller ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

        }
      )
    );
  }
  _showAddDialog(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Kaydet"),
            onPressed: () {

            },
          )
        ]
      ),

    );
  }

}

