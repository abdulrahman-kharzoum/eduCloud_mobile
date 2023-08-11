import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/common_button.dart';
import '../../styles/app_text_styles.dart';

class TripTable extends StatefulWidget {
  TripTable(
      {required this.title,
      required this.mediaQuery,
      required this.button_text,
      required this.data,
      required this.icon,
      this.icon2,
      super.key});
  final Size mediaQuery;
  final String title;
  final String button_text;
  Icon icon;
  final Icon? icon2;
  final Map<String, dynamic> data;

  @override
  State<TripTable> createState() => _TripTableState();
}

class _TripTableState extends State<TripTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.mediaQuery.width / 20,
          vertical: widget.mediaQuery.height / 40),
      margin: EdgeInsets.only(
          top: widget.mediaQuery.height / 20,
          left: widget.mediaQuery.width / 30,
          right: widget.mediaQuery.width / 30),
      width: double.infinity,
      height: widget.mediaQuery.height / 1.2,
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
                widget.title,
                style: AppTextStyles.poppinsTitle1,
              ),
            ],
          ),
          SizedBox(
            height: widget.mediaQuery.height / 80,
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
                          vertical: widget.mediaQuery.height / 70),
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
                          vertical: widget.mediaQuery.height / 70),
                      child: Text(
                        LocaleKeys.didGetIn.tr(),
                        style: AppTextStyles.miniTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              for (int i = 0; i < widget.data['info'].length; i++)
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: widget.mediaQuery.height / 50),
                        child: Text(widget.data['info'][i]['name'].toString()),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                          padding: EdgeInsets.only(
                              bottom: widget.mediaQuery.height / 50),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    if (widget.icon.icon ==
                                        Icons.check_circle_rounded) {
                                      widget.icon = Icon(
                                        Icons.circle,
                                        size: 30,
                                        color: AppColors.grey2Color,
                                      );
                                    } else {
                                      widget.icon = Icon(
                                        Icons.check_circle_rounded,
                                        size: 30,
                                        color: Colors.green,
                                      );
                                    }
                                    setState(() {});
                                  },
                                  child: widget.icon),
                              SizedBox(
                                width: 10,
                              ),
                              widget.icon2 != null ? widget.icon2! : SizedBox(),
                            ],
                          )),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: widget.mediaQuery.height / 3.1),
          Common_Button(
            text: widget.button_text,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
