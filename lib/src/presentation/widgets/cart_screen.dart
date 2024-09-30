import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/cart.dart';
import 'package:product_prices/src/presentation/presentation.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isHoveringEmpty = false;  // Controla el hover sobre "Vaciar Carrito"
  bool _isHoveringPurchase = false;  // Controla el hover sobre "Realizar Compra"

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: cart.totalItems == 0
          ? const Center(child: Text('El carrito está vacío'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final product = cart.items.keys.elementAt(index);
                      final quantity = cart.items[product]!;

                      return ListTile(
                        leading: ProductImage(
                          height: 100.0,
                          width: 100.0,
                          tag: product.id.toString(),
                          url: product.images[0],
                        ),
                        title: Text(product.title),
                        subtitle: Text('${product.category.name} - Cantidad: $quantity'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$${(product.price * quantity).toStringAsFixed(2)}', // Precio total por objeto
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                cart.removeFromCart(product);  // Eliminar una unidad del carrito
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // Alinear a la derecha
                    children: [
                      // Total de precios
                      Text(
                        'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      // Alinear botones en fila a la derecha
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Centrar a la derecha
                        children: [
                          // Botón para vaciar el carrito con hover effect
                          MouseRegion(
                            onEnter: (_) => setState(() => _isHoveringEmpty = true),
                            onExit: (_) => setState(() => _isHoveringEmpty = false),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isHoveringEmpty ? Colors.red : const Color.fromARGB(0, 33, 149, 243),
                              ),
                              onPressed: () {
                                cart.clearCart();  // Vaciar carrito
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Carrito vaciado')),
                                );
                              },
                              child: const Text('Vaciar Carrito'),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          // Botón para realizar la compra con hover effect
                          MouseRegion(
                            onEnter: (_) => setState(() => _isHoveringPurchase = true),
                            onExit: (_) => setState(() => _isHoveringPurchase = false),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isHoveringPurchase ? Colors.green : const Color.fromARGB(0, 33, 149, 243),
                              ),
                              onPressed: () {
                                // Mensaje de compra realizada y vaciar el carrito
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Compra realizada')),
                                );
                                cart.clearCart();
                              },
                              child: const Text('Realizar Compra'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
