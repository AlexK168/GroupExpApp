class PassValidator {
  final bool onlyEmptyValidation;
  final int min;
  final int max;
  final int digits;
  final String specialChars;
  final int uppercase;
  final int lowercase;
  final int specialNum;
  final RegExp atLeastNDigits;
  final RegExp atLeastNUpperCase;
  final RegExp atLeastNLowerCase;
  final RegExp atLeastNSpecialChars;

  PassValidator({
    this.min = 8, this.max = 15, this.digits = 1,
    this.specialChars = "", this.uppercase = 1,
    this.lowercase = 1, this.specialNum = 1,
    this.onlyEmptyValidation = false,
    }) :
      atLeastNDigits = RegExp(r'(.*\d){' + digits.toString() + '}'),
      atLeastNSpecialChars = RegExp(r'(.*[' + specialChars + ']){' + specialNum.toString() + '}'),
      atLeastNUpperCase = RegExp(r'(.*[A-Z]){' + uppercase.toString() + '}'),
      atLeastNLowerCase = RegExp(r'(.*[a-z]){' + lowercase.toString() + '}');

  String validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (onlyEmptyValidation) {
      return "";
    }
    if (!atLeastNLowerCase.hasMatch(value)) {
      return 'Password has to contain at least $lowercase lower case letters';
    } else
    if (!atLeastNUpperCase.hasMatch(value)) {
      return 'Password has to contain at least $uppercase upper case letters';
    } else
    if (!atLeastNDigits.hasMatch(value)) {
      return 'Password has to contain at least $digits digits';
    } else
    if (!atLeastNSpecialChars.hasMatch(value)) {
      return 'Password has to contain at least $specialNum special characters';
    } else
    if (value.length < min || value.length > max) {
      return 'Password has to be $min-$max characters long';
    }
    return "";
  }
}