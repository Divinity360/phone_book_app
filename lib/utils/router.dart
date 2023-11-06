import 'package:flutter/material.dart';
import 'package:phone_book_app/view/pages/contact_detail_page.dart';
import 'package:phone_book_app/view/pages/contacts_page.dart';
import 'package:phone_book_app/view/pages/edit_contact_page.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AppRouter {

  static const String homeRoute = '/';
  static const String editContactRoute = '/editContact';
  static const String contactDetailRoute = '/contactDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const ContactsPage());
      case editContactRoute:
        final contact = settings.arguments as Contact?;
        return MaterialPageRoute(builder: (_) => EditContactPage(contact: contact,));
      case contactDetailRoute:
        final contactIndex = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => ContactDetailPage(contactIndex: contactIndex,));
      default:
        return MaterialPageRoute(builder: (_) => const ContactsPage());
    }
  }
}