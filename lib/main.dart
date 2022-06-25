import 'dart:developer';

import 'package:flutter/material.dart';

import 'api_services.dart';
import 'data_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Services serviceAPI = Services();
  late Future<List<cData>> listData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listData = serviceAPI.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Latihan get data from API'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<cData>>(
                  future: listData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<cData> data = snapshot.data!;

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(data[index].cName),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(data[index].cAvatar),
                              ),
                              subtitle: Text(data[index].cJob),
                              onTap: () {
                                showData(data[index].cId);
                              },
                              onLongPress: () {
                                deleteData(data[index].cId);
                              },
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addData();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
              ),
              child: const Text('Tambah Data'),
            ),
          ],
        ),
      ),
    );
  }

  void addData() async {
    bool response = await serviceAPI.postData(
      'cek123',
      'https://i.pravatar.cc/300',
      'indian',
      'rd@gmail.com',
      'Dev',
      'Quote 1',
    );

    if (response) {
      setState(() {
        listData = serviceAPI.getAllData();
      });
    }
  }

  void showData(String id) async {
    cData response = await serviceAPI.getSingleData(id);
    log("data = ${response.cName} - ${response.cAddress} - ${response.cEmail} - ${response.cJob}  - ${response.cQuote}");
  }

  void deleteData(String id) async {
    bool response = await serviceAPI.deleteData(id);

    if (response) {
      setState(() {
        listData = serviceAPI.getAllData();
      });
    } else {
      log('Gagal menghapus data');
    }
  }
}
