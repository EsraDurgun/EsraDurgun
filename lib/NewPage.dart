import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';




class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    String selectimg;
    String selecttit;
    final Map arguments= ModalRoute.of(context).settings.arguments as Map;
    selectimg= arguments['img'];
    selecttit= arguments['title'];
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
          color: Colors.black,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget> [
          Container(
            height: MediaQuery.of(context).size.height*0.43,
            width: MediaQuery.of(context).size.width,
            color: Color(0xffc7b8f5),
            child: Container(
              margin: EdgeInsets.only(right: 40, top:20, bottom:20),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/path.png'),
                  fit: BoxFit.contain,
                )
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 90,),
              Expanded(child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text('$selecttit', style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget> [
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('5-10 Dakikalık Videolar', style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),),
                              SizedBox(height: 10,),
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width*0.9,
                                margin: EdgeInsets.only(right: 20),
                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                ),
                                child: Row(
                                  children: <Widget> [
                                    Icon(Icons.search, size: 30,),
                                    SizedBox(width: 20,),
                                    Expanded(
                                        child:TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Ara',
                                            hintStyle: TextStyle(
                                              fontSize: 20,

                                            ),
                                          ),
                                        ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ),
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.all(70),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('asset/$selectimg.png'),
                                  fit: BoxFit.contain
                                )
                              ),
                            ), ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget> [
                              derswidget('Ders 1', true),
                              derswidget('Ders 2', false),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget> [
                              derswidget('Ders 3', false),
                              derswidget('Ders 4', false),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget> [
                              derswidget('Ders 5', false),
                              derswidget('Ders 6', false),

                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('$selecttit', style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),]
                      ),
                      child: Row(
                        children: <Widget> [
                          Container(
                            padding: EdgeInsets.all(50),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('asset/$selectimg.png')
                              )
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Text('Kurs 2', style:TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,

                                ),),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(
                              Icons.lock_outline,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,)
                  ],
                ),
              ),
              ),
              ),
            ],
          )
        ],
      )
    );
  }
  Container derswidget(String title, bool activeornot)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.only(bottom:10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 15,
          spreadRadius: 1,
        )]
      ),
      child: Row(
        children: <Widget> [
          IconButton(
            onPressed: (){
              Navigator
                  .push(context, MaterialPageRoute(
                  builder: (context) => videopage()
              )
              );
            },
          icon:Icon(
              (activeornot == true) ? Icons.play_circle_filled : Icons.play_circle_outline,
            color: Color(0xff817dc0),
            size: 50,
          ),
          ),
          SizedBox(width: 10,),
          Text('$title', style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),)
        ],
      )
    );
  }
}
class videopage extends StatelessWidget {
YoutubePlayerController _controller=YoutubePlayerController(
  initialVideoId: 'U9YKY7fdwyg&ab_channel=Goodful',
  flags: YoutubePlayerFlags(
    autoPlay: true,
    mute: false,

  )
);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xfff5ceb8),
      appBar: AppBar(
      backgroundColor: Color(0xffc7b8f5),

      ),
      body: Center(
        child: Column(
          children: <Widget>[
            YoutubePlayer(controller: _controller,
            showVideoProgressIndicator: true,
            )
          ],
        ),
      ),

      );


  }
}

