import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/screens/home/home/poolerInfo.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:sizer/sizer.dart';

class RideProviders extends StatelessWidget {
  final bool isFindPool;
  RideProviders(this.isFindPool);
  final double iconSize = 10;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    List imgs = [
      "assets/profiles/img1.png",
      "assets/profiles/img2.png",
      "assets/profiles/img3.png",
      "assets/profiles/img4.png",
      "assets/profiles/img1.png",
      "assets/profiles/img2.png",
      "assets/profiles/img3.png",
      "assets/profiles/img4.png",
    ];
    List names = [
      "George Anderson",
      "Emili Williamson",
      "Mark Taylor",
      "Lisa Davis",
      "Deneil Haydon",
      "George Anderson",
      "Emili Williamson",
      "Mark Taylor",
    ];
    List from = [
      "Bank of USA",
      "Harvard law school",
      "Creative Graphics",
      "INFC Corporation",
      "TLPS Accounts",
      "Bank of USA",
      "Harvard law school",
      "Creative Graphics",
    ];
    List price = [
      "\$3.50",
      "\$2.50",
      "\$4.50",
      "\$3.80",
      "\$3.90",
      "\$3.50",
      "\$2.50",
      "\$4.50",
    ];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          isFindPool
              ? locale!.poolers! + " on 25 Mar, 10:30 am"
              : locale!.pooltaker! + " on 25 Mar, 10:30 am",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.5.h),
                topRight: Radius.circular(2.5.h))),
        child: FadedSlideAnimation(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 1.4.h, bottom: 1.4.h),
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                //here also change required in the navigated screen

                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PoolerInfoPage(
                              imgs[index], names[index], isFindPool)));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.8.w, vertical: 1.2.h),
                  margin:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: .65.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.h),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: .65.h, vertical: .65.h),
                            width: 6.5.h,
                            height: 6.5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.h)),
                            child: Image.asset(imgs[index]),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 1.2.w),
                            height: 2.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(2.5.h)),
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
                      SizedBox(
                        width: 2.1.w,
                      ),
                      // Spacer(),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: .65.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  names[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 11.2.sp),
                                ),
                                Spacer(),
                                Text(
                                  price[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 11.2.sp),
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
                                  width: 1.5.w,
                                ),
                                Text(
                                  from[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 8.3.sp,
                                          color: Color(0xffa8aeb2)),
                                ),
                                Spacer(),
                                Text(
                                  "1 seat",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 8.3.sp),
                                )
                                // Row(
                                //   children: [
                                //     Icon(
                                //       index == 2
                                //           ? Icons.directions_bike
                                //           : Icons.drive_eta,
                                //       size: iconSize,
                                //       color: Colors.grey[300],
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 3),
                                //       child: Icon(
                                //         Icons.circle,
                                //         size: 3,
                                //         color: Colors.grey[300],
                                //       ),
                                //     ),
                                //     index != 2
                                //         ? Icon(
                                //             Icons.account_circle,
                                //             size: iconSize,
                                //             color: Colors.grey[300],
                                //           )
                                //         : SizedBox.shrink(),
                                //     Icon(
                                //       Icons.account_circle,
                                //       size: iconSize,
                                //       color: Colors.grey[300],
                                //     ),
                                //     Icon(
                                //       Icons.account_circle,
                                //       size: iconSize,
                                //       color: Colors.grey[300],
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                            SizedBox(
                              height: .9.h,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1.w),
                                      child: Icon(
                                        Icons.circle,
                                        color: primaryColor,
                                        size: .8.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text("Hamilton Bridge, New York",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(fontSize: 8.4.sp)),
                                    // SizedBox(
                                    //   width: 180,
                                    // ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: .4.w,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Icon(
                                          Icons.more_vert,
                                          color: Colors.grey[400],
                                          size: 1.3.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 1.55.h,
                                    ),
                                    SizedBox(
                                      width: 3.2.w,
                                    ),
                                    Text("Trade Bridge, New York",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(fontSize: 8.4.sp)),
                                  ],
                                ),
                                //     Row(
                                //       children: [
                                //         Icon(
                                //           Icons.directions_run,
                                //           size: iconSize,
                                //           color: Colors.grey[300],
                                //         ),
                                //         Icon(
                                //           Icons.chevron_right,
                                //           size: iconSize,
                                //           color: Colors.grey[300],
                                //         ),
                                //         Icon(
                                //           Icons.drive_eta,
                                //           size: iconSize,
                                //           color: Colors.grey[300],
                                //         ),
                                //         SizedBox(
                                //           width: 5,
                                //         ),
                                //         Text(
                                //           "520m",
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .bodyLarge!
                                //               .copyWith(
                                //                   fontSize: 10,
                                //                   color: primaryColor),
                                //         ),
                                //         SizedBox(
                                //           width: 5,
                                //         ),
                                //         Padding(
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 4),
                                //           child: Icon(
                                //             Icons.circle,
                                //             size: 4,
                                //             color: Colors.grey[300],
                                //           ),
                                //         ),
                                //         SizedBox(
                                //           width: 5,
                                //         ),
                                //         Expanded(
                                //           child: Text(
                                //             "Hemiltone Bridge",
                                //             style: TextStyle(
                                //                 color: Colors.black, fontSize: 10),
                                //           ),
                                //         ),
                                //         // Spacer(),
                                //         Text(
                                //           "9.58 am",
                                //           style: TextStyle(
                                //               color: Colors.black, fontSize: 10),
                                //         )
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         SizedBox(
                                //           width: MediaQuery.of(context).size.width *
                                //               0.194,
                                //         ),
                                //         Icon(
                                //           Icons.more_vert,
                                //           size: iconSize,
                                //           color: Colors.grey[300],
                                //         ),
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         Icon(
                                //           Icons.drive_eta,
                                //           size: iconSize,
                                //           color: Colors.grey[300],
                                //         ),
                                //         Icon(
                                //           Icons.chevron_right,
                                //           size: iconSize,
                                //           color: Colors.grey[300],
                                //         ),
                                //         Icon(
                                //           Icons.directions_run,
                                //           size: iconSize,
                                //           color: Colors.grey[300],
                                //         ),
                                //         SizedBox(
                                //           width: 5,
                                //         ),
                                //         Text(
                                //           "380m",
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .bodyLarge!
                                //               .copyWith(
                                //                   fontSize: 10,
                                //                   color: primaryColor),
                                //         ),
                                //         SizedBox(
                                //           width: 5,
                                //         ),
                                //         Icon(
                                //           Icons.keyboard_arrow_down,
                                //           size: iconSize,
                                //           color: Colors.grey[300],
                                //         ),
                                //         SizedBox(
                                //           width: 5,
                                //         ),
                                //         Expanded(
                                //           child: Text(
                                //             "World Trade Point",
                                //             style: TextStyle(
                                //                 color: Colors.black, fontSize: 10),
                                //             overflow: TextOverflow.ellipsis,
                                //           ),
                                //         ),
                                //         // Spacer(),
                                //         Text(
                                //           "10.35 am",
                                //           style: TextStyle(
                                //               color: Colors.black, fontSize: 10),
                                //         )
                                //       ],
                                //     ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          beginOffset: Offset(0.4, 0),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
