import 'package:flutter/material.dart';
class Products extends StatelessWidget {
const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color.fromARGB(255, 20, 38, 48),
        title: Text(style: TextStyle(
              color:Colors.white ,
              fontFamily: 'DancingScript',
              fontSize:20,
            ),'My All Products'),) ,
            body: Column(
  mainAxisAlignment: MainAxisAlignment.center, // center the ListView
  children: [
    Flexible( // required for ListView in Column
      child: ListView(
        children: [
        Card( 
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child:
             Center(child: Text('باكلوتين 10 أقراص')
             ))),
             Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text('انجيو- سارت 4 أقراص')),
             ))),
             Card( 
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text('آلانتوئين كريم')),
             ))),
             Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
               child: Center(child: Text('أريبزولمين 10 أقراص')),
             ))),
             Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(20.0),    
              child: Center(child: Text('أسبرين دومِنا 75 أقراص ملبسة معوياً')),
             ))),
             Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(20.0), 
                 child: Center(child: Text('أوفيكسول 0,25 أقراص')),
             ))),
             Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(20.0), 
                 child: Center(child: Text('أوفيللين أقراص')),
             ))),
             Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text('	بيزوفين 200مل شراب')),
             ))),
             Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
                 child: Center(child: Text('إيميتيك-ستوب محلول معد للحقن الوريدي والعضلي')),
             ))),
             Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.white70,
          child: SizedBox(
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text('امبروكسو دومِنا شراب')),
             )))
        ],
      ),
    ),
  ],
)
            
            
            );
  }
}