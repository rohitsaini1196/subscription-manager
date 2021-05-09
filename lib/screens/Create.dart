import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_manager/classes/Subscription.dart';
import 'package:subscription_manager/screens/Home.dart';
import 'package:subscription_manager/services/DataRepo.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final DataRepository repository = DataRepository();

  DateTime pickedDate;
  TimeOfDay pickedTime;
  DateTime pickedDateEnd;
  int subsDays = 28;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _finishDateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _subsDaysController = TextEditingController();

  bool _validateDays = false;

  @override
  void initState() {
    super.initState();

    //Date wala stuff
    pickedDate = DateTime.now();

    _startDateController.text =
        "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
    var dateRandom = DateTime.now();

    _subsDaysController.text = subsDays.toString();
    pickedDateEnd =
        new DateTime(dateRandom.year, dateRandom.month, dateRandom.day + 28);

    _finishDateController.text =
        "${pickedDateEnd.day}-${pickedDateEnd.month}-${pickedDateEnd.year}";
    pickedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Subscription"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _startDateController,
                decoration:
                    InputDecoration(labelText: 'Subscription Start Date'),
                onTap: () async {
                  DateTime date = await showDatePicker(
                      context: context,
                      initialDate: pickedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100));

                  _startDateController.text =
                      "${date.day}-${date.month}-${date.year}";

                  if (date != null) {
                    setState(() {
                      pickedDate = date;
                    });
                  }
                },
              ),

              TextField(
                controller: _subsDaysController,
                decoration: InputDecoration(
                  labelText: 'Subscription Days',
                  // errorText: int.parse(_subsDaysController.text) < 3650
                  //     ? null
                  //     : "Subscription more than 10 years?",
                ),
                keyboardType: TextInputType.number,
                onChanged: (String days) {
                  setState(() {
                    var dateRandom = DateTime.now();
                    pickedDateEnd = new DateTime(dateRandom.year,
                        dateRandom.month, dateRandom.day + int.parse(days));

                    _finishDateController.text =
                        "${pickedDateEnd.day}-${pickedDateEnd.month}-${pickedDateEnd.year}";
                  });
                },
              ),
              TextField(
                controller: _finishDateController,
                decoration: InputDecoration(labelText: 'Subscription End Date'),
                onTap: () async {
                  DateTime date = await showDatePicker(
                      context: context,
                      initialDate: pickedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100));

                  _finishDateController.text =
                      "${date.day}-${date.month}-${date.year}";

                  if (date != null) {
                    setState(() {
                      pickedDate = date;
                    });
                  }
                },
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                  onPressed: () async {
                    var finishDate = new DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute);

                    var startDate = new DateTime(
                        pickedDateEnd.year,
                        pickedDateEnd.month,
                        pickedDateEnd.day,
                        pickedTime.hour,
                        pickedTime.minute);

                    // var payload = {
                    //   "name": _nameController.text,
                    //   "description": _descriptionController.text,
                    //   "userId": user.uid,
                    //   "amount": _amountController.text,
                    //   "startDate": startDate,
                    //   "finishDate": finishDate,
                    //   "done": false,
                    //   "reminders": 2
                    // };

                    Subscription newSubscription = new Subscription(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        userId: user.uid,
                        amount: int.parse(_amountController.text),
                        startDate: startDate,
                        finishDate: finishDate,
                        done: false,
                        reminders: 2);

                    repository.createSubscription(newSubscription).then((_) {
                      print("collection created");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Home()));
                    }).catchError((e) {
                      print(e);
                      print("an error occured");
                    });
                  },
                  child: Text("Create")),
            ],
          ),
        )
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (BuildContext context) => Home()));
        //   },
        //   child: const Icon(Icons.navigation),
        //   backgroundColor: Colors.green,
        // ),
        );
  }
}

// const gg = Center(
//           child: Column(
//         children: [
//           Text("Create"),
//           FlatButton(
//               onPressed: () {
//                 FirebaseFirestore.instance.collection("subscriptions").add({
//                   'full_name': "Bijli ka bill",
//                   'company': "company",
//                   'age': "age"
//                 }).then((_) {
//                   print("collection created");
//                 }).catchError((e) {
//                   print(e);
//                   print("an error occured");
//                 });
//               },
//               child: Text("Cretea dummy data"))
//         ],
//       )),
