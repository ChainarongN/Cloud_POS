import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Center menuTabTablet(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(Constants().screenheight(context) * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Constants().screenheight(context),
            width: Constants().screenWidth(context) * 0.15,
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: Constants().screenheight(context) * 0.015,
                children: List.generate(
                  menuWatch.prodGroupList!.length,
                  (index) => GestureDetector(
                    onTap: () {
                      menuRead.showMenuList(context, true,
                          prodGroupId:
                              menuWatch.prodGroupList![index].productGroupID!);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Constants().screenheight(context) * 0.1,
                      width: Constants().screenWidth(context) * 0.135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          colors:
                              menuWatch.prodGroupList![index].productGroupID ==
                                      menuWatch.getvalueMenuSelect
                                  ? [
                                      const Color.fromARGB(255, 113, 134, 255),
                                      const Color.fromARGB(255, 157, 198, 255),
                                    ]
                                  : [
                                      const Color(0xffffb157),
                                      const Color(0xffffa057),
                                    ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: menuWatch.prodGroupList![index]
                                          .productGroupID ==
                                      menuWatch.getvalueMenuSelect
                                  ? const Color.fromARGB(255, 157, 198, 255)
                                  : const Color(0xffffa057),
                              blurRadius: 8,
                              offset: const Offset(0, 6)),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                            Constants().screenheight(context) * 0.01),
                        child: AppTextStyle().textNormal(
                            menuWatch.prodGroupList![index].productGroupName!,
                            size: Constants().screenheight(context) * 0.025,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          VerticalDivider(thickness: 2, color: Colors.grey.shade300),
          Column(
            children: [
              SizedBox(
                width: Constants().screenWidth(context) * 0.46,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: Constants().screenheight(context) * 0.015,
                        top: Constants().screenheight(context) * 0.001),
                    child: Row(
                      children: List.generate(
                        menuWatch.prodDeptList!.length,
                        (index) => menuWatch
                                    .prodDeptList![index].productGroupID !=
                                menuWatch.getvalueMenuSelect
                            ? const SizedBox.shrink()
                            : GestureDetector(
                                onTap: () {
                                  menuRead.showMenuList(context, false,
                                      prodDeptId: menuWatch
                                          .prodDeptList![index].productDeptID);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height:
                                      Constants().screenheight(context) * 0.07,
                                  width:
                                      Constants().screenWidth(context) * 0.12,
                                  margin: EdgeInsets.only(
                                      right: Constants().screenheight(context) *
                                          0.007),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: LinearGradient(
                                      colors: menuWatch.prodDeptList![index]
                                                  .productDeptID ==
                                              menuWatch.getValueDept
                                          ? [
                                              const Color.fromARGB(
                                                  255, 113, 134, 255),
                                              const Color.fromARGB(
                                                  255, 157, 198, 255),
                                            ]
                                          : [
                                              const Color(0xffff5895),
                                              const Color(0xfff85560),
                                            ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: menuWatch.prodDeptList![index]
                                                      .productDeptID ==
                                                  menuWatch.getValueDept
                                              ? const Color.fromARGB(
                                                  255, 157, 198, 255)
                                              : const Color(0xfff85560),
                                          blurRadius: 8,
                                          offset: const Offset(0, 6)),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            Constants().screenheight(context) *
                                                0.007,
                                        right:
                                            Constants().screenheight(context) *
                                                0.007),
                                    child: AppTextStyle().textNormal(
                                        menuWatch.prodDeptList![index]
                                            .productDeptName!,
                                        size:
                                            Constants().screenheight(context) *
                                                0.023,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Constants().screenheight(context) * 0.66,
                width: Constants().screenWidth(context) * 0.46,
                child: GridView.builder(
                  itemCount: menuWatch.prodToShow!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.9,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        menuRead.addProductToList(context,
                            menuWatch.prodToShow![index].productID!, 1, '0');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            right: Constants().screenheight(context) * 0.015,
                            bottom: Constants().screenheight(context) * 0.015),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 225, 162, 242),
                              Color.fromARGB(255, 166, 151, 240),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 166, 151, 240),
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
            ],
          ),
        ],
      ),
    ),
  );
}
