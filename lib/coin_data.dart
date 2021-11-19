import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

const coinAPI = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '5A565F54-D8DB-41BF-A702-A741ED56B1A1';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String url = '$coinAPI/$crypto/$selectedCurrency?apikey=$apiKey';

      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        debugPrint(response.statusCode.toString());
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
