import 'dart:async';
// import 'package:go_pool/components/widgets/';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_pool/OrderMapBloc/order_map_bloc.dart';
import 'package:go_pool/OrderMapBloc/order_map_state.dart';
import 'package:go_pool/components/date_picker.dart';
import 'package:go_pool/components/widgets/colorButton.dart';
import 'package:go_pool/components/widgets/entry_field.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/map_utils.dart';
import 'package:go_pool/screens/home/home/findPool.dart';
import 'package:go_pool/screens/home/riderProviders.dart';
import 'package:go_pool/screens/home/selectLocation.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderMapBloc>(
      create: (context) => OrderMapBloc()..loadMap(),
      child: HomeBody(),
    );
  }
}

List<String> seats = [
  "Select Seat",
  "1 Seat",
  "2 Seat",
  "3 Seat",
  "4 Seat",
  "5 Seat",
  "6 Seat",
];
String? seat = "Select Seat";

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool locationSelected = false;
  bool isFindPool = true;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapStyleController;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          //
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<OrderMapBloc, OrderMapState>(
              builder: (context, state) {
            print('polyyyy' + state.polylines.toString());
            return GoogleMap(
              markers: _markers,
              mapType: MapType.normal,
              initialCameraPosition: kGooglePlex,
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
                height: 42.h,
                //  height: 330,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(2.5.h)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.9.h,
                      //    height: 15,
                    ),
                    Container(
                      height: 6.5.h,
                      //height: 50,
                      width: 84.5.w,
                      //width: 304,
                      padding: EdgeInsets.all(0.26.h),
                      decoration: BoxDecoration(
                          color: primaryColorlight,
                          borderRadius: BorderRadius.circular(5.h)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFindPool = true;
                              });
                            },

                            // do from here
                            child: Container(
                              height: 6.h,
                              // width: 20.h,
                              //width: 150,
                              width: 41.5.w,
                              decoration: BoxDecoration(
                                  color: isFindPool
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5.h)),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.drive_eta,
                                        color: !isFindPool
                                            ? Color(0xff80ffffff)
                                            : primaryColor),
                                    SizedBox(
                                      width: 2.5.w,
                                    ),
                                    Text(
                                      locale.findPool!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 11.sp,
                                              //fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: isFindPool
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
                                isFindPool = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FindPool(false)));
                            },
                            child: Container(
                              // height: 50,
                              // width: 150,
                              height: 6.h,

                              width: 41.7.w,
                              decoration: BoxDecoration(
                                  color: isFindPool
                                      ? Colors.transparent
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(5.h)),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.nature_people,
                                      color: isFindPool
                                          ? Color(0xff80ffffff)
                                          : primaryColor,
                                    ),
                                    SizedBox(
                                      width: 2.5.w,
                                    ),
                                    Text(
                                      locale.offerPool!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11.sp,
                                              color: !isFindPool
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
              Container(
                width: MediaQuery.of(context).size.width,

                //height: 250,
                height: 32.9.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.5.h),
                        topRight: Radius.circular(2.5.h))),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectLocation()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
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
                                  height: 0.6.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.4.w),
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.grey[400],
                                    size: 3.2.h,
                                  ),
                                ),
                                SizedBox(
                                  height: .7.h,
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
                                    initialValue:
                                        "1024, Central Park, New York",
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.1.w,
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
                                            fontSize: 11.sp,
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
                                                fontSize: 11.sp),
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
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10),
                        //   child: TextFormField(
                        //     cursorColor: primaryColor,
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => SelectLocation()));
                        //     },
                        //     autofocus: false,
                        //     readOnly: true,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodyLarge!
                        //         .copyWith(fontSize: 13.5),
                        //     minLines: 1,
                        //     decoration: InputDecoration(
                        //       // prefixIcon: Icon(
                        //       //   Icons.location_on,
                        //       //   color: Colors.red,
                        //       //   size: 20,
                        //       // ),
                        //       hintText: locale.dropLocation,
                        //       hintStyle: Theme.of(context)
                        //           .textTheme
                        //           .bodyMedium!
                        //           .copyWith(color: Colors.grey, fontSize: 13.5),
                        //       border: UnderlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey[200]!),
                        //       ),
                        //       enabledBorder: UnderlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey[200]!),
                        //       ),
                        //       focusedBorder: UnderlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey[200]!),
                        //       ),
                        //       counter: Offstage(),
                        //     ),
                        //   ),
                        // ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DateTimePickerWidget(),
                            SizedBox(
                              width: 3.w,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.drive_eta,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                    width:
                                        1.5.w), // Adjust the spacing as needed
                                SizedBox(
                                  //        width: 120,
                                  width: 35.5.w,
                                  child: DropdownButton<String>(
                                    //   alignment: Alignment.topCenter,
                                    // isDense: true,
                                    value: seat,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 11.sp),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 1.8.h,
                                      color: Colors.grey,
                                    ),
                                    items: seats.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        seat = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   width: 35,
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RideProviders(true)));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.5.h),
                            child: FadedScaleAnimation(
                              child: ColorButton(locale.findPool),
                              scaleDuration: const Duration(milliseconds: 600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.4),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
        Positioned(
          right: 5.w,
          bottom: 45.h,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.gps_fixed,
              color: Colors.grey[400],
            ),
          ),
        ),
      ],
    );
  }
}
