import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/cart/components/custom_text.dart';

class CustomButton extends StatelessWidget {
  final bool isSocial;
  final bool isSvgImage;
  final String? socialText;
  final Color? socialTextColor;
  final double? socialTextSize;
  final FontWeight? socialTextWeight;
  final String? imagePath;
  final VoidCallback onPressed;
  final String? btnText;
  final double? textSize;
  final LinearGradient? socialGradient;
  final Color? socialWhiteBg;
  final bool isSocialWhiteBg;
  final Color? backgroundColor;
  final Color borderColor;
  final bool isRounded;
  final LinearGradient? gradient;
  final Color? textColor;
  final double fixedHeight;
  final double? fixedWidth;
  final FontWeight? weight;
  final bool loading;
  const CustomButton({
    super.key,
    required this.onPressed,
    this.btnText,
    this.textSize,
    this.gradient,
    this.backgroundColor,
    this.textColor,
    this.borderColor = Colors.transparent,
    this.fixedHeight = 50,
    this.loading = false,
    this.isSvgImage = true,
    this.weight,
    this.isSocial = false,
    this.socialText,
    this.imagePath,
    this.socialTextColor,
    this.socialTextSize,
    this.socialTextWeight,
    this.socialGradient,
    this.socialWhiteBg,
    this.isSocialWhiteBg = false,
    this.isRounded = true,
    this.fixedWidth,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: fixedHeight,
        width: fixedWidth,
        decoration: ShapeDecoration(
          color:
              isSocialWhiteBg ? socialWhiteBg ?? Colors.white : backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: isRounded
                  ? BorderRadius.circular(14)
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
              side: BorderSide(color: borderColor, width: 1)),
        ),
        child: Container(
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: isSocial ? gradient : gradient,
              borderRadius: isRounded
                  ? BorderRadius.circular(45)
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
          child: loading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : isSocial
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25,
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: isSvgImage
                                ? SvgPicture.asset(
                                    '$imagePath',
                                  )
                                : Image.asset("$imagePath"),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        CustomText(
                          title: '$socialText',
                          size: socialTextSize,
                          color: socialTextColor,
                          weight: socialTextWeight,
                        )
                      ],
                    )
                  : loading
                      ? const CupertinoActivityIndicator()
                      : Text(
                          '$btnText',
                          style: TextStyle(
                            fontSize: textSize,
                            color: textColor,
                            fontWeight: weight,
                          ),
                        ),
        ),
      ),
    );
  }
}
