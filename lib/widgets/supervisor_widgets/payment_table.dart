import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../styles/app_text_styles.dart';

class PaymentTable extends StatelessWidget {
  const PaymentTable({required this.mediaQuery, required this.data, super.key});
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
            ],
          ),
          SizedBox(
            height: mediaQuery.height / 80,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            columnWidths: const {
              0: FlexColumnWidth(20),
              1: FlexColumnWidth(6),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.height / 70),
                      child: Text(
                        LocaleKeys.StudentName.tr(),
                        style: AppTextStyles.miniTitle,
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.height / 70),
                      child: Text(
                        LocaleKeys.haveToPay.tr(),
                        style: AppTextStyles.miniTitle,
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
                            EdgeInsets.only(bottom: mediaQuery.height / 50),
                        child: Text(data['info'][i]['name'].toString()),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: mediaQuery.height / 50),
                        child: Text(
                          '\$${data['info'][i]['haveToPay'].toStringAsFixed(2)}',
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
