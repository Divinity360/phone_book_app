import 'dart:typed_data';
import 'package:phone_book_app/provider/contact_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:phone_book_app/view/widgets/contact_avatar.dart';

class EditContactPage extends StatefulWidget {
  final Contact? contact;

  const EditContactPage({super.key, this.contact});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  bool inEditMode = false;
  final ImagePicker picker = ImagePicker();
  Contact contactInfo = Contact();
  Uint8List? photo;
  String? contactId;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      initContactData();
    }
  }

  void initContactData() {
    setState(() {
      contactId = widget.contact!.id;
      photo = widget.contact!.photo;
      nameController.text = widget.contact!.displayName;
      phoneNumController.text = widget.contact!.phones.first.number;
      inEditMode = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(inEditMode ? 'Edit' : 'New contact'),
        actions: <Widget>[
          Consumer<ContactProvider>(builder: (context, provider, child) {
            if (provider.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return IconButton(
              icon: const Icon(Icons.save),
              onPressed: () => onContactSave(provider),
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Form(
            child: Column(
              children: [
                Center(
                    child: InkWell(
                  onTap: _pickPhoto,
                  child: ContactAvatar(
                    photo: contactInfo?.photo,
                    radius: 45,
                  ),
                )),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Contact name',
                  ),
                ),
                TextFormField(
                  controller: phoneNumController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onContactSave(ContactProvider provider) {
    if (nameController.text.isNotEmpty && phoneNumController.text.isNotEmpty) {
      provider.insertOrUpdateContact(contactId,
          name: nameController.text,
          phone: phoneNumController.text,
          photo: photo,
          shouldUpdate: inEditMode);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Fill in your name and phone number");
    }
  }

  Future _pickPhoto() async {
    final photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      final bytes = await photo.readAsBytes();
      setState(() => contactInfo?.photo = bytes);
    }
  }
}
