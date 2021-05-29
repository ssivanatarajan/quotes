import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class QuoteScreen extends StatefulWidget{
  final String text,url;
  @override
  QuoteScreenState createState()=> QuoteScreenState();
  QuoteScreen({Key key,@required this.text,@required this.url}):super(key:key);

}


class QuoteScreenState extends State<QuoteScreen>{
  ScreenshotController screenshotController = ScreenshotController();


final  MaterialColor myPrimaryColor = const MaterialColor(
    0xFF000000,
    const <int, Color>{
      50:Color.fromRGBO(0,0,0, .1),
      100:Color.fromRGBO(0,0,0, .2),
      200:Color.fromRGBO(0,0,0, .3),
      300:Color.fromRGBO(0,0,0, .4),
      400:Color.fromRGBO(0,0,0, .5),
      500:Color.fromRGBO(0,0,0, .6),
      600:Color.fromRGBO(0,0,0, .7),
      700:Color.fromRGBO(0,0,0, .8),
      800:Color.fromRGBO(0,0,0, .9),
      900:Color.fromRGBO(0,0,0, 1),
    }
);
@override
void initState() {

  super.initState();
}
Widget build(BuildContext routeContext){
return MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primarySwatch: myPrimaryColor,
            scaffoldBackgroundColor: myPrimaryColor.shade50,
        ),
        home: Scaffold(
            backgroundColor:myPrimaryColor.shade50,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child:Builder(builder:(BuildContext context){
                return AppBar(
                    backgroundColor:myPrimaryColor.shade500 ,
                    title: Text('RandomQuotes'),
                    leading: IconButton(icon:Icon(Icons.arrow_back),color: Colors.white,onPressed: (){
                      print('back pressed');
                    Navigator.pop(routeContext);
                }),
              actions: [
              PopupMenuButton(itemBuilder: (context)
          {
            var list= List<PopupMenuEntry>.generate(3,(index) {
              if(index == 0){
                return PopupMenuItem(child: Text('Set as Wallpaper'),value:1);
              }
              else if(index == 2){
                return PopupMenuItem(child: Text('Set as Lockscreen'),value:3);
              }
              else {
                return PopupMenuDivider(height: 3);
              }
              });
          return list;
          },
            elevation: 3,
            onSelected: (value){
            if(value==1){
              screenshotController.capture().then((image)  async{
              //  final result =await ImageGallerySaver.saveImage(image);
                final directory = (await getApplicationDocumentsDirectory()).path;
                var path='$directory/screenshot.png';
                print('path: $path');
                File imgFile = new File('$path');
                imgFile.writeAsBytes(image).then((value) async {
                  print('value: $value');

                    var result = await WallpaperManager.setWallpaperFromFile(
                    path, WallpaperManager.HOME_SCREEN);
                    print(result);
                });
                print(imgFile.path);
              });
            }
            else if(value==3){
              screenshotController.capture().then((image)  async{
                //  final result =await ImageGallerySaver.saveImage(image);
                final directory = (await getApplicationDocumentsDirectory()).path;
                var path='$directory/screenshot.png';
                print('path: $path');
                File imgFile = new File('$path');
                imgFile.writeAsBytes(image).then((value) async {
                  print('value: $value');

                  var result = await WallpaperManager.setWallpaperFromFile(
                      path, WallpaperManager.LOCK_SCREEN);
                  print(result);
                });
                print(imgFile.path);
              });
            }
            }
          )]
  );
  })),
            body: SafeArea(child: Center(
            child:
            Screenshot(
              controller: screenshotController,
              child:Padding(
                padding: EdgeInsets.all(50.0),
                child:
                MediaQuery.of(context).orientation == Orientation.portrait ?
                  getColumnLayout(widget.url,widget.text,context):getRowLayout(widget.url,widget.text,context)
              )
                  )
              )
            )
        )
    );
  }
}
Widget getColumnLayout(url,text,context){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children:<Widget> [
      Image.network(url,scale: 2.0,width: MediaQuery.of(context).size.width, fit: BoxFit.fill,),
      Padding(padding: EdgeInsets.only(top:25),
          child:Text(text,textAlign:TextAlign.center,style: TextStyle(color:Colors.white70,fontSize: 24.0)))
    ],
  );
}
Widget getRowLayout(url,text,context){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children:<Widget> [
      Image.network(url,width: MediaQuery.of(context).size.width/2),
      Expanded(
          child:
            Padding(padding: EdgeInsets.only(left:10),
              child:Text(text,textAlign:TextAlign.center,style: TextStyle(color:Colors.white70,fontSize: 24.0))
            )
      )
    ]
  );
}