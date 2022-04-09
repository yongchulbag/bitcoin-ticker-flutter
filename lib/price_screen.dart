import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform; // iOS android 구별하기 위해 임포트
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'EA833DEA-DC66-47B1-BF2E-B8628619FAAD';
var selectedCurrency = 'KRW';

var btc_full_data;
var eth_full_data;
var doge_full_data;

double btc_raw_exchange_rate;
double eth_raw_exchange_rate;
double doge_raw_exchange_rate;

int btc_exchange_rate;
int eth_exchange_rate;
int doge_exchange_rate;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String btc_url =
      "https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=$apiKey";
  String eth_url =
      "https://rest.coinapi.io/v1/exchangerate/ETH/$selectedCurrency?apikey=$apiKey";
  String doge_url =
      "https://rest.coinapi.io/v1/exchangerate/DOGE/$selectedCurrency?apikey=$apiKey";

  Future getData() async {
    http.Response btc_response = await http.get(btc_url);
    btc_full_data = jsonDecode(btc_response.body);
    btc_raw_exchange_rate = btc_full_data['rate'];
    btc_exchange_rate = btc_raw_exchange_rate.toInt();

    http.Response eth_response = await http.get(eth_url);
    eth_full_data = jsonDecode(eth_response.body);
    eth_raw_exchange_rate = eth_full_data['rate'];
    eth_exchange_rate = eth_raw_exchange_rate.toInt();

    http.Response doge_response = await http.get(doge_url);
    doge_full_data = jsonDecode(doge_response.body);
    doge_raw_exchange_rate = doge_full_data['rate'];
    doge_exchange_rate = doge_raw_exchange_rate.toInt();
  }

  DropdownButton<String> androidButton() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: getDropdownMenuItems(),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getData();
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

  Widget osSelect() {
    if (Platform.isAndroid == true) {
      return androidButton();
    } else if (Platform.isIOS == true) {
      return iosButton();
    }
  }

  // 웹 에뮬에서 Platform 운영체제 확인을 지원하지 않음!!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 대표 코인 시세 조회 머신'),
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
                  '1 비트코인 = $btc_exchange_rate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 이더리움 = $eth_exchange_rate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 닷지코인 = $doge_exchange_rate $selectedCurrency',
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
            child: androidButton(),
          ),
        ],
      ),
    );
  }
}
