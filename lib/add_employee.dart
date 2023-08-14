import 'package:flutter/material.dart';
import 'package:realtime_innovations_assignment_app/database_helper.dart';

class AddEmployee extends StatefulWidget {
  final VoidCallback onDataAdded;
  const AddEmployee({super.key, required this.onDataAdded});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  String selectedRole = "Flutter Developer";

  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
      });
    }
  }

  TextEditingController roleController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();

  List<String> role = [
    "Flutter Developer",
    "Full Stack Developer",
    "Senior Software Developer",
  ];

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate2,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != selectedDate2) {
      setState(() {
        selectedDate2 = picked;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    employeeNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Employee Details")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: employeeNameController,
              decoration: const InputDecoration(
                hintText: "Employee Name",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xffE5E5E5),
                  ),
                ),
                prefixIcon: Icon(Icons.people),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              value: selectedRole,
              focusColor: Colors.white,
              items: role
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (e) {
                setState(() {
                  selectedRole = e.toString();
                });
              },
              onSaved: (e) {},
              decoration: const InputDecoration(
                hintText: "Select Role",
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xffE5E5E5),
                  ),
                ),
                prefixIcon: Icon(Icons.people),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onTap: () => _selectDate1(context),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xffE5E5E5),
                        ),
                      ),
                    ),
                    controller: TextEditingController(
                      text: selectedDate1.toLocal().toString().split(' ')[0],
                    ),
                  ),
                ),
              ),
              const Icon(Icons.arrow_right_alt),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onTap: () => _selectDate2(context),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xffE5E5E5),
                        ),
                      ),
                    ),
                    controller: TextEditingController(
                      text: selectedDate1.day.toString().compareTo(
                                      selectedDate2.day.toString()) ==
                                  0 &&
                              selectedDate1.month.toString().compareTo(
                                      selectedDate2.month.toString()) ==
                                  0 &&
                              selectedDate1.year.toString().compareTo(
                                      selectedDate2.year.toString()) ==
                                  0
                          ? "Present"
                          : selectedDate1.toLocal().toString().split(' ')[0],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          SQLHelper.createItem(
                              employeeNameController.text,
                              selectedRole,
                              "From: ${selectedDate1.day}-${selectedDate1.month}-${selectedDate1.year}",
                              selectedDate1.day.toString().compareTo(
                                              selectedDate2.day.toString()) ==
                                          0 &&
                                      selectedDate1.month.toString().compareTo(
                                              selectedDate2.month.toString()) ==
                                          0 &&
                                      selectedDate1.year.toString().compareTo(
                                              selectedDate2.year.toString()) ==
                                          0
                                  ? "Present"
                                  : "     To: ${selectedDate2.day}-${selectedDate2.month}-${selectedDate2.year}");
                          widget.onDataAdded();
                          Navigator.pop(context);
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
