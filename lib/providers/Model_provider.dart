import 'package:educloud_mobile/models/model.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/screens/onboarding_screen.dart';

class ModelProvider extends BaseProvider {
  Model _model = Model();
  Model get model => _model;

  void setTrue_PasswordVisible() {
    _model.passwordVisibility = true;
    notifyListeners();
  }

  void setFalse_PasswordVisible() {
    _model.passwordVisibility = false;
    notifyListeners();
  }
}
