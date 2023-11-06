import 'package:flutter/material.dart';
import 'package:phone_book_app/provider/contact_provider.dart';
import 'package:phone_book_app/utils/router.dart';
import 'package:phone_book_app/view/widgets/contacts_list_item.dart';
import 'package:provider/provider.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  ContactProvider? contactsProvider;

  @override
  void initState() {
    super.initState();
    initContacts();
  }

  Future<void> initContacts() async {
    contactsProvider = Provider.of<ContactProvider>(context, listen: false);
    await contactsProvider!.fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Contacts'),
      ),
      body: Consumer<ContactProvider>(builder: (context, provider, child) {
        if (provider.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: provider.contacts.length,
          itemBuilder: (context, i) {
            final contact = provider.contacts[i];
            return ContactsListItem(
              index:i,
              name: contact.displayName,
              phonenumber: contact.phones.first.number,
              photo: contact.photo,
            ) ;
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRouter.editContactRoute),
        tooltip: 'Add contacts',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
