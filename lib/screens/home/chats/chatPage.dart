import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/screens/home/myTrips/poolerInfo.dart';

import 'package:go_pool/theme/colors.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatelessWidget {
  //final double iconSize = 10;
  final double iconSize = 1.3.h;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Text(
          "Ride on 25 Jun, 10:30 am",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 12.5.sp),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.5.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripPoolerInfo(
                            "assets/profiles/img2.png", "Samantha Smith")));
              },
              child: Icon(
                Icons.info,
                size: 2.2.h,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: backgroundColor,
              margin: EdgeInsets.only(top: 1.4.h),
              padding: EdgeInsets.symmetric(horizontal: 5.5.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: .65.h, vertical: .65.h),
                        width: 6.4.h,
                        height: 6.4.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.asset("assets/profiles/img1.png"),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.3.w),
                        height: 1.9.h,
                        width: 4.5.h,
                        decoration: BoxDecoration(
                            color: Colors.green[500],
                            borderRadius: BorderRadius.circular(1.h)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: iconSize,
                              color: Colors.amber,
                            ),
                            Text(
                              "4.5",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 6.5.sp),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  FadedSlideAnimation(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1.3.h),
                      width: MediaQuery.of(context).size.width * 0.68,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Samantha Smith",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 11.7.sp),
                              ),
                              Spacer(),
                              Text(
                                "\$3.50",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 11.7.sp),
                              )
                            ],
                          ),
                          SizedBox(
                            height: .9.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.verified_user,
                                size: iconSize,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 1.3.w,
                              ),
                              Text(
                                "Bank of USA",
                                style: TextStyle(fontSize: 8.3.sp),
                              ),
                              Spacer(),
                              Text(
                                "1 " + locale.seat!,
                                style: TextStyle(fontSize: 8.3.sp),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 4.h,
                          // ),
                          // Container(
                          //   height: 5,
                          //   color: Colors.amber,
                          // )
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
            FadedSlideAnimation(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.5.h),
                        topRight: Radius.circular(2.5.h))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 2.6.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 4.2.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.9.h, vertical: 1.3.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xffebf3f9),
                                    borderRadius: BorderRadius.circular(2.5.h),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        locale.helloSir!,
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(fontSize: 11.2.sp),
                                      ),
                                      SizedBox(
                                        height: .65.h,
                                      ),
                                      Text("20 min",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 8.3.sp,
                                                  color: Color(0xffcccccc)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.6.h,
                            ),

                            //   Continue from here
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Container(
                                margin: EdgeInsets.only(right: 4.2.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.9.h, vertical: 1.3.h),
                                decoration: BoxDecoration(
                                  color: Color(0xfff8f9fd),
                                  borderRadius: BorderRadius.circular(2.5.h),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      locale.iwillBe!,
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 11.2.sp,
                                              color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: .65.h,
                                    ),
                                    Text("20 min",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 8.3.sp,
                                                color: Color(0xffcccccc)))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.6.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 4.2.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.9.h, vertical: 1.3.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xffebf3f9),
                                    borderRadius: BorderRadius.circular(2.5.h),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(locale.noWorries!,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(fontSize: 11.2.sp)),
                                          SizedBox(
                                            height: .65.h,
                                          ),
                                          Text("20 min",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontSize: 8.3.sp,
                                                      color: Color(0xffcccccc)))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 80,
                            // ),
                            // Container(
                            //   height: 5.h,
                            //   color: Colors.amber,
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              beginOffset: Offset(0, 0.4),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.9.h, vertical: 1.3.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.3.h, horizontal: 2.5.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.h),
                          color: Color(0xfff8f9fd)),
                      child: TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: locale.writeyourMessage,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 11.2.sp, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.65.w,
                  ),
                  Container(
                    height: 6.4.h,
                    width: 6.4.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.h),
                        color: primaryColor),
                    child: Center(
                      child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 2.8.h,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
