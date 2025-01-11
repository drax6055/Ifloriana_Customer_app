import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/price_widget.dart';
import '../constants.dart';

extension numExt on num {
  String toPriceFormat() {
    final decimalPoint = getIntAsync(ConfigurationKeyConst.NO_OF_DECIMAL, defaultValue: DECIMAL_POINT);
    // set the separator according to need
    final separator = getStringAsync(ConfigurationKeyConst.THOUSAND_SEPARATOR);
    final locale = 'en_US'; // Change this if you need different locale formatting

    // Using NumberFormat to handle both thousand separator and decimal places
    final formatter = NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalPoint,
      symbol: '', // Exclude default currency symbol
    );

    // Formatting the number with custom separator if needed
    String formattedPrice = formatter.format(this);

    // If you need a custom separator instead of the locale default, replace it
    if (separator != ',') {
      formattedPrice = formattedPrice.replaceAll(',', separator);
    }

    // Add the left and right currency formats
    return '${leftCurrencyFormat()}$formattedPrice${rightCurrencyFormat()}';
  }
}


// extension numExt on num {
//   String toPriceFormat() {
//     return '${leftCurrencyFormat()}${this.toStringAsFixed(getIntAsync(ConfigurationKeyConst.NO_OF_DECIMAL, defaultValue: DECIMAL_POINT)).formatNumberWithComma(seperator: getStringAsync(ConfigurationKeyConst.DECIMAL_SEPARATOR))}${rightCurrencyFormat()}';
//   }
// }