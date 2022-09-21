import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StudData {
  int id;
  String name;
  int fees;
  Database database;

  StudData({this.id, this.name, this.fees});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'fees': fees,
    };
  }

  @override
  String toString() {
    return 'Stud{id: $id, name: $name, fees: $fees}';
  }

  Future<void> createDatabase() async {
    print('creation started');
    database = await openDatabase(
      join(await getDatabasesPath(), 'student_database'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          'CREATE TABLE IF NOT EXISTS stud(ID INTEGER PRIMARY KEY, Name TEXT, Fees INTEGER)',
        );
      },
      version: 1,
    );
    print('creation completed');
  }

  void insertData(List data) async {
    print('insertion started');

    final db =
        await openDatabase(join(await getDatabasesPath(), 'student_database'));
    print(db.isOpen);

    await db.transaction((txn) async {
      int id2 = await txn.rawInsert(
          'INSERT INTO stud(ID, Name, Fees) VALUES(?, ?, ?)', data);
      print('inserted2: $id2');
    });
    print('insertion completed');
    db.close();
  }

  Future<List<StudData>> getData() async {
    // Get a reference to the database.
    final db =
        await openDatabase(join(await getDatabasesPath(), 'student_database'));
    print(db.isOpen);
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('stud');
    print(maps.length);
    print(maps);
    db.close();
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return StudData(
        id: maps[i]['ID'], //Here the key name must be equal to Column Name
        name: maps[i]['Name'],
        fees: maps[i]['Fees'],
      );
    });
  }

  void update(List data) async {
    print('updation started');
    final db =
        await openDatabase(join(await getDatabasesPath(), 'student_database'));
    print(db.isOpen);

    //Update
    int count =
        await db.rawUpdate('UPDATE stud SET Name = ? WHERE ID = ?', data);
    print('updated: $count');
    print('updated');
    db.close();
  }

  void delete(List data) async {
    print('deletion std');
    final db =
        await openDatabase(join(await getDatabasesPath(), 'student_database'));
    print(db.isOpen);

    //delete
    int count = await db.rawDelete('DELETE FROM stud WHERE id = ?', data);

    print(count);
    print('deletion completed');
    db.close();
  }
}
