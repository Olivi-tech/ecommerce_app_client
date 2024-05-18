import 'package:flutter/material.dart';
import 'package:shop_app/Widgets/call_back_function.dart';
import 'package:shop_app/Widgets/custom_text_field.dart';
import 'package:shop_app/constants/app_colors.dart';

class CustomAppBar extends StatefulWidget {
  final TextEditingController? controller;
  final SearchCallbackFunc? setSearchValue;
  final String? text;
  const CustomAppBar(
      {Key? key, this.controller, this.setSearchValue, this.text})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: height * 0.08,
          width: width * 0.75,
          child: ValueListenableBuilder(
            valueListenable: widget.controller!,
            builder: (context, value, child) => CustomTextField(
              controller: widget.controller,
              onChanged: (query) {
                widget.setSearchValue!(widget.controller!.text);
              },
              fillColor: AppColors.white,
              isFilled: true,
              hintText: widget.text,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.darkGrey,
              ),
              suffixIcon: widget.controller!.text.isEmpty
                  ? const Icon(Icons.search)
                  : GestureDetector(
                      onTap: () {
                        widget.controller!.clear();
                        widget.setSearchValue!(widget.controller!.text);
                      },
                      child: const Icon(
                        Icons.close,
                        color: AppColors.darkGrey,
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }
}
