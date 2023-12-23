import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_pool/OrderMapBloc/order_map_bloc.dart';
import 'package:go_pool/OrderMapBloc/order_map_state.dart';
import 'package:go_pool/components/widgets/colorButton.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/map_utils.dart';
import 'package:go_pool/screens/home/chats/chatPage.dart';
import 'package:go_pool/screens/home/home/endTripPoolTaker.dart';
import 'package:go_pool/screens/home/home/endTripPooler.dart';

import 'package:go_pool/theme/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class TripPoolerInfo extends StatelessWidget {
  final String img;
  final String name;
  final bool tripPool;

  TripPoolerInfo(this.img, this.name, [this.tripPool = false]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderMapBloc>(
      create: (context) => OrderMapBloc()..loadMap(),
      child: TripPoolerInfoBody(img, name, tripPool),
    );
  }
}

class TripPoolerInfoBody extends StatefulWidget {
  final String img;
  final String name;
  final bool tripPool;

  TripPoolerInfoBody(this.img, this.name, [this.tripPool = false]);

  @override
  _TripPoolerInfoBodyState createState() => _TripPoolerInfoBodyState();
}

class _TripPoolerInfoBodyState extends State<TripPoolerInfoBody> {
  bool riideRoute = false;
  bool poolerDetails = false;
  late bool tripPoolinfo;
  //double iconSize = 10;
  double iconSize = 1.3.h;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapStyleController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    tripPoolinfo = widget.tripPool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<OrderMapBloc, OrderMapState>(
                builder: (context, state) {
              print('polyyyy' + state.polylines.toString());
              return GoogleMap(
                polylines: state.polylines,
                mapType: MapType.normal,
                initialCameraPosition: kGooglePlex,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) async {
                  _mapController.complete(controller);
                  mapStyleController = controller;
                  mapStyleController!.setMapStyle(mapStyle);
                  setState(() {
                    _markers.add(
                      Marker(
                        markerId: MarkerId('mark1'),
                        position: LatLng(37.42796133580664, -122.085749655962),
                        icon: markerss.first,
                      ),
                    );
                    _markers.add(
                      Marker(
                        markerId: MarkerId('mark2'),
                        position: LatLng(37.42496133180663, -122.081743655960),
                        //  icon: markerss[1],
                      ),
                    );
                    _markers.add(
                      Marker(
                        markerId: MarkerId('mark3'),
                        position: LatLng(37.42196183580660, -122.089743655967),
                        //  icon: markerss[2],
                      ),
                    );
                  });
                },
              );
            }),
          ),
          tripPoolinfo
              ? riideRoute
                  ? rideRoute(context)
                  : offerRide(context)
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    FadedSlideAnimation(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 46.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2.5.h),
                                topRight: Radius.circular(2.5.h))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.5.w, vertical: 1.8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    locale!.rideStartson! + " 26 Mar, 10:30 am",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: 11.2.sp,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.more_vert,
                                    color: Colors.grey,
                                    size: 2.2.h,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.directions_walk,
                                    color: Colors.grey[400],
                                    size: 1.5.h,
                                  ),
                                  SizedBox(
                                    width: 5.5.w,
                                  ),
                                  Text("520m " + locale.toPickupPoint!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Colors.grey[300],
                                              fontSize: 9.sp)),
                                ],
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.grey[400],
                                size: 1.5.h,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: primaryColor,
                                    size: 1.5.h,
                                  ),
                                  SizedBox(
                                    width: 5.5.w,
                                  ),
                                  Text("Hamilton Bridge",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 11.2.sp)),
                                  Spacer(),
                                  Text("9:58 am",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 11.2.sp))
                                ],
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.grey[400],
                                size: 1.5.h,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.drive_eta,
                                    color: Colors.grey[400],
                                    size: 1.5.h,
                                  ),
                                  SizedBox(
                                    width: 5.5.w,
                                  ),
                                  Text("42.3km " + locale.drive!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Colors.grey[300],
                                              fontSize: 9.sp)),
                                ],
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.grey[400],
                                size: 1.5.h,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 1.5.h,
                                  ),
                                  SizedBox(
                                    width: 5.5.w,
                                  ),
                                  Text("World Trade Point",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 11.2.sp)),
                                  Spacer(),
                                  Text("9:58 am",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 11.2.sp))
                                ],
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.grey[400],
                                size: 1.5.h,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.directions_walk,
                                    color: Colors.grey[400],
                                    size: 1.5.h,
                                  ),
                                  SizedBox(
                                    width: 5.5.w,
                                  ),
                                  Text("380m " + locale.fromDropPoint!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Colors.grey[300],
                                              fontSize: 9.sp)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      beginOffset: Offset(0, 0.4),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    ),
                    FadedSlideAnimation(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height - 165),
                          width: MediaQuery.of(context).size.width,
                          height: 76.h,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200]!,
                                    offset: Offset(0, 0.3),
                                    blurRadius: 10,
                                    spreadRadius: 7)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(2.5.h),
                                  topRight: Radius.circular(2.5.h))),
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 42.w),
                                child: Divider(
                                  color: Colors.grey[300],
                                  thickness: 5,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  setState(() {
                                    poolerDetails = !poolerDetails;
                                  });
                                },
                                leading: Container(
                                  height: 6.3.h,
                                  child: Image.asset(widget.img),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      widget.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 12.5.sp),
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$3.50",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 12.5.sp),
                                    )
                                  ],
                                ),
                                subtitle: Row(
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
                                      "Bank of USA",
                                      style: TextStyle(
                                          fontSize: 8.3.sp,
                                          color: Color(0xffa8aeb2)),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.directions_bike,
                                          size: iconSize,
                                          color:
                                              Color.fromARGB(255, 48, 98, 131),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          child: Icon(
                                            Icons.circle,
                                            size: .5.h,
                                            color: Color(0xffa8aeb2),
                                          ),
                                        ),
                                        Icon(
                                          Icons.account_circle,
                                          size: iconSize,
                                          color: Color(0xffa8aeb2),
                                        ),
                                        Icon(
                                          Icons.account_circle,
                                          size: iconSize,
                                          color: Color(0xffa8aeb2),
                                        ),
                                        Icon(
                                          Icons.account_circle,
                                          size: iconSize,
                                          color: Color(0xffa8aeb2),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.5.h, vertical: 1.3.h),
                                    child: Text(
                                      locale.copassengers!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 11.2.sp,
                                              color: Color(0xffb3b3b3)),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/profiles/img1.png"),
                                              ),
                                              SizedBox(
                                                height: .7.h,
                                              ),
                                              Text(
                                                "Samantha \nSmith",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(fontSize: 8.3.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: Icon(
                                                  Icons.account_circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: .7.h,
                                              ),
                                              Text(
                                                "Empty \nSeat",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 8.3.sp,
                                                        color:
                                                            Colors.grey[300]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: Icon(
                                                  Icons.account_circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: .7.h,
                                              ),
                                              Text(
                                                "Empty \nSeat",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 8.3.sp,
                                                        color:
                                                            Colors.grey[300]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: Icon(
                                                  Icons.account_circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: .7.h,
                                              ),
                                              Text(
                                                "Empty \nSeat",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 8.3.sp,
                                                        color:
                                                            Colors.grey[300]),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.4.h),
                                    child: Divider(
                                      color: Colors.grey[200],
                                      thickness: 5,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.5.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locale.riderRating!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontSize: 11.2.sp,
                                                      color: Color(0xffb3b3b3)),
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.5.w),
                                              height: 2.2.h,
                                              width: 12.5.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.green[500],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.5.h)),
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
                                                        color: Colors.white,
                                                        fontSize: 9.sp),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locale.rideWith!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontSize: 11.2.sp,
                                                      color: Color(0xffb3b3b3)),
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Text("249 People",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 11.2.sp)),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locale.joined!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontSize: 11.2.sp,
                                                      color: Color(0xffb3b3b3)),
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Text("in 2018",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 11.2.sp)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.4.h),
                                    child: Divider(
                                      color: Colors.grey[200],
                                      thickness: 5,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.5.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locale.vehicleInfo!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontSize: 11.2.sp,
                                                      color: Color(0xffb3b3b3)),
                                            ),
                                            SizedBox(
                                              height: .7.h,
                                            ),
                                            Row(
                                              children: [
                                                Text("Toyota Matrix",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            fontSize: 11.2.sp)),
                                                SizedBox(
                                                  width: 2.8.w,
                                                ),
                                                Text(
                                                  "Hatchback | NYC55142",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          fontSize: 9.sp,
                                                          color: Color(
                                                              0xffb3b3b3)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.6.h,
                                        ),
                                        Text(
                                          locale.facilities!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontSize: 11.2.sp,
                                                  color: Color(0xffb3b3b3)),
                                        ),
                                        SizedBox(
                                          height: .7.h,
                                        ),
                                        Text(locale.listeningMusic!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontSize: 11.2.sp)),
                                        SizedBox(
                                          height: 1.6.h,
                                        ),
                                        Text(
                                          locale.instructions!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontSize: 11.2.sp,
                                                  color: Color(0xffb3b3b3)),
                                        ),
                                        SizedBox(
                                          height: .7.h,
                                        ),
                                        Text(locale.smoking!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontSize: 11.2.sp))
                                      ],
                                    ),
                                  ),
                                ],
                              )

                              // Spacer(),
                            ],
                          ),
                        ),
                      ),
                      beginOffset: Offset(0, 0.4),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.5.w, vertical: 2.h),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                              height: 6.5.h,
                              width: 6.5.h,
                              decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  border: Border.all(
                                      color: primaryColor, width: 0.4.w),
                                  borderRadius: BorderRadius.circular(5.h)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.chat,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatPage()));
                                  })),
                          SizedBox(
                            width: 5.5.w,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EndTripPoolTaker()));
                                // setState(() {
                                //   tripPoolinfo = true;
                                // });
                              },
                              child: FadedScaleAnimation(
                                child: Container(
                                  height: 6.5.h,
                                  width: double.infinity,
                                  padding: EdgeInsetsDirectional.only(
                                      end: 6.5.h,
                                      start: 3.2.h,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.h),
                                      color: primaryColor),
                                  child: Center(
                                      child: Row(
                                    children: [
                                      Icon(Icons.call,
                                          size: 2.5.h, color: Colors.white),
                                      Spacer(),
                                      Text(
                                        locale.callRider!.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 13.5.sp,
                                                letterSpacing: 2,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                                ),
                                scaleDuration:
                                    const Duration(milliseconds: 600),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
          riideRoute
              ? Positioned(
                  right: 8.5.w,
                  bottom: 41.h,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EndTripPooler()));
                    },
                    child: FadedScaleAnimation(
                      child: Container(
                        height: 5.2.h,
                        width: 50.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.5.w, vertical: 1.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.h),
                            color: primaryColor),
                        child: Center(
                            child: Row(
                          children: [
                            Icon(Icons.navigation,
                                size: 2.3.h, color: Colors.white),
                            Spacer(),
                            Text(
                              locale!.direction!.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 12.5.sp,
                                      letterSpacing: 2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                      ),
                      scaleDuration: const Duration(milliseconds: 600),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget offerRide(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return FadedSlideAnimation(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.3.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(2.5.h)),
        height: 38.5.h,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  locale.rideStartson! + " 25 Jun, 10:30 am",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 11.2.sp, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 1.7.h,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text("1024, Central Park, Hemilton, New York",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 11.2.sp)),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 1.8.h,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text("M141, Food Center, Hemilton, Illinois",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 11.2.sp)),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.3.h),
              child: Row(
                children: [
                  Text(
                    locale.copassengers!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 11.2.sp, color: Color(0xffb3b3b3)),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/profiles/img1.png"),
                        ),
                        SizedBox(
                          height: .7.h,
                        ),
                        Text(
                          "Samantha \nSmith",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 8.3.sp),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: .7.h,
                        ),
                        Text(
                          "Empty \nSeat",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 8.3.sp),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: .7.h,
                        ),
                        Text(
                          "Empty \nSeat",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 8.3.sp),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: .7.h,
                        ),
                        Text(
                          "Empty \nSeat",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 8.3.sp),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            GestureDetector(
                onTap: () {
                  setState(() {
                    riideRoute = true;
                  });
                },
                child: FadedScaleAnimation(
                  child: ColorButton(locale.startRide),
                  scaleDuration: const Duration(milliseconds: 600),
                ))
          ],
        ),
      ),
      beginOffset: Offset(0, 0.4),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}

