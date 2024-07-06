import 'dart:convert'; // Add this import for jsonDecode
import 'package:crypto/models/cryipto_model.dart';
import 'package:dio/dio.dart';

class CryptoService {
  Future<Crypto> fetchCrypto() async {
    final dio = Dio();

    try {
      final response = await dio.get("https://api.coinlore.net/api/tickers/");

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        if (data is Map<String, dynamic> && data.containsKey('data')) {
          return Crypto.fromJson(data);
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to load province data");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Failed to load province data: $e");
    }
  }
}
