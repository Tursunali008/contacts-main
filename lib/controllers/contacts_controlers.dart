import 'package:vazifa10/models/contact.dart';
import 'package:vazifa10/service/local_contact_service.dart';

class ContactsControlers {
  LocalContactService localContactService = LocalContactService();

  Future<List<Contact>> getContacts() async {
    List<Contact> newContacts = [];
    List<Map<String, dynamic>> datas = await localContactService.getContacts();
    for (Map<String, dynamic> data in datas) {
      newContacts.add(Contact(id: data['id'], name: data['name'], phone: data['phone']));
    }
    return newContacts;
  }

  Future<void> deleteContact(Contact contact) async {
    await localContactService.deleteContact(contact.id);
  }

  Future<void> editContact(Contact contact) async {
    await localContactService.editContact(contact);
  }

  Future<void> addContact(Contact contact) async {
    await localContactService.addContacts(contact);
  }
}
