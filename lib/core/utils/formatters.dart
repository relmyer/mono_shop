class Formatters {
  Formatters._();

  static String currency(double amount, {String symbol = '\$'}) {
    if (amount == amount.truncate()) {
      return '$symbol${amount.toInt()}';
    }
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  static String discount(int percent) => '$percent% OFF';

  static String reviewCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k reviews';
    }
    return '$count reviews';
  }

  static String soldCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k sold';
    }
    return '$count sold';
  }

  static String rating(double rating) => rating.toStringAsFixed(1);
}
