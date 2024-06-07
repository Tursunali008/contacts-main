import 'package:vazifa10/controllers/contacts_controlers.dart';
import 'package:vazifa10/models/contact.dart';
import 'package:vazifa10/views/widgets/edit_contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactsControlers contactsControlers = ContactsControlers();

  deleteContact(Contact contact) async {
    await contactsControlers.deleteContact(contact);

    setState(() {});
  }

  editContact(Contact contact) async {
    await showDialog(
      context: context,
      builder: (context) => EditContact(contact),
    );
    await contactsControlers.editContact(contact);
    setState(() {});
  }

  addContact() async {
    Contact? contact = await showDialog<Contact>(
      context: context,
      builder: (context) => EditContact(),
    );
    if (contact != null) {
      await contactsControlers.addContact(contact);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Contacts"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addContact,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: contactsControlers.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Malumot olishda hato bor"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Malumot yo'q"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Contact contact = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => editContact(contact),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blueAccent,
                        ),
                      ),
                      IconButton(
                        onPressed: () => deleteContact(contact),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
