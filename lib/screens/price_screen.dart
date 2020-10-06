import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widget/board_exchange_rate.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //TODO 6: Update the default currency to AUD, the first item in the currencyList.
  String selectCurrency = 'AUD';
  String exchangeRate = '?';
  CoinData coinData = CoinData();

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> myDropdown = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      myDropdown.add(newItem);
    }
    return DropdownButton<String>(
      value: selectCurrency,
      items: myDropdown,
      //TODO 2: Call getData() when the picker/dropdown changes.
      onChanged: (String newValue) => setState(() {
        getData();
        selectCurrency = newValue;
      }),
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerText = [];
    for (String currency in currenciesList) {
      pickerText.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Color(0xFF6C51FF),
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        //TODO 1: Save the selected currency to the property selectedCurrency
        selectCurrency =
            selectedIndex.toStringAsFixed(0); // transform int to String
        //TODO 2: Call getData() when the picker/dropdown changes.
        setState(() {
          getData();
        });
      },
      children: pickerText,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var data = await coinData.getCoinData(selectCurrency);
      double price = data['rate'];
      exchangeRate = price.toStringAsFixed(0);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BoardExchangeRate(
            exchangeRate: exchangeRate,
            selectCurrency: selectCurrency,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF6C51FF),
            child: Platform.isAndroid ? androidDropdown() : iosPicker(),
          ),
        ],
      ),
    );
  }
}
