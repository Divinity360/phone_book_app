import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:phone_book_app/utils/router.dart';
import 'package:phone_book_app/view/widgets/contact_avatar.dart';

class ContactsListItem extends StatelessWidget {
  final int index;
  final String name;
  final String? phonenumber;
  final Uint8List? photo;

  const ContactsListItem({
    super.key,
    required this.name,
    required this.phonenumber,
    this.photo,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ContactAvatar(photo: photo),
      title: Text(name),
      subtitle: Text(phonenumber ?? 'Invalid phone number'),
      onTap: () => Navigator.of(context)
          .pushNamed(AppRouter.contactDetailRoute, arguments: index),
    );
  }
}
