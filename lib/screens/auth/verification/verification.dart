import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_pool/components/widgets/colorButton.dart';
import 'package:go_pool/components/widgets/textField.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:sizer/sizer.dart';

import 'verification_interator.dart';

class Verification extends StatefulWidget {
  final VerificationInteractor verificationInteractor;
  Verification(this.verificationInteractor);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  void initState() {
    super.initState();
    widget.verificationInteractor.verifyNumber();
  }
  final TextEditingController phoneC =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 5.5.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Text(
                      locale.verification!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 16.7.sp),
                    ),
                    Text(
                      locale.inLessThanAmin!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 11.7.sp),
                    )
                  ],
                ),
                SizedBox(
                  width: 5.5.w,
                ),
                Expanded(
                  child: FadedScaleAnimation(
                    child: Container(
                      child: Image.asset(
                        "assets/img_verification.png",
                        //  fit: BoxFit.contain,
                      ),
                    ),
                    scaleDuration: const Duration(milliseconds: 600),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 2.5.h),
            height: MediaQuery.of(context).size.height * 0.7,
            //   height: 2.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.5.h),
                  topRight: Radius.circular(2.5.h)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Text(
                    locale.enterVerificationCodeWeveSent!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 12.5.sp),
                  ),
                  SizedBox(
                    height: 3.7.h,
                  ),
                  EntryField(locale.enterCode, locale.enter6digit, false,phoneC),
                  // Spacer(),
                  GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => NavigationHome()));
                        widget.verificationInteractor.verificationDone();
                      },
                      child: FadedScaleAnimation(
                        child: ColorButton(locale.getStarted),
                        scaleDuration: const Duration(milliseconds: 600),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
