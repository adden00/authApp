sealed class LoginEffect {}

class LoginEffectShowSnackbar extends LoginEffect {
  LoginEffectShowSnackbar(this.message);

  final String message;
}
class LoginEffectSuccess extends LoginEffect {}
