class GoldPriceModel {
  final String? currency;
  final int? timestamp;
  final double? priceGram24k;
  final double? ch;
  final double? chp;

  GoldPriceModel({
    this.currency,
    this.timestamp,
    this.priceGram24k,
    this.ch,
    this.chp,
  });

  factory GoldPriceModel.fromJson(Map<String, dynamic> json) {
    return GoldPriceModel(
      currency: json['currency'] as String?,
      timestamp: json['timestamp'] as int?,
      priceGram24k: (json['price_gram_24k'] as num?)?.toDouble(),
      ch: (json['ch'] as num?)?.toDouble(),
      chp: (json['chp'] as num?)?.toDouble(),
    );
  }

  // Helper methods
  bool get isPriceUp => (ch ?? 0) > 0;

  String get formattedChange => ch?.toStringAsFixed(2) ?? '0.00';

  String get formattedChangePercent => '${chp?.toStringAsFixed(2) ?? '0.00'}%';

  double? get price21k =>
      priceGram24k != null ? (priceGram24k! * 21) / 24 : null;
  double? get price18k =>
      priceGram24k != null ? (priceGram24k! * 18) / 24 : null;
}
