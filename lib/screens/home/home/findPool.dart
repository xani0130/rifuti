import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_pool/OrderMapBloc/order_map_bloc.dart';
import 'package:go_pool/OrderMapBloc/order_map_state.dart';
import 'package:go_pool/components/widgets/colorButton.dart';
import 'package:go_pool/components/widgets/entry_field.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/map_utils.dart';
import 'package:go_pool/screens/home/riderProviders.dart';
import 'package:go_pool/screens/home/selectLocation.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../components/date_picker.dart';

class FindPool extends StatelessWidget {
  bool isFindPool;

  FindPool(this.isFindPool);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderMapBloc>(
      create: (context) => OrderMapBloc()..loadMap(),
      child: FindPoolBody(isFindPool),
    );
  }
}

class FindPoolBody extends StatefulWidget {
  bool isFindPool;

  FindPoolBody(this.isFindPool);

  @override
  _FindPoolBodyState createState() => _FindPoolBodyState();
}

class _FindPoolBodyState extends State<FindPoolBody> {
  List days = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
  List<String> seats = [
    "1 Seat",
    "2 Seat",
    "3 Seat",
    "4 Seat",
    "5 Seat",
    "6 Seat",
  ];
  // List<String> cars = [
  //   "Hatchback",
  //   "Sedan",
  //   "SUV",
  //   "4x4",
  // ];
  int dayIndex = 0;
  String? seat = '1 Seat';
  // String? car = 'Hatchback';
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapStyleController;
  Set<Marker> _markers = {};

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
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 6.4.h),
                  width: MediaQuery.of(context).size.width,
                  //height: 342,
                  height: 43.6.h,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.5.h),
                          topRight: Radius.circular(2.5.h))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.9.h,
                      ),
                      Container(
                        height: 6.4.h,
                        //width: 304,
                        width: 38.8.h,
                        padding: EdgeInsets.all(.2.h),
                        decoration: BoxDecoration(
                            color: primaryColorlight,
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.isFindPool = true;
                                });
                              },
                              child: Container(
                                height: 6.5.h,
                                width: 19.2.h,
                                //width: 150,
                                decoration: BoxDecoration(
                                    color: widget.isFindPool
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10.h)),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.drive_eta,
                                        color: !widget.isFindPool
                                            ? Color(0xff80ffffff)
                                            : primaryColor,
                                        size: 2.6.h,
                                      ),
                                      SizedBox(
                                        width: 2.5.w,
                                      ),
                                      Text(
                                        locale.findPool!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11.sp,
                                                color: widget.isFindPool
                                                    ? Color(0xff4d4d4d)
                                                    : Color(0xff80ffffff)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.isFindPool = false;
                                });
                              },
                              child: Container(
                                // height: 50,
                                // width: 150,
                                height: 6.5.h,
                                width: 19.2.h,

                                decoration: BoxDecoration(
                                    color: widget.isFindPool
                                        ? Colors.transparent
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10.h)),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.escalator_warning_outlined,
                                        color: widget.isFindPool
                                            ? Color(0xff80ffffff)
                                            : primaryColor,
                                        size: 2.6.h,
                                      ),
                                      SizedBox(width: 2.5.w),
                                      Text(
                                        locale.offerPool!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w600,
                                                color: !widget.isFindPool
                                                    ? Color(0xff4d4d4d)
                                                    : Color(0xff80ffffff)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            beginOffset: Offset(0, 0.4),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
          FadedSlideAnimation(
            child: Container(
              width: MediaQuery.of(context).size.width,
              //height: 312,
              height: 40.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.5.h),
                      topRight: Radius.circular(2.5.h))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 2.8.w, right: 2.8.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.circle,
                                color: primaryColor,
                                size: 2.5.h,
                              ),
                              SizedBox(
                                height: .6.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: .3.w),
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.grey[400],
                                  size: 3.h,
                                ),
                              ),
                              SizedBox(
                                height: .6.h,
                              ),
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 2.5.h,
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   width: 7,
                          // ),
                          Expanded(
                            child: Column(
                              children: [
                                TextEntryField(
                                  // prefixIcon: Icon(
                                  //   Icons.circle,
                                  //   color: primaryColor,
                                  //   size: 15,
                                  // ),
                                  hint: locale.pickupLocation,
                                  initialValue: "1024, Central Park, New York",
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                  ),
                                  child: TextFormField(
                                    cursorColor: primaryColor,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectLocation()));
                                    },
                                    autofocus: false,
                                    readOnly: true,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 11.2.sp,
                                        ),
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      // prefixIcon: Icon(
                                      //   Icons.location_on,
                                      //   color: Colors.red,
                                      //   size: 20,
                                      // ),
                                      hintText: locale.dropLocation,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Colors.grey,
                                              fontSize: 10.2.sp),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[200]!),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[200]!),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[200]!),
                                      ),
                                      counter: Offstage(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // TextEntryField(
                      //   // prefixIcon: Icon(
                      //   //   Icons.circle,
                      //   //   color: primaryColor,
                      //   //   size: 10,
                      //   // ),
                      //   initialValue: "1024, Central Park, Hemilton, New York",
                      // ),
                      // TextEntryField(
                      //   // prefixIcon: Icon(
                      //   //   Icons.location_on,
                      //   //   color: Colors.red,
                      //   //   size: 10,
                      //   // ),
                      //   initialValue: "M141, Food Center, Hemilton, Illinois",
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DateTimePickerWidget(),
                          SizedBox(
                            width: 3.w,
                          ),
                          Icon(
                            Icons.drive_eta,
                            color: Colors.grey,
                            // size: 25,
                          ),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          SizedBox(
                            //width: MediaQuery.of(context).size.width * 0.3,
                            width: 35.5.w,
                            child: DropdownButton<String>(
                              iconSize: 3.2.h,
                              itemHeight: 7.2.h,
                              // isDense: true,
                              value: widget.isFindPool ? seat : seat,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 11.2.sp),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                              items: widget.isFindPool
                                  ? seats.map<DropdownMenuItem<String>>(
                                      (String value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.centerRight,
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()
                                  : seats.map<DropdownMenuItem<String>>(
                                      (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  if (widget.isFindPool)
                                    seat = value;
                                  else
                                    seat = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      TextEntryField(
                        prefixIcon: Icon(
                          Icons.price_change_outlined,
                          color: primaryColor,
                          size: 3.h,
                        ),
                        //     label: "Set Price per seat",
                        initialValue: "",
                        hint: "Set Price per seat",
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 1.3.h,
                          )
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RideProviders(
                                        widget.isFindPool ? true : false)));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.5.w),
                            child: FadedScaleAnimation(
                              child: ColorButton(widget.isFindPool
                                  ? locale.findPool
                                  : locale.offerPool),
                              scaleDuration: const Duration(milliseconds: 600),
                            ),
                          )),
                      SizedBox(
                        height: .8.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            beginOffset: Offset(0, 0.4),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ],
      ),
    );
  }
}
