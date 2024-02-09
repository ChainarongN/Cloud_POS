import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Center menuTab(
    BuildContext context, MenuProvider menuWatch, MenuProvider menuRead) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.155,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Wrap(
                  runSpacing: 15,
                  children: List.generate(
                    menuWatch.prodGroupList!.length,
                    (index) => GestureDetector(
                      onTap: () {
                        menuRead.setWhereMenu(menuWatch
                            .prodGroupList![index].productGroupID
                            .toString());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.135,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: menuWatch
                                        .prodGroupList![index].productGroupID ==
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
                          padding: const EdgeInsets.all(10),
                          child: AppTextStyle().textNormal(
                              menuWatch.prodGroupList![index].productGroupName!,
                              size: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          VerticalDivider(thickness: 2, color: Colors.grey.shade300),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GridView.builder(
                itemCount: menuWatch.prodToShow!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.9,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      menuRead.callProductObj(index);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
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
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: AppTextStyle().textNormal(
                            menuWatch.prodToShow![index].productName!,
                            size: 16,
                            color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
