abstract class RegExpValidator {
  static final _emailRegEx = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static bool isEmail(String input) => _emailRegEx.hasMatch(input);
}
