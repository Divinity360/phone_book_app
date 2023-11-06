import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> _contacts = [];
  bool _loading = false;

  List<Contact> get contacts => _contacts;

  bool get loading => _loading;


  /// Fetches device's contact list
  Future<void> fetchContacts() async {
    bool hasRequestPermission = await FlutterContacts.requestPermission();
    if (hasRequestPermission) {
      setLoading(true);
      _contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      setLoading(false);
    }
  }


  /// Handle contact list delete logic
  Future<void> deleteContact(Contact contact) async {
    await FlutterContacts.deleteContact(contact);
    await fetchContacts();
  }

  /// Handle contact list insert and update logic
  Future<void> insertOrUpdateContact(String? contactId,
      {required String name,
      required String phone,
      Uint8List? photo,
      bool shouldUpdate = false}) async {
    setLoading(true);
    final newContactModel = Contact()
      ..name.first = name
      ..phones = [Phone(phone)]
      ..photo = photo;
    if (shouldUpdate) {
      await FlutterContacts.updateContact(newContactModel..id = contactId!);
    } else {
      await FlutterContacts.insertContact(newContactModel);
    }
    await fetchContacts();
  }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}
