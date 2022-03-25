import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform; // iOS android 구별하기 위해 임포트

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'KRW';

  DropdownButton<String> androidButton() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: getDropdownMenuItems(),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
          });
        });
  }

  List<DropdownMenuItem> getDropdownMenuItems() {
    List<DropdownMenuItem<String>> dropdownMenuItemsCurrency =
    []; // String을 꼭 넣어줘야 되는거야 뭐야~!!
    for (String newCurrency in currenciesList) {
      var newCurrencyItem = DropdownMenuItem(
        child: Text(newCurrency),
        value: newCurrency,
      );
      dropdownMenuItemsCurrency.add(newCurrencyItem);
    }
    return dropdownMenuItemsCurrency;
  }

  CupertinoPicker iosButton() {
    return CupertinoPicker(
      itemExtent: 45,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: getPickerMenuItems(),
    );
  }

  List<Text> getPickerMenuItems() {
    List<Text> pickerMenuItems = [];
    for (String newCurrency in currenciesList) {
      pickerMenuItems.add(Text(newCurrency));
    }
    return pickerMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 코인 시세 조회 머신'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? KRW',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isAndroid ? androidButton() : iosButton(),
          ),
        ],
      ),
    );
  }
}
