import 'package:educloud_mobile/providers/base_provider.dart';

class OnboardingProvider extends BaseProvider {
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  void islastpage_true() {
    _isLastPage = true;
    notifyListeners();
  }

  void islastpage_false() {
    _isLastPage = false;
    notifyListeners();
  }
}
