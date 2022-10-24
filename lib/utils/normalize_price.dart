import 'package:basic_utils/basic_utils.dart';

String normalizePrice(int value) {
  String price = value.toString();
  if (price.length == 2) {
    price = StringUtils.addCharAtPosition(price, '0', 0);
  }
  if (price.length == 1) {
    price = StringUtils.addCharAtPosition(price, '00', 0);
  }
  price = StringUtils.addCharAtPosition(price, '.', price.length - 2);
  return price;
}