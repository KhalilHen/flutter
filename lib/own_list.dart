import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 
import 'homepage.dart';
import 'choose_meal.dart';
import 'firebase_options.dart';
import './dialogs/create_list_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OwnListPage extends StatefulWidget {
  const OwnListPage({Key? key}) : super(key: key);

  @override
  _OwnListPageState createState() => _OwnListPageState();
}

class _OwnListPageState extends State<OwnListPage> {
  int _currentIndex = 2;
final db = FirebaseFirestore.instance;


// TODO Fix this later
    // final screenWidth = mediaQuery.size.width;



void retrieveList() async {

var collection = FirebaseFirestore.instance.collectionGroup('list');


var querySnapshot = await collection.get();
for (var queryDocumentSnapshot in querySnapshot.docs) {
  print(queryDocumentSnapshot.data());
}
try {


}
catch (e) {
  print('Failed to retrieve list: $e');
}

}


  @override
  Widget build(BuildContext context) {
    final primaryBackgroundColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          // '{$list.title}',
          'test',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle notification button press
            },
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              // Handle help button press
            },
            icon: Icon(Icons.help),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('list').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return GridView.builder(
              itemCount: docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                                final data = docs[index].data();

                                
    return Card( 

        margin: EdgeInsets.all(15.0), //I am considering using it 


  color: Colors.white,

elevation: 10.0,

  shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),

child: GestureDetector(
  onTap: () {

 
  },

child: Column(
mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
  children: [

 Text(data['title'] ?? 'No title',
  
  
  style:  TextStyle(
    decoration: TextDecoration.underline, 
  )
  
  
  ),

  // if (screenWidth > 614 )
  // Text(data['description'] ?? 'No description'), //Think not gonna use it for phones as there for too less space 

  


    ],
),

),


  
        

        

 
    );
              },
            );
          }
          return Center(child: Text('No data found'));
        },
      ),


    );
  }
}