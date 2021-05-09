import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:subscription_manager/classes/Subscription.dart';

class DataRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('subscriptions');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> createSubscription(Subscription subscription) {
    return collection.add(subscription.toJson());
  }

  updateSubscription(String subId, Subscription subscription) async {
    await collection.doc(subId).update(subscription.toJson());
  }

  deleteSubscription(String subId) async {
    await collection.doc(subId).delete();
  }
}
