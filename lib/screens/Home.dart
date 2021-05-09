import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subscription_manager/classes/Subscription.dart';
import 'package:subscription_manager/components/MyDrawer.dart';
import 'package:subscription_manager/components/SubscriptionItem.dart';
import 'package:subscription_manager/screens/Create.dart';
import 'package:subscription_manager/services/DataRepo.dart';
import 'package:subscription_manager/utils/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> signOut() async {
    await Authentification().signOut();
  }

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("All Subscriptions"),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Subscription newSubs = Subscription.fromJson(document.data());
              return SubscriptionItem(
                  subscription: newSubs, subId: document.id);
            }).toList(),
          );
        },
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CreatePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ListView _buildList(subscriptions) {
//   return ListView.builder(
//     itemCount: subscriptions.length,
//     itemBuilder: (context, index) {
//       final Subscription subscription = subscriptions[index];

//       return Column(
//         children: [Text(subscription.name)],
//       );
//     },
//   );
// }

// body: StreamBuilder<QuerySnapshot>(
//   stream: repository.getStream(),
//   builder: (context, snapshot) {
//     if (!snapshot.hasData) return LinearProgressIndicator();
//     return _buildList(context, snapshot.data.documents);
//   }),
