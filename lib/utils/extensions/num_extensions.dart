import 'package:nb_utils/nb_utils.dart';

import '../../components/price_widget.dart';
import '../constants.dart';

extension numExt on num {
  String toPriceFormat() {
    return '${leftCurrencyFormat()}${this.toStringAsFixed(getIntAsync(ConfigurationKeyConst.NO_OF_DECIMAL, defaultValue: DECIMAL_POINT)).formatNumberWithComma(seperator: getStringAsync(ConfigurationKeyConst.DECIMAL_SEPARATOR))}${rightCurrencyFormat()}';
  }
}
