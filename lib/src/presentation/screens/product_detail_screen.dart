import 'package:product_prices/src/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/cart.dart';
import '../presentation.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Columna de información del producto (a la izquierda)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Precio con estilo destacado
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                      fontSize: 32.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Categoría del producto
                  Text(
                    'Category: ${product.category.name}', // Muestra el nombre de la categoría
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Descripción con un estilo elegante
                  Text(
                    'Description',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  Text(
                    product.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 16.0,
                      height: 1.5, // Espaciado entre líneas
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const Spacer(),  // Spacer para empujar el botón hacia abajo

                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Lógica para agregar el producto al carrito
                        context.read<Cart>().addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} añadido al carrito'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Añadir al carrito'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(0, 25, 118, 210),
                        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                        textStyle: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Imagen que ocupa el 40% derecho de la pantalla
            SizedBox(
              width: screenWidth * 0.4,
              child: ProductImage(
                height: screenWidth * 0.4,  // Ajusta el tamaño a la pantalla
                width: screenWidth * 0.4,   // Ajusta el tamaño a la pantalla
                tag: product.id.toString(),  // El mismo tag que en la lista
                url: product.images[0],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

