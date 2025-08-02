import 'package:bestwe2_0/model/Terms_ConditionModel.dart';
import 'package:bestwe2_0/services/user_services.dart';
import 'package:flutter/material.dart';

class StaticContentState extends ChangeNotifier {
  final UserServices _userService;
  StaticContentState(this._userService);

  TermsModel? _terms;
  PrivacyModel? _privacy;
  AboutUsModel? _about;

  TermsModel? get terms => _terms;
  PrivacyModel? get privacy => _privacy;
  AboutUsModel? get aboutus => _about;

  Future<void> fetchTerms() async {
    try {
      final result = await _userService.fetchSingle<TermsModel>(
        url: '/terms-and-conditions/',
        fromJson: (json) => TermsModel.fromJson(json),
      );
      _terms = result;
      notifyListeners();
    } catch (e) {
      print('Terms fetch error: $e');
    }
  }

  Future<void> fetchPrivacy() async {
    try {
      final result = await _userService.fetchSingle<PrivacyModel>(
        url: '/privacy-policy/',
        fromJson: (json) => PrivacyModel.fromJson(json),
      );
      _privacy = result;
      notifyListeners();
    } catch (e) {
      print('Privacy fetch error: $e');
    }
  }

  Future<void> fetchAboutUs() async {
    try {
      final result = await _userService.fetchSingle<AboutUsModel>(
        url: '/aboutus/',
        fromJson: (json) => AboutUsModel.fromJson(json),
      );
      _about = result;
      notifyListeners();
    } catch (e) {
      print('About Us fetch error: $e');
    }
  }

}
