import 'package:flutter/material.dart';
import 'package:subscription_manager/classes/Subscription.dart';
import 'package:intl/intl.dart';
import 'package:subscription_manager/components/OneSubs.dart';

class SubscriptionItem extends StatefulWidget {
  final Subscription subscription;
  final String subId;

  SubscriptionItem({@required this.subscription, @required this.subId});
  @override
  _SubscriptionItemState createState() => _SubscriptionItemState();
}

class _SubscriptionItemState extends State<SubscriptionItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.subscription.name),
            subtitle: Text(widget.subscription.description),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn0.iconfinder.com/data/icons/business-management-3-4/256/m-26-128.png"),
              radius: 22,
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 2.0),
              child: Column(
                children: [
                  Text("26 Days remaining"),
                  Text(DateFormat("MMMM dd, yyyy")
                      .format(widget.subscription.finishDate))
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OneSubs(widget.subscription,
                          widget.subId))); // Navigator.push(
            },
          ),
        ),
      ),
    );
  }
}

//  child: Column(
//           children: <Widget>[
//             InkWell(
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     left: 10.0, top: 10.0, right: 4.0, bottom: 10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             left: 0.0,
//                             top: 5.0,
//                             right: 5.0,
//                           ),
//                           child: CircleAvatar(
//                             backgroundImage: NetworkImage(
//                                 "https://cdn0.iconfinder.com/data/icons/business-management-3-4/256/m-26-128.png"),
//                             radius: 22,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             left: 10.0,
//                             top: 0.0,
//                             right: 5.0,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 widget.subscription.name,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 widget.subscription.description,
//                                 overflow: TextOverflow.ellipsis,
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               right: 2.0, top: 2.0, left: 2.0),
//                           child: Column(
//                             children: [
//                               Text("26 Days remaining"),
//                               Text(DateFormat("MMMM dd, yyyy")
//                                   .format(widget.subscription.finishDate))
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               onTap: () {
//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //         builder: (context) => OneOrg(org, false)));
//               },
//             ),
//             SizedBox(
//               height: 1.0,
//             ),
//             Divider()
//           ],
//         ),
