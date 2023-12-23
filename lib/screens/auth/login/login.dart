import 'dart:convert';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_pool/components/widgets/colorButton.dart';
import 'package:go_pool/components/widgets/textField.dart';
import 'package:go_pool/language/locale.dart';
import 'package:go_pool/screens/home/navigationHome.dart';
import 'package:go_pool/theme/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';
import 'login_interactor.dart';
class ApiService {
  static const String baseUrl = 'https://20231209t212033-dot-ikansia-f0754.uc.r.appspot.com/rifuti/api/v1';

  static Future<Map<String, dynamic>> sendOTP(String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send-otp'),
      body: {'number': phoneNumber},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  static Future<Map<String, dynamic>> verifyOTP(String phoneNumber, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-otp'),
      body: {'phoneNumber': phoneNumber, 'otp': otp},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify OTP');
    }
  }
}

class Login extends StatefulWidget {
  final LoginInteractor loginInteractor;

  Login(this.loginInteractor);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? car = "Please Select";
final TextEditingController phoneC =  TextEditingController();
final TextEditingController phoneotp =  TextEditingController();

    dynamic data;
  Future<void> sendOTP() async {
    try {
      final response = await ApiService.sendOTP(phoneC.text);
      // Handle the response (e.g., show a success message)
      print(response);
    } catch (e) {
      // Handle errors (e.g., show an error message)
      print(e);
    }
  }

  Future<void> verifyOTP() async {
    try {
      final response = await ApiService.verifyOTP(
        phoneC.text,
        phoneotp.text,
      );
      // Handle the response (e.g., navigate to the next screen on success)
      print(response);
    } catch (e) {
      // Handle errors (e.g., show an error message)
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                color: primaryColor,
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Spacer(),
                    FadedScaleAnimation(
                      child: Container(
                        //height: 100,
                        height: 13.h,
                        child: Image.asset(
                          "assets/icon.png",
                          // height: 13.h,
                          // fit: BoxFit.contain,
                        ),
                      ),
                      scaleDuration: const Duration(milliseconds: 600),
                    ),
                    SizedBox(
                      height: 2.8.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/Main.png"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                    )
                  ],
                ),
              ),
              Container(
                // height: 350,
                height: 45.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.5.h),
                      topRight: Radius.circular(2.5.h)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.5.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Text(
                            locale.signInNow!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 12.5.sp),
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locale.selectCountry!,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: 11.2.sp),
                                ),
                                SizedBox(
                                  height: 2.5.h,
                                ),
                                DropdownButton<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  value: car,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 11.2.sp),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    size: 2.3.h,
                                    color: Colors.grey,
                                  ),
                                  items: <String>[
                                    "Please Select",
                                    "Pakistan",
                                    "China",
                                    "UAE"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: .5.h),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      car = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          EntryField(

                              locale.phoneNumber,
                              locale.enterMobileNumber, false,phoneC),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          GestureDetector(
                              onTap: () {
                                sendOTP();
                                print(phoneC);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Register()));
                                widget.loginInteractor
                                    .loginWithPhone('isoCode', 'mobileNumber');
                              },
                              child: FadedScaleAnimation(
                                child: ColorButton(locale.continuee),
                                scaleDuration:
                                    const Duration(milliseconds: 600),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
