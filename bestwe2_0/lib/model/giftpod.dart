class GiftPot {
  final String giftPotId;
  final String productName;
  final String productImage;
  final double totalAmount;
  final double contributedAmount;
  final double progressPercent;
  final bool isCreator;

  GiftPot({
    required this.giftPotId,
    required this.productName,
    required this.productImage,
    required this.totalAmount,
    required this.contributedAmount,
    required this.progressPercent,
    required this.isCreator,
  });

  factory GiftPot.fromJson(Map<String, dynamic> json) {
    return GiftPot(
      giftPotId: json['gift_pot_id'] ?? '',
      productName: json['product_name'] ?? '',
      productImage: json['product_image'] ?? '',
      totalAmount: (json['total_amount'] as num).toDouble(),
      contributedAmount: (json['contributed_amount'] as num).toDouble(),
      progressPercent: (json['progress_percent'] as num).toDouble(),
      isCreator: json['is_creator'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gift_pot_id': giftPotId,
      'product_name': productName,
      'product_image': productImage,
      'total_amount': totalAmount,
      'contributed_amount': contributedAmount,
      'progress_percent': progressPercent,
      'is_creator': isCreator,
    };
  }
}

//...........Gift Recommendation Model...........//
class GiftRecommendation {
  final String? name;
  final String? reason;
  final String? url;
  final String? image;
  final String? price;
  final String? description;
  final String? occasion;
  final List<ResponseFormItem>? responseFormData;

  GiftRecommendation({
    this.name,
    this.reason,
    this.url,
    this.image,
    this.price,
    this.description,
    this.occasion,
    this.responseFormData,
  });

  factory GiftRecommendation.fromJson(Map<String, dynamic> json) {
    return GiftRecommendation(
      name: json['name']?.toString(),
      reason: json['reason']?.toString(),
      url: json['url']?.toString(),
      image: json['image']?.toString(),
      price: json['price']?.toString(),
      description: json['description']?.toString(),
      occasion: json['occasion']?.toString(),
      responseFormData: json['response_form_data'] != null && json['response_form_data'] is List
          ? (json['response_form_data'] as List).map((item) => ResponseFormItem.fromJson(item))
          .toList() : [],
      );
    }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'reason': reason,
      'url': url,
      'image': image,
      'price': price,
      'description': description,
      'occasion': occasion,
      'response_form_data': responseFormData?.map((e) => e.toJson()).toList(),
    };
  }
}


//Gift Recondation question_answer model
class ResponseFormItem {
  final String? question;
  final String? responseText;

  ResponseFormItem({this.question, this.responseText});

  factory ResponseFormItem.fromJson(Map<String, dynamic> json) {
    return ResponseFormItem(
      question: json['question'],
      responseText: json['response_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'response_text': responseText,
    };
  }
}