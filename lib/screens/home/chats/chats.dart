import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/screens/home/chats/chatPage.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:sizer/sizer.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<Widget> tabs = <Widget>[
      Tab(text: locale.liveChat),
      // Tab(text: locale.archive),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.chats!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 18.5.sp),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ChatRooms(),
    );
  }
}

class ChatRooms extends StatelessWidget {
  final List imgs = [
    "assets/profiles/img1.png",
    "assets/profiles/img2.png",
    "assets/profiles/img3.png",
    "assets/profiles/img4.png",
    "assets/profiles/img1.png",
    "assets/profiles/img3.png",
    "assets/profiles/img4.png",
    "assets/profiles/img2.png"
  ];
  final List names = [
    "George Anderson",
    "Emili Williamson",
    "Mark Taylor",
    "Lisa Davis",
    "Deneil Haydon",
    "Emili Williamson",
    "Mark Taylor",
    "Lisa Davis",
  ];
  final List dateTime = [
    "10 minutes",
    "16 minutes",
    "22 minutes",
    "29 minutes",
    "24 Nov 2023, 10:47 am",
    "24 Nov 2023, 09:50 am",
    "29 Nov 2023, 08:50 pm",
    "24 Nov 2023, 09:50 am",
  ];
  final List messsage = [
    "Ok No Worrie",
    "Come Fast Waiting",
    "Okay",
    "Thanks",
    "Wating",
    "Okay Thanks",
    "No Worrie",
    "Wating",
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      color: backgroundColor,
      child: FadedSlideAnimation(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 1.3.h),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 1.3.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.5.h),
                    color: Colors.white),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.5.w,
                  ),
                  leading: Container(
                    child: Image.asset(imgs[index]),
                    height: 6.5.h,
                  ),
                  title: Text(
                    names[index],
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 11.2.sp),
                  ),
                  subtitle: Row(
                    children: [
                      Text(messsage[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 10.sp, color: Color(0xffa8aeb2))),
                      Spacer(),
                      Text(dateTime[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 8.3.sp, color: Color(0xffcccccc))),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        beginOffset: Offset(0.4, 0),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

class Archive extends StatelessWidget {
  final List imgs = [
    "assets/profiles/img1.png",
    "assets/profiles/img2.png",
    "assets/profiles/img3.png",
    "assets/profiles/img4.png",
  ];
  final List names = [
    "George Anderson",
    "Emili Williamson",
    "Mark Taylor",
    "Lisa Davis",
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: backgroundColor,
      child: FadedSlideAnimation(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 10),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  leading: Container(
                    child: Image.asset(imgs[index]),
                    height: 50,
                  ),
                  title: Text(
                    names[index],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 13.5,
                        ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(locale!.no!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 12, color: Color(0xffa8aeb2))),
                      Spacer(),
                      Text("20 min",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 10, color: Color(0xffcccccc))),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        beginOffset: Offset(0.4, 0),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
