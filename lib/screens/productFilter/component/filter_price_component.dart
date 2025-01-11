import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/price_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../utils/constants.dart';

class FilterPriceComponent extends StatefulWidget {
  @override
  _FilterPriceComponentState createState() => _FilterPriceComponentState();
}

class _FilterPriceComponentState extends State<FilterPriceComponent> {
  late RangeValues rangeValues;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //TODO: UnComment When Create Filter Store
    /*if (filterStore.isPriceMax.isNotEmpty && filterStore.isPriceMin.isNotEmpty) {
      rangeValues = RangeValues(filterStore.isPriceMin.toDouble(), filterStore.isPriceMax.toDouble());
    } else {
      rangeValues = RangeValues(1, 5000);
    }*/

    rangeValues = RangeValues(1, 5000);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ViewAllLabel(label: locale.price, labelTextStyle: boldTextStyle(), isShowAll: false).paddingSymmetric(horizontal: 16),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(valueIndicatorColor: lightPrimaryColor),
          child: RangeSlider(
            min: 1,
            max: 5000,
            divisions: (5000 ~/ 10).toInt(),
            labels: RangeLabels(rangeValues.start.toInt().toString(), rangeValues.end.toInt().toString()),
            values: rangeValues,
            onChanged: (values) {
              rangeValues = values;
              /*filterStore.setMaxPrice(values.end.toInt().toString());
              filterStore.setMinPrice(values.start.toInt().toString());*/
              setState(() {});
            },
          ).withHeight(30),
        ),
        6.height,
        Marquee(
          child: Row(
            children: [
              Text("[ ", style: primaryTextStyle()),
              PriceWidget(
                price: rangeValues.start.toInt(),
                isBoldText: false,
                color: primaryColor,
                decimalPoint: 0,
                seperator: ConfigurationKeyConst.THOUSAND_SEPARATOR,
              ),
              Text(" - ", style: primaryTextStyle()),
              PriceWidget(
                price: rangeValues.end.toInt(),
                isBoldText: false,
                color: primaryColor,
                decimalPoint: 0,
                seperator: ConfigurationKeyConst.THOUSAND_SEPARATOR,
              ),
              Text(" ]", style: primaryTextStyle()),
            ],
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
