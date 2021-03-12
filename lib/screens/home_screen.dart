import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:wallet_manager/helpers/shared_prefs.dart';
import 'package:wallet_manager/screens/add_income.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet_manager/screens/spend_money.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final firestoreInstance = FirebaseFirestore.instance;
final fAuth = FirebaseAuth.instance;
// FirebaseUser _firebaseUser;
TextEditingController pinCode;

class _HomeScreenState extends State<HomeScreen> {
  bool oops = false;
  @override
  void initState() {
    pinCode = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet Manager'),
        centerTitle: true,
        actions: [
          Switch(
            activeColor: Colors.red,
            onChanged: (x) {
              if (x == false) {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20),
                                TextFormField(
                                  autofocus: true,
                                  obscureText: true,
                                  controller: pinCode,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Pin',
                                      labelText: 'Enter Pin'),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    var u = await Prefs.prefs
                                        .initLock(pinCode.text);
                                    if (u == 0) {
                                      Navigator.of(context).pop();
                                      pinCode.clear();
                                      Future.delayed(
                                          Duration(milliseconds: 500), () {
                                        setState(() {
                                          Prefs.prefs.lockApp(false);
                                        });
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text('UNLOCK'),
                                )
                              ],
                            ),
                          ),
                        ));
              } else {
                setState(() {
                  Prefs.prefs.lockApp(x);
                });
              }
            },
            value: Prefs.prefs.locked,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              fAuth.createUserWithEmailAndPassword(
                  email: 'nzekakooza@gmail.com', password: 'peter@&=');
              // firestoreInstance.collection('expenses').add({
              //   "reason": "Aded from app",
              //   "amount": 2120,
              //   "Timestamp": Timestamp.fromDate(DateTime.now()),
              //   "type": "spending",
              // })
              //   ..then((x) => print(x));

              // firestoreInstance
              //     .collection("expenses")
              //     .get()
              //     .then((querySnapshot) {
              //   print(querySnapshot.docs.single.data());
              // });
            },
          )
        ],
      ),
      drawer: !Prefs.prefs.locked
          ? SafeArea(
              child: Drawer(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        child: Text('SK'),
                      ),
                      accountEmail: Text(
                        'nzekakooza@gmail.com',
                      ),
                      accountName: Text('Steven Kakooza'),
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text('Today\'s Income'),
                      leading: Icon(Icons.stacked_line_chart_rounded),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {},
                      title: Text('Today\'s Expenses'),
                      leading: Icon(Icons.soap_sharp),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {},
                      title: Text('Today\'s Savings'),
                      leading: Icon(Icons.account_balance_wallet),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.logout),
                      title: Text('Log Out'),
                    ),
                  ],
                ),
              ),
            )
          : null,
      floatingActionButton: !Prefs.prefs.locked
          ? HawkFabMenu(
              blur: 3,
              body: Text('bpdy'),
              items: [
                HawkFabMenuItem(
                  icon: Icon(Icons.stacked_line_chart_rounded),
                  label: 'Add income',
                  labelBackgroundColor: Colors.green,
                  labelColor: Colors.white,
                  ontap: () {
                    Future.delayed(Duration(seconds: 1), () {
                      showDialog(
                          context: context, builder: (context) => AddIncome());
                    });
                  },
                ),
                HawkFabMenuItem(
                  icon: Icon(Icons.soap_sharp),
                  label: 'Add Expense',
                  color: Colors.red,
                  labelBackgroundColor: Colors.red,
                  labelColor: Colors.white,
                  ontap: () {
                    Future.delayed(Duration(seconds: 1), () {
                      showDialog(
                          context: context, builder: (context) => SpendMoney());
                    });
                  },
                ),
              ],
            )
          : null,
      body: !Prefs.prefs.locked
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Material(
                      elevation: 1,
                      child: Container(
                        // height: screenHeight / 2.5,
                        color: Colors.white,
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Text(
                                  'Today\'s Income',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Source',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Ammount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.grey.withOpacity(0.4),
                              onTap: () {},
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                'Mulindwa Paid Me my money bsecaus ejkjsjd jod jiueieo io',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                'UGX 40,000',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.green.withOpacity(0.4),
                              onTap: () {},
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                'Mulindwa Paid Me my money bsecaus ejkjsjd jod jiueieo io',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                'UGX 40,000',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.grey.withOpacity(0.4),
                              onTap: () {},
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                'Mulindwa Paid Me my money bsecaus ejkjsjd jod jiueieo io',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                'UGX 40,000',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.green.withOpacity(0.4),
                              onTap: () {
                                print('tapped');
                              },
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                'Mulindwa Paid Me my money bsecaus ejkjsjd jod jiueieo io',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                'UGX 40,000',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                child: Text('View All'),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Material(
                      elevation: 1,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Text(
                                  'Today\'s Expenses',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )
                              ],
                            ),
                            Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Reason',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Ammount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.grey.withOpacity(0.4),
                              onTap: () {},
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                'Paid transport ejkjsjd jod jiueieo io',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                'UGX 12,000',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.red.withOpacity(0.4),
                              onTap: () {},
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                'Paid Rent ',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                'UGX 40,000',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.grey.withOpacity(0.4),
                              onTap: () {},
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                'Lunch',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                'UGX 40,000',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.red.withOpacity(0.4),
                              onTap: () {},
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                'Gave her',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                'UGX 40,000',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                child: Text('View All'),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Material(
                      elevation: 1,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Text(
                                  'Today\'s Savings',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                            Divider(),
                            Container(
                              height: 150,
                              child: Text(
                                'UGX 50,000',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 70),
                  SizedBox(height: 20),
                  Text('Locked'),
                ],
              ),
            ),
    );
  }
}
