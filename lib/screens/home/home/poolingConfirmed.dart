import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_pool/components/widgets/colorButton.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/screens/home/navigationHome.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:sizer/sizer.dart';

class PoolingConfirmed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.5.w),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            FadedScaleAnimation(
              child: Container(
                width: 26.h,
                child: Image.asset("assets/img_confirmed.png"),
              ),
              scaleDuration: const Duration(milliseconds: 600),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              locale.congrats!,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 16.7.sp),
            ),
            SizedBox(
              height: 1.2.h,
            ),
            Text(
              locale.yourCarConfirmed!,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationHome(1)));
                },
                child: FadedScaleAnimation(
                  child: ColorButton(locale.myTrips),
                  scaleDuration: const Duration(milliseconds: 600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
