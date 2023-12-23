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
import 'package:go_pool/screens/home/home/endTripPooler.dart';
import 'package:go_pool/screens/home/home/poolingConfirmed.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class PoolerInfoPage extends StatelessWidget {
  final String img;
  final String name;
  final bool isFindPool;

  PoolerInfoPage(this.img, this.name, this.isFindPool);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderMapBloc>(
      create: (context) => OrderMapBloc()..loadMap(),
      child: PoolerInfoBody(img, name, isFindPool),
    );
  }
}

class PoolerInfoBody extends StatefulWidget {
  final String img;
  final String name;
  final bool isFindPool;

  PoolerInfoBody(this.img, this.name, this.isFindPool);

  @override
  _PoolerInfoBodyState createState() => _PoolerInfoBodyState();
}

class _PoolerInfoBodyState extends State<PoolerInfoBody> {
  bool poolerDetails = false;

  double iconSize = 1.3.h;

  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapStyleController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

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
                        icon: markerss[0],
                      ),
                    );
                  });
                },
              );
            }),
          ),
          FadedSlideAnimation(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 350,

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
                              locale.rideStartson! + " 25 Mar, 10:30 am",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 11.2.sp,
                                      fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(
                              Icons.more_vert,
                              color: Colors.grey[300],
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
                        widget.isFindPool
                            ? Icon(
                                Icons.more_vert,
                                color: Colors.grey[400],
                                size: 1.5.h,
                              )
                            : SizedBox.shrink(),
                        widget.isFindPool
                            ? Row(
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
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height - 165),
                    //
                    height: !widget.isFindPool ? 440 : 600,
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
                    child: FadedSlideAnimation(
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
                                      fontSize: 8.2.sp,
                                      color: Color(0xffa8aeb2)),
                                ),
                                Spacer(),
                                widget.isFindPool
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.directions_bike,
                                            size: iconSize,
                                            color: Colors.grey[300],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 1.w),
                                            child: Icon(
                                              Icons.circle,
                                              size: 0.5.h,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          Icon(
                                            Icons.account_circle,
                                            size: iconSize,
                                            color: Colors.grey[300],
                                          ),
                                          Icon(
                                            Icons.account_circle,
                                            size: iconSize,
                                            color: Colors.grey[300],
                                          ),
                                          Icon(
                                            Icons.account_circle,
                                            size: iconSize,
                                            color: Colors.grey[300],
                                          )
                                        ],
                                      )
                                    : Text(
                                        "1 " + locale.seat!,
                                        style: TextStyle(
                                            fontSize: 8.2.h,
                                            color: Color(0xffa8aeb2)),
                                      )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                //dynamic size
                                height: widget.isFindPool ? 2.5.h : 0,
                              ),
                              widget.isFindPool
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Text(locale.copassengers!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 11.2.sp,
                                                color: Color(0xffb3b3b3),
                                              )),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: 1.6.h,
                              ),
                              widget.isFindPool
                                  ? Row(
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
                                                      .copyWith(
                                                          fontSize: 8.2.sp),
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
                                                          fontSize: 8.2.sp,
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
                                                          fontSize: 8.2.sp,
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
                                                          fontSize: 8.2.sp,
                                                          color:
                                                              Colors.grey[300]),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.4.h),
                                child: Divider(
                                  thickness: 3,
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
                                          widget.isFindPool
                                              ? locale.riderRating!
                                              : locale.rating!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
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
                                          height: 2.5.h,
                                          width: 12.5.w,
                                          decoration: BoxDecoration(
                                              color: Colors.green[500],
                                              borderRadius:
                                                  BorderRadius.circular(5.h)),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 1.7.h,
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
                                        Text(locale.rideWith!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontSize: 11.2.sp,
                                                    color: Color(0xffb3b3b3))),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Text("249 People",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontSize: 11.2.sp)),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(locale.joined!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontSize: 11.2.sp,
                                                    color: Color(0xffb3b3b3))),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Text("in 2018",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontSize: 11.2.sp)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.4.h),
                                child: Divider(
                                  thickness: 3,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 5.5.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.isFindPool
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(locale.vehicleInfo!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 11.2.sp,
                                                          color: Color(
                                                              0xffb3b3b3))),
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
                                                              fontSize:
                                                                  11.2.sp)),
                                                  SizedBox(
                                                    width: 2.8.w,
                                                  ),
                                                  Text("Hatchback | NYC55142",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 9.2.sp))
                                                ],
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(
                                      height: 1.6.h,
                                    ),
                                    Text(
                                        widget.isFindPool
                                            ? locale.facilities!
                                            : locale.hobbies!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 11.2.sp,
                                                color: Color(0xffb3b3b3))),
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
                                        widget.isFindPool
                                            ? locale.instructions!
                                            : locale.bio!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 11.2.sp,
                                                color: Color(0xffb3b3b3))),
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
                      beginOffset: Offset(0, 0.4),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 2.h),
                  child: Row(
                    children: [
                      Container(
                          height: 7.h,
                          width: 7.h,
                          decoration: BoxDecoration(
                              color: Colors.green[50],
                              border:
                                  Border.all(color: primaryColor, width: 0.5.w),
                              borderRadius: BorderRadius.circular(10.h)),
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
                                        builder: (context) => widget.isFindPool
                                            ? PoolingConfirmed()
                                            : EndTripPooler()));
                              },
                              child: FadedScaleAnimation(
                                child: Container(
                                  height: 52,
                                  child: ColorButton(widget.isFindPool
                                      ? locale.joinRide
                                      : locale.offerRide),
                                ),
                                scaleDuration:
                                    const Duration(milliseconds: 600),
                              )))
                    ],
                  ),
                )
              ],
            ),
            beginOffset: Offset(0, 0.4),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          )
        ],
      ),
    );
  }
}
