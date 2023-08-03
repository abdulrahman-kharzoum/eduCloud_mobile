import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../translations/locale_keys.g.dart';

// ignore: camel_case_types
class installmentsTab extends StatelessWidget {
  const installmentsTab({
    super.key,
    required this.mediaQuery,
    required this.data,
  });
  final Size mediaQuery;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //this container has (total price , cricle percent , still have to pay)
        Container(
          height: mediaQuery.height / 4.5,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //this for total price
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['totalPrice'].toString(),
                    style: AppTextStyles.textTitleStyle1,
                  ),
                  SizedBox(
                    width: mediaQuery.width / 40,
                  ),
                  Text(
                    LocaleKeys.spy.tr(),
                    style: AppTextStyles.textTitleStyle1,
                  )
                ],
              ),
              Text(
                LocaleKeys.totalprice.tr(),
                style: AppTextStyles.miniTitle,
              ),
              SizedBox(
                height: mediaQuery.height / 120,
              ),
              CircularPercentIndicator(
                animation: true,
                animationDuration: 1000,
                radius: 34,
                lineWidth: 8,
                percent: (data['paied']) / data['totalPrice'],
                progressColor: AppColors.blueNormal,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '${((data['paied'] * 100) / data['totalPrice'])}%',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: mediaQuery.height / 120,
              ),
              //still have to pay
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['stillHaveToPay'].toString(),
                    style: AppTextStyles.textTitleStyle1,
                  ),
                  SizedBox(
                    width: mediaQuery.width / 40,
                  ),
                  Text(
                    LocaleKeys.spy.tr(),
                    style: AppTextStyles.textTitleStyle1,
                  )
                ],
              ),
              Text(
                LocaleKeys.stillhavetopay.tr(),
                style: AppTextStyles.miniTitle,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.width / 20,
              vertical: mediaQuery.height / 40),
          margin: EdgeInsets.only(
              top: mediaQuery.height / 30,
              left: mediaQuery.width / 30,
              right: mediaQuery.width / 30),
          width: double.infinity,
          height: mediaQuery.height / 2,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(243, 245, 247, 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.total.tr(),
                    style: AppTextStyles.poppinsTitle,
                  ),
                  Text(
                    '${data['paied'].toString()} ${LocaleKeys.spy.tr()}',
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
                    LocaleKeys.lastpriceyoupaied.tr(),
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
                  2: FlexColumnWidth(5),
                },
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height / 80),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            LocaleKeys.receiptnumbers.tr(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height / 80),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            LocaleKeys.date.tr(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height / 80),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
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
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: mediaQuery.height / 100),
                          child: TableCell(
                            child: Text(data['info'][i]['receipt'].toString()),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: mediaQuery.height / 100),
                          child: TableCell(
                            child: Text(
                              data['info'][i]['date'].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: mediaQuery.height / 100),
                          child: TableCell(
                            child: Text(
                              data['info'][i]['price'].toString(),
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
        ),
      ],
    );
  }
}
