import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/const.dart';

class BoardExchangeRate extends StatelessWidget {
  const BoardExchangeRate({
    @required this.exchangeRate,
    @required this.selectCurrency,
    this.crypto,
    this.child,
  });

  final String exchangeRate;
  final String selectCurrency;
  final String crypto;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: kBaseColor,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            // 5: Update the currency name depending on the selectedCurrency.
            '1 $crypto = $exchangeRate $selectCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: kBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
