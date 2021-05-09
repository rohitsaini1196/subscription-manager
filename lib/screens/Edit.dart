import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_manager/classes/Subscription.dart';
import 'package:subscription_manager/screens/Home.dart';
import 'package:subscription_manager/services/DataRepo.dart';

class EditSubs extends StatefulWidget {
  final Subscription subscription;
  final String subId;

  EditSubs({@required this.subscription, @required this.subId});
  @override
  _EditSubsState createState() => _EditSubsState();
}

class _EditSubsState extends State<EditSubs> {
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

  @override
  void initState() {
    super.initState();

    pickedDate = widget.subscription.startDate;
    pickedDateEnd = widget.subscription.finishDate;
    //Initilize default values

    _nameController.text = widget.subscription.name;
    _amountController.text = widget.subscription.amount.toString();
    _descriptionController.text = widget.subscription.description;
    _finishDateController.text =
        "${widget.subscription.finishDate.day}-${widget.subscription.finishDate.month}-${widget.subscription.finishDate.year}";
    _startDateController.text =
        "${widget.subscription.startDate.day}-${widget.subscription.startDate.month}-${widget.subscription.startDate.year}";
    pickedTime = TimeOfDay.fromDateTime(pickedDate);

    //Date wala stuff
    // pickedDate = widget.subscription.startDate;

    //     _startDateController.text =
    //         "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
    // var dateRandom = DateTime.now();

    _subsDaysController.text = subsDays.toString();
    // pickedDateEnd =
    //     new DateTime(dateRandom.year, dateRandom.month, dateRandom.day + 28);

    // _finishDateController.text =
    //     "${pickedDateEnd.day}-${pickedDateEnd.month}-${pickedDateEnd.year}";
    // pickedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Subscription details"),
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
                    var startDate = new DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute);

                    var finishDate = new DateTime(
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

                    repository
                        .updateSubscription(widget.subId, newSubscription)
                        .then((_) {
                      print("collection updated");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Home()));
                    }).catchError((e) {
                      print(e);
                      print("an error occured");
                    });

                    // repository.createSubscription(newSubscription).then((_) {
                    //   print("collection created");
                    //   Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (BuildContext context) => Home()));
                    // }).catchError((e) {
                    //   print(e);
                    //   print("an error occured");
                    // });
                  },
                  child: Text("Update")),
            ],
          ),
        ));
  }
}
