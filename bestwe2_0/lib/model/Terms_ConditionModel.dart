class TermsModel {
  final String content;
  TermsModel({required this.content});
  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      content: json['content'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }
}

///..........Privacy Mode..........///
class PrivacyModel {
  final String content;

  PrivacyModel({required this.content});

  factory PrivacyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyModel(
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }
}

///..........About Model..........///

class AboutUsModel{
  final String content;
  AboutUsModel({required this.content});

  factory AboutUsModel.fromJson(Map<String,dynamic>json){
    return AboutUsModel(content: json['content']);
  }
  Map<String,dynamic> toJson(){
    return {
      'content': content,
    };
  }
}