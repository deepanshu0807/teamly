import 'package:flutter/material.dart';
import 'package:flutter_utility/flutter_utility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_team/utils/utility.dart';

class TextInputFindOut extends StatelessWidget {
  const TextInputFindOut({
    required this.label,
    required this.iconData,
    this.textInputType = TextInputType.name,
    required this.controller,
  });
  final String label;
  final IconData iconData;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final isPassword = textInputType == TextInputType.visiblePassword;
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.grey[300]!,
        width: 2,
        style: BorderStyle.solid,
      ),
    );
    final hidePasswordNotifier = ValueNotifier(true);
    return ValueListenableBuilder(
        valueListenable: hidePasswordNotifier,
        builder: (context, value, child) {
          return TextField(
            keyboardType: textInputType,
            style: GoogleFonts.dmSerifDisplay(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
              decorationStyle: TextDecorationStyle.wavy,
            ),
            obscureText: isPassword,
            cursorColor: AppColors.primaryColor,
            cursorWidth: 2,
            decoration: InputDecoration(
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () => hidePasswordNotifier.value =
                          !hidePasswordNotifier.value,
                      icon: Icon(
                        (value as bool) //TODO
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[700],
                      ),
                    )
                  : null,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder.copyWith(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 2)),
              hintText: label,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              hintStyle: GoogleFonts.dmSerifDisplay(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                decorationStyle: TextDecorationStyle.wavy,
              ),
              prefixIcon:
                  Icon(iconData, color: AppColors.primaryColor, size: 18),
            ),
            controller: controller,
          );
          // return TextField(
          //   keyboardType: textInputType,
          //   obscureText: isPassword,
          //   style: text20.copyWith(fontSize: 20),
          //   decoration: InputDecoration(
          //     filled: true,
          //     fillColor: Colors.white,
          //     suffixIcon: isPassword
          //         ? IconButton(
          //             onPressed: () => hidePasswordNotifier.value =
          //                 !hidePasswordNotifier.value,
          //             icon: Icon(
          //               (value as bool) //TODO
          //                   ? Icons.visibility
          //                   : Icons.visibility_off,
          //               color: Colors.grey[700],
          //             ),
          //           )
          //         : null,
          //     enabledBorder: outlineInputBorder,
          //     hintText: label,
          //     focusedBorder: outlineInputBorder.copyWith(
          //         borderSide:
          //             BorderSide(color: AppColors.primaryColor, width: 2)),
          //     hintStyle: TextStyle(color: Colors.grey),
          //     prefixIcon:
          //         Icon(iconData, color: AppColors.primaryColor, size: 18),
          //   ),
          //   controller: controller,
          //   cursorColor: AppColors.primaryColor,
          // );
        });
  }
}
