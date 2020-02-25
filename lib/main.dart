import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() =>  runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          body: new Center(child: new MyApp(),
          )
        )
    )
);


class MyApp extends StatefulWidget {
  @override 
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new VeryLargeListHolder(items: List<String>.generate(1000000, (i) => "$i")),
      image: new Image.network('https://discordemoji.com/assets/emoji/2010_kukuha.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.black
    );
  }

}

class VeryLargeListHolder extends StatelessWidget {
  final List<String> items;

  final List<List<String>> toHundred = [ 
  ["","од","дв","три","четыре","пять","шесть","семь","восемь","девять"],
  ["", "десять " ,"двадцать ","тридцать ","сорок ","пятьдесят ","шестьдесят ","семьдесят ","восемьдесят ","девяносто "],
  ["","сто ","двести ","триста ","четыреста ","пятьсот ","шестьсот ","семьсот ","восемьсот ","девятьсот "]];
  final List<String> elevenToNineteen = ["десять ","одиннадцать ","двенадцать ","тринадцать ","четырнадцать ","пятнадцать ","шестнадцать ", "семнадцать ","восемнадцать ","девятнадцать "];
  final List<List<String>> thousandsAndMillions = [
  ["", "", "", ""],
  ["миллиардов ", "миллионов ", "тысяч ", ""],
  ["миллиард ", "миллион ", "тысяча ", ""],
  ["миллиарда ", "миллиона ", "тысячи ", ""],
  ["миллиардов ", "миллионов ", "тысяч ", ""]];

  VeryLargeListHolder({Key key, @required this.items }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = "Long List";
    return MaterialApp(
      color: Colors.black,
      title: title,
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {

            String indexx = '${items[index]}';
            int intIndex = int.parse(indexx);

            Color color;
            if(intIndex % 2 == 0){
              color = Colors.grey[200];
            } else {
              color = Colors.white;
            }

            return Container(
              height: 50,
              color: color,
              child: Center(child: Text('${retranslate(int.parse(items[index]))}')),
            );
          },
          ),
        ),
      );
  }

  String retranslate(int num) {
    String text = "";

    if(num == 0) return "ноль";

    int million = num ~/ 1000000 ;
    int thousand = (num - (million * 1000000)) ~/ 1000;
    int lasts = num % 1000;

    return text + toThousands(million, 1) + toThousands(thousand, 2) + toThousands(lasts, 3);
  }

  String toThousands(int value, int index) {
    int hundreds = value ~/ 100;
    int decimal = (value - (hundreds * 100)) ~/ 10;
    int units = value % 10;
    String text = "";
  
    if(decimal == 1) text = toHundred[2][hundreds] + elevenToNineteen[units];
    else text = toHundred[2][hundreds] + toHundred[1][decimal] + toHundred[0][units];

    if (index == 2) {
      if (units == 1 && decimal != 1) text = text + "на ";
      else if (units == 2 && decimal != 1) text = text + "е ";

      if (units > 1 && decimal != 1) text = text + " ";
    } else {
      if (units == 1 && decimal != 1) text = text + "ин ";
      if (units == 2 && decimal != 1) text = text + "а ";
      else if (units != 0 && decimal != 1) text = text + " ";
    }

    int indexA = 0;
    if (value != 0 ) {
      if (units == 0 || decimal == 1 ) indexA = 1;
      else if (units == 1) indexA = 2;
      else if (units > 1 && units < 5) indexA = 3;
      else indexA = 4;
    }

    text = text + thousandsAndMillions[indexA][index];
    return text;
  }
}