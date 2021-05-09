import 'package:cloud_firestore/cloud_firestore.dart';

class Subscription {
  String name;
  String description;
  String userId;
  DateTime finishDate;
  DateTime startDate;
  int amount;
  bool done;
  int reminders;

  Subscription(
      {this.name,
      this.description,
      this.userId,
      this.finishDate,
      this.startDate,
      this.amount,
      this.done,
      this.reminders});

  Subscription.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    description = json['description'];
    userId = json['userId'];
    finishDate = (json['finishDate'] as Timestamp).toDate();
    startDate = (json['startDate'] as Timestamp).toDate();
    amount = json['amount'];
    done = json['done'];
    reminders = json['reminders'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['finishDate'] = this.finishDate;
    data['startDate'] = this.startDate;
    data['amount'] = this.amount;
    data['done'] = this.done;
    data['reminders'] = this.reminders;

    return data;
  }
}
