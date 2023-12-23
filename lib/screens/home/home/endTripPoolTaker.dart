import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_pool/components/stars.dart';
import 'package:go_pool/components/widgets/colorButton.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/screens/home/navigationHome.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:sizer/sizer.dart';

class EndTripPoolTaker extends StatefulWidget {
  @override
  _EndTripPoolTakerState createState() => _EndTripPoolTakerState();
}

class _EndTripPoolTakerState extends State<EndTripPoolTaker> {
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
                width: 61.w,
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
                    .copyWith(fontSize: 18.5.sp)),
            SizedBox(
              height: 1.3.h,
            ),
            Text(
              locale.hopeYouHad!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12.5.sp,
                  ),
            ),
            Spacer(),
            FadedSlideAnimation(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 35.h,
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
                          horizontal: 5.5.w, vertical: 1.3.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locale.rateRider!,
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
                                      .copyWith(fontSize: 14.sp))
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 7.5.h,
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
                          horizontal: 5.5.w, vertical: 1.3.h),
                      child: Row(
                        children: [
                          Text(locale.amountToPay!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 11.2.sp,
                                      color: Color(0xffa3bccf))),
                          Spacer(),
                          Text("\$24.00",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 16.sp))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.5.w),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavigationHome()));
                          },
                          child: FadedScaleAnimation(
                            child: ColorButton(locale.submitPay),
                            scaleDuration: const Duration(milliseconds: 600),
                          )),
                    )
                  ],
                ),
              ),
              beginOffset: Offset(0, 0.4),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            )
          ],
        ),
      ),
    );
  }
}
