import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './quotes.dart';
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
class SlideShow extends StatelessWidget{
  List<Quotes> quotesList = [];
  SlideShow({Key key,@required this.quotesList }):super(key:key);
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title:'Random Quotes',
     theme: ThemeData(
       primarySwatch:myPrimaryColor
     ),
     home: Scaffold(
     backgroundColor:myPrimaryColor.shade50,
       appBar: AppBar(
         backgroundColor:myPrimaryColor.shade500 ,
         title: Text('Random Quotes'),
         leading: IconButton(icon:Icon(Icons.arrow_back),color: Colors.white,onPressed: (){
           Navigator.pop(context);
         },)
       ),
       body:
           Center(

             child:
       CarouselSlider(
         options: CarouselOptions(
           height: MediaQuery.of(context).size.height,
           aspectRatio: 16/9,
           enlargeCenterPage: true,
           autoPlay: true,
           autoPlayInterval: Duration(seconds: 5),
           autoPlayAnimationDuration: Duration(milliseconds: 800),
           autoPlayCurve: Curves.fastOutSlowIn,
           pauseAutoPlayOnTouch: true,
         ),
         items: quotesList.map((quote){
           return Builder(
               builder:(BuildContext context){
                 return
                  Padding(
                 padding: EdgeInsets.all(20.0),
                  child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:CrossAxisAlignment.center,
                           children: <Widget>[

                             Image.network(quote.url,width: MediaQuery.of(context).size.width,fit: BoxFit.fitWidth),
                               Expanded(
                                   child:
                                   Padding(padding: EdgeInsets.only(top:30),
                                       child:Text(quote.text,textAlign:TextAlign.center,style: TextStyle(color:Colors.white70,fontSize: 24.0))
                                   )
                               )
                           ],
                 ));
               }
           );
         }).toList(),
       ))

     ),
   );
  }


}