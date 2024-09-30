class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final Category category;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  // Factory para construir un Product a partir de un mapa dinámico (JSON)
  factory Product.fromDynamic(dynamic map) {
    return Product(
      id: map['id'],
      title: map['title'],
      price: map['price'].toDouble(),
      description: map['description'],
      category: Category.fromDynamic(map['category']),
      images: List<String>.from(map['images']),
    );
  }

  // Método para convertir una lista dinámica en una lista de productos
  static List<Product> fromDynamicList(dynamic list) {
    final result = <Product>[];

    if (list != null) {
      for (dynamic map in list) {
        result.add(Product.fromDynamic(map));
      }
    }

    return result;
  }
}

// Clase adicional para la categoría de producto
class Category {
  final int id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromDynamic(dynamic map) {
    return Category(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
  }
}
