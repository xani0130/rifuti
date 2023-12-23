import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_pool/components/widgets/colorButton.dart';
import 'package:go_pool/language/languageCubit.dart';
import 'package:go_pool/language/locale.dart';

import 'package:go_pool/screens/auth/login_navigator.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:sizer/sizer.dart';

class ChangeLanguage extends StatefulWidget {
  final bool isStart;

  ChangeLanguage([this.isStart = false]);
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  late LanguageCubit _languageCubit;

  int? _selectedLanguage = -1;

  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List languages = [
      "English",
      "Français",
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Column(
        // alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 5.5.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 25,
                    // ),
                    Text(
                      locale.language!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18.3.sp),
                    ),
                    SizedBox(
                      width: 5.5.w,
                    ),
                    Text(
                      locale.preferredLanguage!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12.5.sp),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                  ],
                ),
                Spacer(),
                Expanded(
                  flex: 6,
                  child: FadedScaleAnimation(
                    child: Container(
                      // height: MediaQuery.of(context).size.width * 0.25,
                      child: Image.asset("assets/head_support.png"),
                    ),
                    scaleDuration: const Duration(milliseconds: 600),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: FadedSlideAnimation(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 2.5.h),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.5.h)),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.2.w),
                      child: Text(
                        locale.selectPreferredLanguage!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 12.5.sp),
                      ),
                    ),
                    ListView.builder(
                      //
                      padding: EdgeInsets.only(bottom: 50),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: .3.h),
                          child: RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            activeColor: primaryColor,
                            title: Text(languages[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 14.2.sp)),
                            value: index,
                            groupValue: _selectedLanguage,
                            onChanged: (dynamic val) {
                              setState(() {
                                _selectedLanguage = val;
                                print(val);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              beginOffset: Offset(0, 0.4),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.5.w),
            child: GestureDetector(
              onTap: () {
                if (_selectedLanguage == 0) {
                  _languageCubit.selectEngLanguage();
                } else if (_selectedLanguage == 1) {
                  _languageCubit.selectArabicLanguage();
                } else if (_selectedLanguage == 2) {
                  _languageCubit.selectFrenchLanguage();
                } else if (_selectedLanguage == 3) {
                  _languageCubit.selectPortugueseLanguage();
                } else if (_selectedLanguage == 4) {
                  _languageCubit.selectIndonesianLanguage();
                } else if (_selectedLanguage == 5) {
                  _languageCubit.selectSpanishLanguage();
                } else if (_selectedLanguage == 6) {
                  _languageCubit.selectItalianLanguage();
                } else if (_selectedLanguage == 7) {
                  _languageCubit.selectSwahiliLanguage();
                } else if (_selectedLanguage == 8) {
                  _languageCubit.selectTurkishLanguage();
                }
                if (widget.isStart) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginNavigator()));
                } else {
                  Navigator.pop(context);
                }
              },
              child: FadedScaleAnimation(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.2.h),
                  child: Container(
                      height: 55,
                      child: FadedScaleAnimation(
                        child: ColorButton(locale.submit),
                        scaleDuration: const Duration(milliseconds: 600),
                      )),
                ),
                scaleDuration: const Duration(milliseconds: 600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
