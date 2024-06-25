import 'package:cloud_pos/translations/locale_key.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          bottom: Constants().screenheight(context) * 0.02,
        ),
        width: Constants().screenWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Constants.primaryColor.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: TextField(
          onTap: () {
            Navigator.pushNamed(context, '/searchDetailPage');
          },
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Constants.primaryColor.withOpacity(0.3),
            hintText: LocaleKeys.search.tr(),
            border: Constants().myinputborder(),
            enabledBorder: Constants().myinputborder(),
            focusedBorder: Constants().myfocusborder(),
            contentPadding: const EdgeInsets.only(left: 40),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(left: 10, right: 35),
              child: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
