import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'records_brain.dart';

class RecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              (Provider.of<RecordsBrain>(context).data[index].id).toString(),
              style: TextStyle(fontSize: 20.0),
            ),
            title: Text(Provider.of<RecordsBrain>(context).data[index].name),
            trailing: Text(
              (Provider.of<RecordsBrain>(context).data[index].fees).toString(),
              style: TextStyle(fontSize: 20.0),
            ),
          );
        },
        itemCount: Provider.of<RecordsBrain>(context).data.length,
      ),
    );
  }
}
