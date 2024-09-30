import 'package:product_prices/src/domain/domain.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/cart.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCartPressed;

  const ProductItem({
    super.key,
    required this.product,
    required this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    context.watch<Cart>();  // Accedemos al carrito

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ProductImage(
                height: 100.0,
                width: 100.0,
                tag: product.id.toString(),
                url: product.images[0],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    product.category.name,
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                '\$ ${product.price.toStringAsFixed(2)}',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.end,
              ),
            ),
            TextButton(
              onPressed: onAddToCartPressed,
              child: const Text('Añadir al carrito'),
            ),
          ],
        ),
      ),
    );
  }
}
