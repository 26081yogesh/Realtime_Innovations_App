import 'package:flutter/material.dart';
import 'package:realtime_innovations_assignment_app/add_employee.dart';
import 'package:realtime_innovations_assignment_app/database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Map<String, dynamic>>>? data;
  List<Map<String, dynamic>>? dataList = [];

  @override
  void initState() {
    super.initState();
    SQLHelper.db();
    getData();
  }

  void getData() async {
    data = SQLHelper.getItems();
    dataList = await data;
    setState(() {});
  }

  Future<void> deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    Fluttertoast.showToast(
      msg: "Employee data has been deleted",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff323238),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Employee List"),
        ),
        body: Center(
          child: dataList!.isEmpty
              ? Image.asset("assets/images/empty.png")
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Current Employees",
                        style: TextStyle(
                            color: Color(0xff1DA1F2),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dataList!.length,
                        itemBuilder: (context, position) {
                          final item = dataList![position];
                          if (item["endDate"].toString().compareTo("Present") ==
                              0) {
                            return Dismissible(
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              key: Key(item['id'].toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) async {
                                await deleteItem(item['id']);
                              },
                              child: Container(
                                width: double.infinity,
                                child: Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xff323238),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          item['role'],
                                          style: const TextStyle(
                                            color: Color(0xff949C9E),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          item['startDate'],
                                          style: const TextStyle(
                                            color: Color(0xff949C9E),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox
                                .shrink(); // Empty widget for non-current employees.
                          }
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Previous Employees",
                        style: TextStyle(
                            color: Color(0xff1DA1F2),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dataList!.length,
                        itemBuilder: (context, position) {
                          final item = dataList![position];
                          if (item["endDate"].toString().compareTo("Present") !=
                              0) {
                            return Dismissible(
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              key: Key(item['id'].toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) async {
                                await deleteItem(item['id']);
                              },
                              child: Container(
                                width: double.infinity,
                                child: Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xff323238),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          item['role'],
                                          style: const TextStyle(
                                            color: Color(0xff949C9E),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              item['startDate'],
                                              style: const TextStyle(
                                                color: Color(0xff949C9E),
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              item['endDate'],
                                              style: const TextStyle(
                                                color: Color(0xff949C9E),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox
                                .shrink(); // Empty widget for current employees.
                          }
                        },
                      ),
                    ),
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEmployee(
                  onDataAdded: getData,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
