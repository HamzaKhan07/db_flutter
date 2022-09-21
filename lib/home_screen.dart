import 'package:flutter/material.dart';
import 'stud_data.dart';
import 'records_brain.dart';
import 'package:provider/provider.dart';
import 'records_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    createDb();
    super.initState();
  }

  void createDb() async {
    //show progress
    await StudData().createDatabase();
    //hide progress
  }

  @override
  Widget build(BuildContext context) {
    var insertId = TextEditingController();
    var insertName = TextEditingController();
    var insertFees = TextEditingController();
    var updateId = TextEditingController();
    var updateName = TextEditingController();
    var deleteId = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.table_view),
        onPressed: () async {
          var data = await StudData().getData();
          print(data);
          Provider.of<RecordsBrain>(context, listen: false).setData(data);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecordsScreen()));
        },
      ),
      appBar: AppBar(
        title: Text('Database'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Insert
                Text(
                  'Insert',
                  style: TextStyle(fontSize: 25.0),
                ),
                TextField(
                  controller: insertId,
                  decoration: InputDecoration(
                    labelText: 'ID',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: insertName,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: insertFees,
                  decoration: InputDecoration(
                    labelText: 'Fees',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: Text('Insert'),
                  onPressed: () {
                    List data = [
                      int.parse(insertId.text),
                      insertName.text,
                      int.parse(insertFees.text)
                    ];
                    StudData().insertData(data);
                    print(int.parse(insertId.text));
                    insertId.text = '';
                    insertName.text = '';
                    insertFees.text = '';
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),

                //Update
                Text(
                  'Update',
                  style: TextStyle(fontSize: 25.0),
                ),
                TextField(
                  controller: updateId,
                  decoration: InputDecoration(
                    labelText: 'ID',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: updateName,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: Text('Update'),
                  onPressed: () {
                    List data = [updateName.text, int.parse(updateId.text)];
                    StudData().update(data);
                    updateId.text = '';
                    updateName.text = '';
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),

                //Delete
                Text(
                  'Delete',
                  style: TextStyle(fontSize: 25.0),
                ),
                TextField(
                  controller: deleteId,
                  decoration: InputDecoration(
                    labelText: 'ID',
                  ),
                ),
                ElevatedButton(
                  child: Text('Delete'),
                  onPressed: () {
                    List data = [int.parse(deleteId.text)];
                    StudData().delete(data);
                    deleteId.text = '';
                  },
                ),
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
