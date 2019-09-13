import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getCoinData(String selectedCurrency) async {
    List<String> currencyValues = [];
    for (String cryptoCurrency in cryptoList) {
      http.Response response = await http.get(
          'https://apiv2.bitcoinaverage.com/indices/global/ticker/$cryptoCurrency$selectedCurrency');
      if (response.statusCode == 200) {
        String data = response.body;
        currencyValues.add((jsonDecode(data)['last']).toStringAsFixed(0));
      } else {
        print(response.statusCode);
      }
    }
    print(currencyValues);
    return currencyValues;
  }
}
