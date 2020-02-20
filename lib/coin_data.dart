import 'package:http/http.dart' as http;
import 'dart:convert';
import './price_screen.dart';

const apiKey = '94FBD943-61A4-457A-9028-D4CA9A5DD37A';
const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';

int indexNumber = 0;
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
  PriceScreen indexCurrency = PriceScreen();
  Future<dynamic> getCoinData(String selectedCurrency) async {
    //String selectedCurrency = currenciesList[indexCurrency.getIndex()];
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestedURL =
          '$coinApiUrl/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestedURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return cryptoPrices;
  }
}
