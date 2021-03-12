import 'package:flutter/material.dart';

class SpendMoney extends StatefulWidget {
  @override
  _SpendMoneyState createState() => _SpendMoneyState();
}

class _SpendMoneyState extends State<SpendMoney> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.height;

    return Dialog(
      child: Container(
        height: screenHeight / 2,
        width: screenWidth / 1.5,
        color: Colors.white,
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Expenditure',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'UGX',
                      labelText: 'Ammount'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Reason',
                      labelText: 'Reason'),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('SAVE EXPENSE'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
