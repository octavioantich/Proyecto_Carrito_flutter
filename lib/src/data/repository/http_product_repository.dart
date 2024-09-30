import 'dart:convert';
import 'dart:io';

import 'package:product_prices/src/domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class HttpProductRepository implements ProductRepository {
  final _logger = Logger('HttpProductRepository');

  @override
  Future<List<Product>> getProductCurrencies() async {
    final uri = Uri.parse(ProductRepository.endpoint);

    _logger.finest('--- HTTP REQUEST ---\nURL: ${ProductRepository.endpoint}');

    final response = await http.get(uri);

    _logger.finest(
      '--- HTTP response ---\nStatus Code: ${response.statusCode}\nResponse Body: ${response.body}',
    );

    if (response.statusCode == HttpStatus.ok) {
      final productList = Product.fromDynamicList(
        json.decode(response.body),
      );
      return productList;
    } else {
      throw Exception('Failed to load product data');
    }
  }
}
