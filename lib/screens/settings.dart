import 'package:flutter/material.dart';
import 'package:wallet_manager/helpers/shared_prefs.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text("Change Pin"),
              onTap: () {
                showDialog(context: context, builder: (context) => PinChange());
              },
            )
          ],
        ),
      ),
    );
  }
}

//Change Pin Dispaly
TextEditingController newPin;
TextEditingController oldPin;

class PinChange extends StatefulWidget {
  const PinChange({
    Key key,
  }) : super(key: key);

  @override
  _PinChangeState createState() => _PinChangeState();
}

class _PinChangeState extends State<PinChange> {
  @override
  void initState() {
    newPin = TextEditingController();
    oldPin = TextEditingController();
    super.initState();
  }

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
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: oldPin,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Current Pin ',
                      labelText: 'Current Pin'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: newPin,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'New Pin',
                      labelText: 'New Pin'),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    var x = await Prefs.prefs
                        .changePin(newPin: newPin.text, oldPin: oldPin.text);
                    print(x);
                  },
                  child: Text('CHANGE PIN'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
