class AlertModel {
  final String? id;
  final String userId;
  final double targetPrice;
  final String karat;
  final String currency;
  final bool isActive;
  final DateTime createdAt;
  final bool isTriggered;

  AlertModel({
    this.id,
    required this.userId,
    required this.targetPrice,
    required this.karat,
    required this.currency,
    this.isActive = true,
    required this.createdAt,
    this.isTriggered = false,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      targetPrice: (json['targetPrice'] as num).toDouble(),
      karat: json['karat'] as String,
      currency: json['currency'] as String,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isTriggered: json['isTriggered'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'targetPrice': targetPrice,
      'karat': karat,
      'currency': currency,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'isTriggered': isTriggered,
    };
  }

  AlertModel copyWith({
    String? id,
    String? userId,
    double? targetPrice,
    String? karat,
    String? currency,
    bool? isActive,
    DateTime? createdAt,
    bool? isTriggered,
  }) {
    return AlertModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      targetPrice: targetPrice ?? this.targetPrice,
      karat: karat ?? this.karat,
      currency: currency ?? this.currency,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      isTriggered: isTriggered ?? this.isTriggered,
    );
  }
}