class Product {
  final String id;
  final String title;
  final String brand;
  final double price;
  final double? oldPrice;
  final int? discountPercent;
  final double rating;
  final int reviewCount;
  final int soldCount;
  final List<String> images;
  final String category;
  final List<String> sizes;
  final String description;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    this.oldPrice,
    this.discountPercent,
    required this.rating,
    required this.reviewCount,
    required this.soldCount,
    required this.images,
    required this.category,
    required this.sizes,
    required this.description,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String,
        title: json['title'] as String,
        brand: json['brand'] as String,
        price: (json['price'] as num).toDouble(),
        oldPrice: json['oldPrice'] != null
            ? (json['oldPrice'] as num).toDouble()
            : null,
        discountPercent: json['discountPercent'] as int?,
        rating: (json['rating'] as num).toDouble(),
        reviewCount: json['reviewCount'] as int,
        soldCount: json['soldCount'] as int,
        images: List<String>.from(json['images'] as List),
        category: json['category'] as String,
        sizes: List<String>.from(json['sizes'] as List),
        description: json['description'] as String,
        isFavorite: json['isFavorite'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'brand': brand,
        'price': price,
        'oldPrice': oldPrice,
        'discountPercent': discountPercent,
        'rating': rating,
        'reviewCount': reviewCount,
        'soldCount': soldCount,
        'images': images,
        'category': category,
        'sizes': sizes,
        'description': description,
        'isFavorite': isFavorite,
      };

  Product copyWith({
    String? id,
    String? title,
    String? brand,
    double? price,
    double? oldPrice,
    int? discountPercent,
    double? rating,
    int? reviewCount,
    int? soldCount,
    List<String>? images,
    String? category,
    List<String>? sizes,
    String? description,
    bool? isFavorite,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        brand: brand ?? this.brand,
        price: price ?? this.price,
        oldPrice: oldPrice ?? this.oldPrice,
        discountPercent: discountPercent ?? this.discountPercent,
        rating: rating ?? this.rating,
        reviewCount: reviewCount ?? this.reviewCount,
        soldCount: soldCount ?? this.soldCount,
        images: images ?? this.images,
        category: category ?? this.category,
        sizes: sizes ?? this.sizes,
        description: description ?? this.description,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
