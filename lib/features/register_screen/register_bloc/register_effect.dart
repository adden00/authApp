
abstract class RegisterEffect {}

class RegisterEffectShowSnackbar extends RegisterEffect {
  RegisterEffectShowSnackbar(this.message);

  final String message;
}
class RegisterEffectSuccess extends RegisterEffect {}