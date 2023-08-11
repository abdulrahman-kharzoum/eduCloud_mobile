import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../styles/app_text_styles.dart';

class PaymentTableStudent extends StatelessWidget {
  const PaymentTableStudent(
      {required this.mediaQuery, required this.data, super.key});
  final Size mediaQuery;

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width / 20, vertical: mediaQuery.height / 40),
      margin: EdgeInsets.only(
          top: mediaQuery.height / 10,
          left: mediaQuery.width / 30,
          right: mediaQuery.width / 30),
      width: double.infinity,
      height: mediaQuery.height / 1.2,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 0.01,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.lastPriceYouPaid.tr(),
                style: AppTextStyles.poppinsTitle1,
              ),
              Text(
                '${data['paied'].toString()} ',
                style: AppTextStyles.poppinsTitle,
              ),
            ],
          ),
          SizedBox(
            height: mediaQuery.height / 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.accumulatedAmount.tr(),
                style: AppTextStyles.poppinsTitle1,
              ),
              Text(
                '${data['info'].first['price'].toString()} ${LocaleKeys.spy.tr()}',
                style: AppTextStyles.poppinsTitle,
              ),
            ],
          ),
          SizedBox(
            height: mediaQuery.height / 80,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            columnWidths: const {
              0: FlexColumnWidth(8),
              1: FlexColumnWidth(6),
              2: FlexColumnWidth(6),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.height / 80),
                      child: Text(
                        LocaleKeys.receiptnumbers.tr(),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.height / 80),
                      child: Text(
                        LocaleKeys.date.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.height / 80),
                      child: Text(
                        LocaleKeys.price.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              for (int i = 0; i < data['info'].length; i++)
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: mediaQuery.height / 100),
                        child: Text(data['info'][i]['receipt'].toString()),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: mediaQuery.height / 100),
                        child: Text(
                          data['info'][i]['date'].toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: mediaQuery.height / 100),
                        child: Text(
                          "\$${data['info'][i]['price'].toStringAsFixed(1)}",
                          style: AppTextStyles.textTitleStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
