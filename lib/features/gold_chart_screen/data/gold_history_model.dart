class GoldHistoryModel {
  final DateTime date;
  final double price24k;
  final double price21k;
  final double price18k;

  GoldHistoryModel({
    required this.date,
    required this.price24k,
    required this.price21k,
    required this.price18k,
  });

  factory GoldHistoryModel.fromJson(Map<String, dynamic> json, DateTime date) {
    final price24k = (json['price_gram_24k'] as num?)?.toDouble() ?? 0.0;

    return GoldHistoryModel(
      date: date,
      price24k: price24k,
      price21k: (price24k * 21) / 24,
      price18k: (price24k * 18) / 24,
    );
  }
}