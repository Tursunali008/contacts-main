import 'package:vazifa10/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditContact extends StatefulWidget {
  final Contact? contact;
  // ignore: use_key_in_widget_constructors
  EditContact([this.contact]);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.contact?.name ?? '');
    phoneController = TextEditingController(text: widget.contact?.phone ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const Gap(10),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Phone',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final updatedContact = widget.contact ??
                          Contact(
                            id: 0,
                            name: nameController.text,
                            phone: phoneController.text,
                          );
                      updatedContact.name = nameController.text;
                      updatedContact.phone = phoneController.text;
                      Navigator.pop(context, updatedContact);
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
