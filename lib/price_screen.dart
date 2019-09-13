import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurrency = 'USD';
  List<String> currencyValue = ['?', '?', '?'];
  List<String> currencyData = [];

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getCurrencyData();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.transparent,
      itemExtent: 23.0,
      onSelectedItemChanged: (selectedItemIndex) {
        selectedCurrency = currenciesList[selectedItemIndex];
        getCurrencyData();
      },
      children: pickerItems,
      squeeze: 1,
    );
  }

  @override
  void initState() {
    getCurrencyData();
    super.initState();
  }

  void getCurrencyData() async {
    currencyData = await coinData.getCoinData(selectedCurrency);
    setState(() {
      for (int i = 0; i < 3; i++) {
        currencyValue[i] = currencyData[i];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CurrencyCard(
            currencyValue: currencyValue[0],
            selectedCurrency: selectedCurrency,
            cryptoCurrency: cryptoList[0],
          ),
          CurrencyCard(
            currencyValue: currencyValue[1],
            selectedCurrency: selectedCurrency,
            cryptoCurrency: cryptoList[1],
          ),
          CurrencyCard(
            currencyValue: currencyValue[2],
            selectedCurrency: selectedCurrency,
            cryptoCurrency: cryptoList[2],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    @required this.cryptoCurrency,
    @required this.currencyValue,
    @required this.selectedCurrency,
  });

  final String cryptoCurrency;
  final String currencyValue;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $cryptoCurrency = $currencyValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
