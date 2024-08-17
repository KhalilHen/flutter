import 'package:dinnerapp/controllers/log_out_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddMealDialog extends StatefulWidget {
  const AddMealDialog({
    Key? key,
    required this.idMeal,
    required this.name,
  }) : super(key: key);

  final String idMeal;
  final String name;

  @override
  _AddMealDialogState createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final _listNameController = TextEditingController();
late  String mealName;
late String mealId;
String? selectedList;

//TODO Later turn this into a seperate file and call the method from that file
//TODO And other files where this is used
    final user = FirebaseAuth.instance.currentUser;
  List<DropdownMenuItem<String>> _dropdownItems = [];

  @override
void initState() {
  
  super.initState();
    mealName = widget.name;
    mealId = widget.idMeal;
        retrieveUsersList();

}


 Future<void> retrieveUsersList() async {

    var user = FirebaseAuth.instance.currentUser;
    var userLinkedList = FirebaseFirestore.instance.collection('list').where('userId', isEqualTo: user!.uid);

var querySnapshot = await userLinkedList.get();
List<DropdownMenuItem<String>> items = [];


for (var queryDocumentSnapshot in querySnapshot.docs) {

var data  = queryDocumentSnapshot.data();
var title = data   ['title'];
items.add(DropdownMenuItem(
  child: Text(title),
  value: title,
));


    setState(() {
      _dropdownItems = items;
    });
}

    // print('User List: $userLinkedList');


}
void retrievePickedMeal() {



print("mealId: ${widget.idMeal}");
print("MealName${widget.name}");

}

  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('To which list would you like to add this meal?'),

  
      
      content: Column(
        children: 
        
        
        
        [
    Text("Meal ID: $mealId"),
          Text("Meal Name: $mealName"),          
           Form(
        


          
          child: DropdownButtonFormField(
          
                        items: _dropdownItems,


          hint: Text('Select a list'),
          

    selectedItemBuilder: (BuildContext context) {
      return _dropdownItems.map<Widget>((item) {
        return Text(item.value!);
      }).toList();
    },
      onChanged: (String?  newValue) {
        setState(() { 
          selectedList = newValue; 

        });
      },

        
          ),

         
        ),
       
          
          
        
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (selectedList != null) {



                //TODO Later turn this into a fetch meal So it fetch every information based on the id of meal
                //TODO Or just sent the description and everything within this file
             

     FirebaseFirestore.instance.collection('lists').where(isEqualTo: selectedList.id)({
                'mealId': mealId,
                'mealName': mealName,
              });
              print('Selected List: $selectedList');
              print('Meal ID: $mealId');
              print('Meal Name: $mealName');
            }

            // Add logic to handle adding the meal to the list here
    
          },
          child: Text('Add'),
        ),
      ],
    );
  }

}