Widget rideRoute(BuildContext context) {
  var locale = AppLocalizations.of(context)!;
  return FadedSlideAnimation(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 1.9.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(2.5.h)),
      height: 44.h,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    locale.rideRoute!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 11.2.sp),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                child: Text(locale.startRide!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 10.sp)),
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 1.7.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text("1024, Central Park, Hemilton, New York",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 10.sp)),
                ],
              ),
              Icon(
                Icons.more_vert,
                size: 1.7.h,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                child: Row(
                  children: [
                    Text(locale.pickup!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10.sp)),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Text("Samantha Saint",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 10.sp, color: primaryColor)),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                    size: 1.7.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text("Hemilton Bridge, New York",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 10.sp)),
                ],
              ),
              Icon(
                Icons.more_vert,
                size: 1.7.h,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                child: Row(
                  children: [
                    Text(locale.pickup!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10.sp)),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Text("Peter Taylor",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 10.sp, color: primaryColor)),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                    size: 1.7.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text("City Parle Park, Hemilton, New York",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 10.sp)),
                ],
              ),
              Icon(
                Icons.more_vert,
                size: 1.7.h,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                child: Row(
                  children: [
                    Text(locale.drop!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10.sp)),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Text("Peter Taylor",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 10.sp, color: primaryColor)),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.red,
                    size: 1.7.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text("1024, Central Park, Hemilton, New York",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 10.sp)),
                ],
              ),
              Icon(
                Icons.more_vert,
                size: 1.7.h,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                child: Row(
                  children: [
                    Text(locale.drop!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10.sp)),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Text("Samantha Smith",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 10.sp, color: primaryColor)),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.red,
                    size: 1.7.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text("Golden Street, New York",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 10.sp)),
                ],
              ),
              Icon(
                Icons.more_vert,
                size: 1.7.h,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                child: Row(
                  children: [
                    Text(locale.endTrip!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10.sp)),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 1.7.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text("M141, Food Center, Hemilton, Illinois",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 10.sp)),
                ],
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    ),
    beginOffset: Offset(0, 0.4),
    endOffset: Offset(0, 0),
    slideCurve: Curves.linearToEaseOut,
  );
}
