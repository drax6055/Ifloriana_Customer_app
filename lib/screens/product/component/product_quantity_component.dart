import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/view_all_label_component.dart';
import '../../../utils/constants.dart';

class ProductQuantityComponent extends StatefulWidget {
  @override
  _ProductQuantityComponentState createState() => _ProductQuantityComponentState();
}

class _ProductQuantityComponentState extends State<ProductQuantityComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool flag = false}) async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    productStore.setProductQuantity(DEFAULT_QUANTITY);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(label: locale.quantity, isShowAll: false).paddingSymmetric(horizontal: 16),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.rectangle),
          width: context.width() * 0.35,
          height: 40,
          child: Observer(builder: (context) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: ic_minus.iconImage(color: productStore.qty > 1 ? textPrimaryColorGlobal : textSecondaryColorGlobal, size: 15),
                  onPressed: () async {
                    if (productStore.qty > 1) {
                      productStore.qty--;
                    }
                    setState(() {});
                  },
                ),
                Text('${productStore.qty}', style: primaryTextStyle()),
                IconButton(
                  icon: ic_add.iconImage(color: productStore.qty < productStore.selectedVariationData.productStockQty.validate() ? textPrimaryColorGlobal : textSecondaryColorGlobal, size: 15),
                  onPressed: () async {
                    if (productStore.qty < productStore.selectedVariationData.productStockQty.validate()) {
                      productStore.qty++;
                    }
                    setState(() {});
                  },
                ),
              ],
            );
          }),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
