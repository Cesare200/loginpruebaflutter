import 'package:flutter/material.dart';
import 'dao/user_dao.dart';
import 'models/user.dart';
import 'userlistscreen.dart'; // Importar la nueva pantalla

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InsertUserScreen(),
    );
  }
}

class InsertUserScreen extends StatefulWidget {
  @override
  _InsertUserScreenState createState() => _InsertUserScreenState();
}

class _InsertUserScreenState extends State<InsertUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertar User'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserListScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      User newUser = User(
                          id: DateTime.now().millisecondsSinceEpoch,
                          name: _nameController.text);
                      UserDao().insert(newUser);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('User inserted successfully')));
                      _nameController.clear();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
