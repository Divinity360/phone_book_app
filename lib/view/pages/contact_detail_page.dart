import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:phone_book_app/provider/contact_provider.dart';
import 'package:phone_book_app/utils/router.dart';
import 'package:phone_book_app/utils/text_style.dart';
import 'package:phone_book_app/view/widgets/app_button.dart';
import 'package:phone_book_app/view/widgets/contact_avatar.dart';
import 'package:provider/provider.dart';

class ContactDetailPage extends StatefulWidget {
  final int contactIndex;

  const ContactDetailPage({super.key, required this.contactIndex});

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Form(
              child: Consumer<ContactProvider>(
                  builder: (context, provider, child) {
                final Contact contact =
                    provider.contacts.elementAt(widget.contactIndex);
                return Center(
                  child: Column(
                    children: [
                      ContactAvatar(
                        photo: contact.photo,
                        radius: 45,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        contact.displayName,
                        style: AppTextStyle.h2,
                      ),
                      Text(
                        contact.phones.first.number,
                        style: AppTextStyle.desc,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton(
                              text: 'Edit',
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRouter.editContactRoute,
                                    arguments: contact);
                              }),
                          const SizedBox(width: 30,),
                          AppButton(
                              text: 'Delete',
                              onTap: () async {
                                await provider.deleteContact(contact);
                                Navigator.pop(context);
                              }),
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ));
  }
}
