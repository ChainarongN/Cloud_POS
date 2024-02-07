import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:cloud_pos/utils/widgets/container_style_2.dart';
import 'package:flutter/material.dart';

class UtilityPage extends StatefulWidget {
  const UtilityPage({super.key});

  @override
  State<UtilityPage> createState() => _UtilityPageState();
}

class _UtilityPageState extends State<UtilityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTextStyle().textNormal('Utility'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                runSpacing: 10,
                spacing: 20,
                children: <Widget>[
                  ContainerStyle2(
                    title: 'Session Close',
                    icon: Icons.android,
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.27,
                    shadowColor: Colors.deepOrange.shade300,
                    gradient1: Colors.deepOrange.shade100,
                    gradient2: Colors.deepOrange.shade200,
                    gradient3: Colors.deepOrange.shade400,
                    gradient4: Colors.deepOrange.shade400,
                    radius: 40,
                    onlyText: false,
                    size: 20,
                    onPressed: () {},
                  ),
                  ContainerStyle2(
                    title: 'End Day',
                    icon: Icons.android,
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.27,
                    shadowColor: Colors.red.shade400,
                    gradient1: Colors.red.shade200,
                    gradient2: Colors.red.shade300,
                    gradient3: Colors.red.shade500,
                    gradient4: Colors.red.shade500,
                    radius: 40,
                    onlyText: false,
                    size: 20,
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container titleBtn(BuildContext context,
      {String? title,
      IconData? icon,
      Color? shadowColor,
      Color? gradient1,
      Color? gradient2,
      Color? gradient3,
      Color? gradient4}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.27,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: shadowColor!,
              offset: const Offset(0, 20),
              blurRadius: 30,
              spreadRadius: -5,
            ),
          ],
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                gradient1!,
                gradient2!,
                gradient3!,
                gradient4!,
              ],
              stops: const [
                0.1,
                0.3,
                0.9,
                1.0
              ])),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.grey[100]),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: AppTextStyle()
                  .textBold(title!, size: 20, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
