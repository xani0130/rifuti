import 'dart:io';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/screens/home/myTrips/Completed.dart';
import 'package:go_pool/screens/home/myTrips/poolerInfo.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';

class MyTrips extends StatefulWidget {
  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredBanner?.dispose();
  }

  final List imgs = [
    "assets/profiles/img1.png",
    "assets/profiles/img2.png",
    "assets/profiles/img3.png",
    "assets/profiles/img4.png",
    "assets/profiles/img5.png"
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Builder(
      builder: (BuildContext context) {
        if (!_loadingAnchoredBanner) {
          _loadingAnchoredBanner = true;
          _createAnchoredBanner(context);
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              title: Center(
                child: Text(
                  locale.myTrips!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.history,
                      color: Colors.grey[300],
                      size: 2.h,
                    ),
                    onPressed: () {}),
              ],
              bottom: TabBar(
                indicatorWeight: 4.0,
                indicatorSize: TabBarIndicatorSize.label,
                // labelPadding: EdgeInsets.only(left: 8, right: 8),
                tabAlignment: TabAlignment.center,

                tabs: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 5.5.w, right: 5.5.w), // Adjust the right padding
                    child: Text('Offering'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 5.5.w, right: 5.5.w), // Adjust the left padding
                    child: Text('Finding'),
                  ),
                ],
                isScrollable: true,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 18.2.sp),

                labelColor: primaryColor,
                indicatorColor: primaryColor,
                unselectedLabelColor: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            body: TabBarView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      //  color: Colors.red,
                      borderRadius: BorderRadius.circular(2.h)),
                  child: FadedSlideAnimation(
                    child: Column(
                      children: [
                        if (_anchoredBanner != null)
                          Container(
                            width: _anchoredBanner!.size.width.toDouble(),
                            height: _anchoredBanner!.size.height.toDouble(),
                            child: AdWidget(ad: _anchoredBanner!),
                          ),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(top: 1.4.h, bottom: 1.4.h),
                            itemCount: 7,
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TripPoolerInfo(
                                                    imgs[0],
                                                    "Sam Smith",
                                                    index % 2 == 0
                                                        ? true
                                                        : false)));
                                  },
                                  child: Container(
                                    height: 14.h,
                                    color: Colors.white,
                                    child: Stack(
                                      children: [
                                        ListTile(
                                          isThreeLine: true,
                                          tileColor: Colors.white,
                                          title: Text("${index + 1}:31 am",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(fontSize: 11.2.sp)),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  // Icon(
                                                  //   Icons.drive_eta,
                                                  //   size: 13,
                                                  //   color: Colors.grey[300],
                                                  // ),
                                                  // SizedBox(
                                                  //   width: 5,
                                                  // ),
                                                  Text("23 March, 2021",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 8.3.sp))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.w),
                                                    child: Icon(
                                                      Icons.circle,
                                                      color: primaryColor,
                                                      size: .7.h,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2.5.w,
                                                  ),
                                                  Text(
                                                      "Hamilton Bridge, New York",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  8.3.sp)),
                                                  // SizedBox(
                                                  //   width: 180,
                                                  // ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: .5.w),
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.grey[400],
                                                  size: 1.3.h,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.red,
                                                    size: 1.5.h,
                                                  ),
                                                  SizedBox(
                                                    width: 2.5.w,
                                                  ),
                                                  Text("Trade Bridge, New York",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  8.3.sp)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Padding(
                                            padding: EdgeInsets.all(.8.h),
                                            //size not dynamic
                                            child: CircleAvatar(
                                              child: Image.asset(
                                                'assets/profiles/img1.png',
                                                height: 45,
                                                width: 80,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 3.w,
                                          bottom: .5.h,
                                          child: Container(
                                            //  color: Colors.red,
                                            width: 10.h,
                                            height: 3.8.h,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Add your button click logic here
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    primaryColor, // Set the button color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(1.2
                                                          .h), // Set the border radius to zero for a sharp rectangle
                                                ),
                                              ),
                                              child: Text(
                                                'Not Started',
                                                style: TextStyle(
                                                    fontSize: 6.5.sp,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                    beginOffset: Offset(0.4, 0),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(2.h)),
                  child: FadedSlideAnimation(
                    child: Column(
                      children: [
                        if (_anchoredBanner != null)
                          Container(
                            width: _anchoredBanner!.size.width.toDouble(),
                            height: _anchoredBanner!.size.height.toDouble(),
                            child: AdWidget(ad: _anchoredBanner!),
                          ),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(top: 1.4.h, bottom: 1.4.h),
                            itemCount: 3,
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CompletedScreen(
                                                    imgs[0],
                                                    "Sam Smith",
                                                    index % 2 == 0
                                                        ? true
                                                        : false)));
                                  },
                                  child: Container(
                                    height: 14.h,
                                    color: Colors.white,
                                    child: Stack(
                                      children: [
                                        ListTile(
                                          isThreeLine: true,
                                          tileColor: Colors.white,
                                          title: Text("${index + 1}:30 am",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(fontSize: 11.2.sp)),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  // Icon(
                                                  //   Icons.drive_eta,
                                                  //   size: 13,
                                                  //   color: Colors.grey[300],
                                                  // ),
                                                  // SizedBox(
                                                  //   width: 5,
                                                  // ),
                                                  Text("23 March, 2021",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 8.3.sp))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.w),
                                                    child: Icon(
                                                      Icons.circle,
                                                      color: primaryColor,
                                                      size: .7.h,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2.5.w,
                                                  ),
                                                  Text(
                                                      "Hamilton Bridge, New York",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  8.3.sp)),
                                                  // SizedBox(
                                                  //   width: 180,
                                                  // ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: .5.w),
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.grey[400],
                                                  size: 1.3.h,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.red,
                                                    size: 1.5.h,
                                                  ),
                                                  SizedBox(
                                                    width: 2.5.w,
                                                  ),
                                                  Text("Trade Bridge, New York",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  8.3.sp)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Padding(
                                            padding: EdgeInsets.all(.8.h),
                                            child: CircleAvatar(
                                              child: Image.asset(
                                                'assets/profiles/img1.png',
                                                height: 45,
                                                width: 80,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 3.w,
                                          bottom: .5.h,
                                          child: Container(
                                            width: 10.h,
                                            height: 3.8.h,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Add your button click logic here
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    mainColor2, // Set the button color
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(1.2
                                                            .h) // Set the border radius to zero for a sharp rectangle
                                                    ),
                                              ),
                                              child: Text(
                                                'Completed',
                                                style: TextStyle(
                                                    fontSize: 6.5.sp,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                    beginOffset: Offset(0.4, 0),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
