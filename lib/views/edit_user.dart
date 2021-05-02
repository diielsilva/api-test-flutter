import 'package:api_test/models/users_model.dart';
import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {

  @override
  EditUser(String id, String name, String lastName) {
    _idUser = id;
    _name = name;
    _lastName = lastName;
  }

  String _idUser;
  String _name;
  String _lastName;

  @override
  _EditUserState createState() => _EditUserState(_idUser, _name, _lastName);
}

class _EditUserState extends State<EditUser> {
  _EditUserState(String idUser, String nameUser, String lastNameUser) {
    _idDocUser = idUser;
    _defaultName = nameUser;
    _defaultLastName = lastNameUser;
  }

  String _idDocUser;
  String _defaultName;
  String _defaultLastName;
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _nameController.text = _defaultName;
    _lastNameController.text = _defaultLastName;
  }

  void refreshFields() {
    setState(() {
      _nameController.text = "";
      _lastNameController.text = "";
      _keyForm = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Usuário"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: refreshFields)
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.edit, color: Colors.deepPurpleAccent, size: 100),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Nome"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencha o campo Nome corretamente!";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child: TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Sobrenome",
                  ),
                  validator: (value) {
                    if(value.isEmpty) {
                      return "Preencha o campo Sobrenome corretamente!";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child: ElevatedButton(
                  child: Text("Editar", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent)),
                  onPressed: () async {
                    if (_keyForm.currentState.validate()) {
                      UsersModel usersModel = UsersModel();
                      await usersModel.updateUser(_idDocUser,
                          _nameController.text, _lastNameController.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Usuário editado com sucesso!",
                            textAlign: TextAlign.center),
                        backgroundColor: Colors.deepPurpleAccent,
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
