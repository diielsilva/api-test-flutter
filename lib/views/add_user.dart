import 'package:api_test/models/users_model.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

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
        title: Text("Adicionar Usuário"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: refreshFields)
        ],
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_add, size: 100, color: Colors.deepPurpleAccent),
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
                  decoration: InputDecoration(labelText: "Sobrenome"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencha o campo Sobrenome corretamente!";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                child: ElevatedButton(
                  child: Text("Cadastrar"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent)),
                  onPressed: () async {
                    if (_keyForm.currentState.validate()) {
                      UsersModel usersModel = UsersModel();
                      String result = await usersModel.storeUser(
                          _nameController.text, _lastNameController.text);
                      if (result != "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Usuário cadastrado com sucesso!",
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.deepPurpleAccent));
                      }
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
