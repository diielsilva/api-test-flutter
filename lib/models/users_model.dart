import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String _name;
  String _lastName;
  CollectionReference _collectionUsers;
  DocumentReference _result;

  void setName(String name) {
    _name = name;
  }

  String getName() {
    return _name;
  }

  void setLastName(String lastName) {
    _lastName = lastName;
  }

  String getLastName() {
    return _lastName;
  }

  CollectionReference getConnectionUsers() {
    _collectionUsers = FirebaseFirestore.instance.collection("users");
    return _collectionUsers;
  }

  Future<String> storeUser(String name, String lastName) async {
    UsersModel usersModel = UsersModel();
    CollectionReference database = usersModel.getConnectionUsers();
    _result = await database.add({
      "name": name,
      "lastName": lastName,
    });
    return _result.id;
  }

  Stream<QuerySnapshot> listUsers() {
    UsersModel usersModel = UsersModel();
    CollectionReference database = usersModel.getConnectionUsers();
    return database.orderBy("name").snapshots();
  }

  Future<void> deleteUser(String idUser) async {
    UsersModel usersModel = UsersModel();
    CollectionReference database = usersModel.getConnectionUsers();
    await database.doc(idUser).delete();
  }

  Future<void> updateUser(String idUser, String name, String lastName) async {
    UsersModel usersModel = UsersModel();
    CollectionReference database = usersModel.getConnectionUsers();
    await database.doc(idUser).update({
      "name": name,
      "lastName": lastName,
    });
  }
}
