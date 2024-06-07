import 'package:vazifa10/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class LocalContactService {
  LocalContactService._singleten();
  static final LocalContactService _instance = LocalContactService._singleten();
  factory LocalContactService() {
    return _instance;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/contacts.db';
    return await openDatabase(
      path,
      onCreate: _createDatabases,
      version: 1,
    );
  }

  Future<void> _createDatabases(Database db, int version) async {
    await db.execute('''
    CREATE TABLE contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    phone TEXT NOT NULL
    )
''');
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    await database;
    final contacts = await _database!.query('contacts');
    return contacts;
  }

  Future<void> addContacts(Contact contact) async {
    _database!.insert("contacts", {
      'name': contact.name,
      'phone': contact.phone,
    });
  }

  Future<void> deleteContact(int id) async {
    await _database!.delete("contacts", where: 'id = $id', whereArgs: []);
  }

  Future<void> editContact(Contact contact) async {
    await _database!.update(
      "contacts",
      where: 'id = ?',
      whereArgs: [contact.id],
      {
        'name': contact.name,
        'phone': contact.phone,
      },
    );
  }
}
