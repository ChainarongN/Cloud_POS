import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Center discount(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(Constants().screenheight(context) * 0.006),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: Constants().screenheight(context) * 0.65,
                width: Constants().screenWidth(context),
                child: GridView.builder(
                  itemCount: menuWatch.prodToShow!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.9,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        menuRead.setSelectDiscount(
                            menuWatch.prodToShow![index].productID!);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            right: Constants().screenheight(context) * 0.015,
                            bottom: Constants().screenheight(context) * 0.015),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: menuWatch.getSelectDiscountList.contains(
                                    menuWatch.prodToShow![index].productID)
                                ? [
                                    const Color.fromARGB(255, 0, 97, 244),
                                    const Color.fromARGB(255, 36, 114, 159),
                                  ]
                                : [
                                    const Color.fromARGB(255, 113, 134, 255),
                                    const Color.fromARGB(255, 157, 198, 255),
                                  ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 157, 198, 255),
                                blurRadius: 8,
                                offset: Offset(0, 6)),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Constants().screenheight(context) * 0.015,
                              right: Constants().screenheight(context) * 0.015),
                          child: AppTextStyle().textNormal(
                              menuWatch.prodToShow![index].productName!,
                              size: Constants().screenheight(context) * 0.023,
                              color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Divider(thickness: 2),
            Row(
              children: [
                SizedBox(
                  height: Constants().screenheight(context) * 0.094,
                  width: Constants().screenWidth(context) * 0.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      side: const BorderSide(width: 2, color: Colors.white),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.discount,
                            size: Constants().screenheight(context) * 0.045,
                            color: Colors.white),
                        SizedBox(
                            width: Constants().screenheight(context) * 0.015),
                        AppTextStyle().textBold(
                            LocaleKeys.manage_promotion.tr(),
                            size: Constants().screenheight(context) * 0.025,
                            color: Colors.white)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Constants().screenheight(context) * 0.012),
                SizedBox(
                  height: Constants().screenheight(context) * 0.094,
                  width: Constants().screenWidth(context) * 0.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      side: const BorderSide(width: 2, color: Colors.white),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextStyle().textBold(
                            LocaleKeys.current_promotion.tr(),
                            size: Constants().screenheight(context) * 0.025,
                            color: Colors.white)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
