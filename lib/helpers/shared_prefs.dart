import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._();
  static final Prefs prefs = Prefs._();
  bool locked = false;
  String pin;
  createLock() async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    prfs.setString('pinCode', '');
    prfs.setBool('lock', false);
  }

  initLock(pPin) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();

    if (pin == pPin || pin == null) {
      locked = prfs.getBool('lock') ?? false;
      pin = prfs.getString('pinCode');
      return 0;
    } else {
      return 1;
    }
  }

  changePin({oldPin, newPin}) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    if (pin == oldPin || pin == null) {
      prfs.setString('pinCode', newPin);
      prfs.getString('pinCode');
      initLock(pin);
      return 0;
    } else {
      return 1;
    }
  }

  lockApp(bool lock) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    prfs.setBool('lock', lock);
    locked = lock;
  }
}
