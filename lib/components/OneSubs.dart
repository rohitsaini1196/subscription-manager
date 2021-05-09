import 'package:flutter/material.dart';
import 'package:subscription_manager/classes/Subscription.dart';
import 'package:intl/intl.dart';
import 'package:subscription_manager/screens/Home.dart';
import 'package:subscription_manager/services/DataRepo.dart';

class OneSubs extends StatelessWidget {
  OneSubs(this.subscription, this.subId);
  final Subscription subscription;
  final String subId;

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscription Details',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.subscriptions),
                  title: Text(subscription.name),
                  subtitle: Text(subscription.description),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          'Amount: ',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                        Text(
                          subscription.amount.toString(),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₹',
                          style: TextStyle(color: Colors.black.withOpacity(1)),
                        ),
                      ],
                    )),

                // Padding(
                //     padding: EdgeInsets.all(16.0),
                //     child: Row(
                //       children: [
                //         Text(
                //           'Id: ',
                //           style:
                //               TextStyle(color: Colors.black.withOpacity(0.6)),
                //         ),
                //         Text(
                //           subscription.id,
                //           style: TextStyle(
                //               color: Colors.black.withOpacity(0.9),
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ],
                //     )),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          'Created at: ',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                        Text(
                          DateFormat().format(subscription.startDate),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          'End at: ',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                        Text(
                          DateFormat("MMMM dd, yyyy")
                              .format(subscription.finishDate),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                          onPressed: () {},
                          child: const Text('Edit'),
                          color: Colors.blueAccent),
                      FlatButton(
                        onPressed: () {
                          repository.deleteSubscription(subId).then((_) {
                            print("collection deleted");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Home()));
                          }).catchError((e) {
                            print(e);
                            print("an error occured");
                          });
                        },
                        child: const Text('Delete'),
                        color: Colors.pink,
                      ),
                    ],
                  ),
                ),

                // Image.network(
                //     "https://cdn0.iconfinder.com/data/icons/business-management-3-4/256/m-26-128.png")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// child: Padding(
//             padding: const EdgeInsets.only(
//               left: 10.0,
//               top: 10.0,
//               bottom: 10.0,
//               right: 10.0,
//             ),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               elevation: 5,
//               shadowColor: Colors.blue,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 5.0,
//                   top: 15.0,
//                   bottom: 5.0,
//                   right: 5.0,
//                 ),
//                 child: Container(
//                   width: size.width,
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0), //or 15.0
//                           child: Image(
//                             image: NetworkImage(
//                                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz6kIlqhOw2ySGqviTFlmx5y_7KfnrfHn6TA&usqp=CAU"),
//                           )),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 25.0,
//                           top: 5.0,
//                           bottom: 5.0,
//                           right: 20.0,
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               "Title : ${subscription.name}",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Color(0XFF5d61f5),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 12,
//                             ),
//                             Text(
//                               "When",
//                               style: TextStyle(
//                                 fontSize: 17.5,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Text(
//                               "Description : ${subscription.description}",
//                               style: TextStyle(
//                                 fontSize: 15,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ), //Padding
//                 ),
//               ),
//             ),
//           ),
