class Assets {
  Assets._();

  // Images
  static const String banner = 'assets/images/banner.png';

  // Products
  static const String p1 = 'assets/images/products/p1.png';
  static const String p2 = 'assets/images/products/p2.png';
  static const String p3 = 'assets/images/products/p3.png';
  static const String p4 = 'assets/images/products/p4.png';
  static const String p5 = 'assets/images/products/p5.png';
  static const String p6 = 'assets/images/products/p6.png';
  static const String p7 = 'assets/images/products/p7.png';
  static const String p8 = 'assets/images/products/p8.png';

  // Category network images (using picsum for placeholder)
  static String productNetwork(int seed) =>
      'https://picsum.photos/seed/$seed/300/300';
}
