import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import './myCustomRoute.dart';
import './quotes.dart';
import './quoteScreen.dart';
import './slideShow.dart';


void main() {
  runApp(MyApp());
}
const MaterialColor myPrimaryColor = const MaterialColor(
    0xFF000000,
  const <int, Color>{
    50:Color.fromRGBO(25,27,33,.1),
    100:Color.fromRGBO(25,27,33,.2),
    200:Color.fromRGBO(25,27,33,.3),
    300:Color.fromRGBO(25,27,33,.4),
    400:Color.fromRGBO(25,27,33,.5),
    500:Color.fromRGBO(25,27,33,.6),
    600:Color.fromRGBO(25,27,33,.7),
    700:Color.fromRGBO(25,27,33,.8),
    800:Color.fromRGBO(25,27,33,.9),
    900:Color.fromRGBO(25,27,33,1),
  }
);
Future<List<Quotes>> getData() async {
  String jsonString = await rootBundle.loadString("assets/data/quotes.json");
  var quotesMap = jsonDecode(jsonString);
  List<Quotes> quotesList = [];
  for (var quote in quotesMap) {
    var quoteObj = Quotes.fromJson(quote);
    quotesList.add(quoteObj);
  }
  return quotesList;
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application

  @override
  QuotesState createState() => QuotesState();
}
class QuotesState extends State<MyApp>{

  List<Quotes> _quotesList = [];
  @override
  void initState() {
    getData().then((value){
      setState((){
        _quotesList = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Random Quotes',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: myPrimaryColor,
        scaffoldBackgroundColor: myPrimaryColor.shade50
      ),
      home:Scaffold(
      backgroundColor:myPrimaryColor.shade50,
      appBar:PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child:Builder(builder:(BuildContext context){
      return AppBar(
        backgroundColor:myPrimaryColor.shade500 ,
      title: Text('RandomQuotes'),
        actions: [
          PopupMenuButton(itemBuilder: (context){

            var list= List<PopupMenuEntry>.generate(3,(index) {
              if(index == 0){
             return PopupMenuItem(child: Text('SlideShow'),value:1);
            } else if(index == 2){
             return PopupMenuItem(child: Text('Add Quote'),value:2);
              }
              else {
                return PopupMenuDivider(height: 3);
              }
            });
            return list;
      },
            elevation: 4,
          onSelected:(value){
            if(value==1){
              Navigator.push(context,new MyCustomRoute(builder: (context)=>SlideShow(quotesList:_quotesList)));
            }
            print('selected:$value');
            },)
        ],
    );}
    )),body:ListView.builder(
          itemCount: _quotesList.length,
          itemBuilder: (context,index){
          return new InkWell(
              child:Card(
                color: myPrimaryColor.shade800,
              elevation:3,
              child:Padding(
                padding: EdgeInsets.only(left:25.0,right:25.0,top:20.0,bottom:20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(_quotesList[index].text,
                      style:TextStyle(color:Colors.white70,fontSize: 20.0,fontStyle:FontStyle.italic),

                    ),
                    // Text(_quotesList[index].author,
                    //     style:TextStyle(color:Colors.lightBlue[300],fontSize: 12.0)
                    // )
                  ],
                ),
              ),
            ),
            onTap:(){
              Navigator.push(context,new MyCustomRoute(builder: (context)=>QuoteScreen(text: _quotesList[index].text,url:_quotesList[index].url)));
            }
          );

    })
    )
    );
  }
}


