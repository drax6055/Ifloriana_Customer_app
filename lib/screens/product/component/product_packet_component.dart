import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../model/product_list_response.dart';

class ProductPacketComponent extends StatefulWidget {
  final ProductData productData;

  ProductPacketComponent({required this.productData});

  @override
  State<ProductPacketComponent> createState() => _ProductPacketComponentState();
}

class _ProductPacketComponentState extends State<ProductPacketComponent> {
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
  Widget build(BuildContext context) {
    if (widget.productData.hasVariation != 0)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewAllLabel(label: locale.productSize, isShowAll: false).paddingSymmetric(horizontal: 16),
          HorizontalList(
            wrapAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 16,
            itemCount: widget.productData.variationData.validate().length,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              VariationData variationData = widget.productData.variationData.validate()[index];

              return Observer(builder: (context) {
                return InkWell(
                  borderRadius: radius(),
                  onTap: () {
                    productStore.setSelectedVariationData(variationData);
                    productStore.setProductQuantity(DEFAULT_QUANTITY);
                    variationData.taxIncludeProductPrice = productStore.selectedVariationData.taxIncludeProductPrice;

                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: boxDecorationDefault(color: productStore.selectedVariationData.id == variationData.id ? indicatorColor : context.cardColor),
                    child: AnimatedWrap(
                      itemCount: variationData.combination.validate().length,
                      itemBuilder: (context, index) {
                        ProductCombinationData combinationData = variationData.combination.validate()[index];
                        return Text(
                          combinationData.productVariationName.validate(),
                          style: boldTextStyle(color: productStore.selectedVariationData.id == variationData.id ? Colors.black : textSecondaryColorGlobal, size: 12),
                        );
                      },
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ).paddingBottom(16);
    else
      return Offstage();
  }
}
