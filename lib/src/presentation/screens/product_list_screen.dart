import 'package:product_prices/src/domain/domain.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/cart.dart';
import '../widgets/cart_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final Products _productListState;
  @override
  void initState() {
    super.initState();
    _productListState = context.read<Products>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListState.getProducts();
    });
  }

  @override
  void dispose() {
    _productListState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top 100 Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),  // Icono del carrito
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),  // Navegamos a la pantalla del carrito
              ),
            ),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async => _productListState.getProducts(),
        child: StreamBuilder(
          stream: _productListState.productStream,
          builder: (context, snapshot) {
            late Widget result;

            if (snapshot.hasError) {
              result = Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (!snapshot.hasData) {
              result = const Center(child: CircularProgressIndicator());
            } else {
              var productList = snapshot.data!;
              result = _ProductListBody(productList: productList);
            }
            return result;
          },
        ),
      ),
    );
  }
}

class _ProductListBody extends StatelessWidget {
  const _ProductListBody({required this.productList});

  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();  

    return ListView.separated(
      itemCount: productList.length, 
      itemBuilder: (context, index) {
        final product = productList[index]; 

        return ProductItem(
          
          product: product,
          onAddToCartPressed: () {
            cart.addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} añadido al carrito'),
                duration: const Duration(seconds: 1), 
              ),
            );
          },
        );
      },
      separatorBuilder: (_, __) => const Divider(
        endIndent: 16.0,
        height: 1.0,
        indent: 16.0,
        thickness: 1.0,
      ),
    );
  }
}
