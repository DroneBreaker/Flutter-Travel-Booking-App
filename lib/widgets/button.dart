import 'package:flutter/material.dart';
import 'package:tripmania/widgets/app-text.dart';

class Button extends StatelessWidget {
  bool? isResponsive;
  double? width;

  Button({Key? key, this.isResponsive = false, this.width = 120})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: isResponsive == true ? double.maxFinite : width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF5d69b3),
        ),
        child: Row(
          mainAxisAlignment: isResponsive == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            isResponsive == true
                ? Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: AppText(text: "Book Trip Now", color: Colors.white))
                : Container(),
            Image.asset("img/button-one.png")
          ],
        ),
      ),
    );
  }
}
