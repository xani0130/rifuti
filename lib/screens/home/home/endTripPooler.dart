import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_pool/components/stars.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/screens/home/home/endTripPoolTaker.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:sizer/sizer.dart';

class EndTripPooler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        color: backgroundColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            FadedScaleAnimation(
              child: Container(
                width: 62.w,
                child: Image.asset("assets/img_tripcomplete.png"),
              ),
              scaleDuration: const Duration(milliseconds: 600),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(locale.tripCompleted!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 19.2.sp)),
            SizedBox(
              height: 1.2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locale.youHaveEarned!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12.5.sp,
                      ),
                ),
                SizedBox(
                  width: .22.w,
                ),
                Text(" \$34.50",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 12.5.sp, color: Colors.black))
              ],
            ),
            Text(locale.fromThisTrip!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 12.5.sp)),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EndTripPoolTaker()));
              },
              child: FadedSlideAnimation(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 36.h,
                  //      height: 280,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.5.h),
                          topRight: Radius.circular(2.5.h))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.7.h, vertical: 1.5.h),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(locale.rateRideTaker!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 11.2.sp,
                                            color: Color(0xffa3bccf))),
                                Text("Samantha Smith",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 14.2.sp))
                              ],
                            ),
                            Spacer(),
                            Container(
                              height: 7.6.h,
                              child: Image.asset("assets/profiles/img1.png"),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                        child: Stars(),
                      ),
                      Divider(
                        thickness: 7,
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.7.h, vertical: 1.5.h),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(locale.rateRideTaker!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 11.2.sp,
                                            color: Color(0xffa3bccf))),
                                Text("Peter Taylor",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 14.2.sp))
                              ],
                            ),
                            Spacer(),
                            Container(
                              height: 7.6.h,
                              child: Image.asset("assets/profiles/img4.png"),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                        child: Stars(),
                      ),
                    ],
                  ),
                ),
                beginOffset: Offset(0, 0.4),
                endOffset: Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
              ),
            )
          ],
        ),
      ),
    );
  }
}
