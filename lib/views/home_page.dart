import 'package:api_test/models/users_model.dart';
import 'package:api_test/views/edit_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream _stream;
  List<DocumentSnapshot> _documentsUsers;

  @override
  void initState() {
    super.initState();
    setStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página Inicial"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
              icon: Icon(Icons.person_add, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddUser()));
              }),
        ],
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              _documentsUsers = snapshot.data.docs;
              if (_documentsUsers.isEmpty) {
                return Center(child: Text("Nenhum usuário cadastrado!"));
              } else {
                return ListView.builder(
                  itemCount: _documentsUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_documentsUsers[index].get("name")),
                      subtitle: Text(_documentsUsers[index].get("lastName")),
                      leading: CircleAvatar(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.deepPurpleAccent),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditUser(
                                          _documentsUsers[index].id,
                                          _documentsUsers[index].get("name"),
                                          _documentsUsers[index]
                                              .get("lastName"))));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {
                              UsersModel usersModel = UsersModel();
                              usersModel.deleteUser(_documentsUsers[index].id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Usuário removido com sucesso!",
                                          textAlign: TextAlign.center),
                                      backgroundColor:
                                          Colors.deepPurpleAccent));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }

  void setStream() {
    _stream = UsersModel().listUsers();
  }
}
