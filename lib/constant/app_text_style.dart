import 'package:flutter/material.dart';

class AppTextStyle {
  static const logotext = TextStyle(
      color: Color(0xFFF5EBEB), fontSize: 30, fontWeight: FontWeight.bold);

  static const phoneverifytext = TextStyle(
      fontSize: 25,
      color: Color.fromARGB(255, 231, 231, 238),
      fontWeight: FontWeight.w700);

  // btnstyle

  static const buttontext = TextStyle(
      color: Color(0xFFF5EBEB), fontSize: 20, fontWeight: FontWeight.w500);

  static const buttontextone = TextStyle(
      color: Color(0xFFF5EBEB), fontSize: 16, fontWeight: FontWeight.w700);

// verify screen

  static const headingtext = TextStyle(
      fontSize: 30, fontWeight: FontWeight.w500, color: Color(0xFF333333));
  static const subheading = TextStyle(
      color: Color(0xFF666666), fontSize: 16, fontWeight: FontWeight.w400);

// timeline text
  static const timelineheadingtext = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF333333));
  static const timelinesubheading = TextStyle(
      color: Color(0xFF666666), fontSize: 13, fontWeight: FontWeight.w400);

// otp screen
  static const otpheadingtext = TextStyle(
      fontSize: 12, color: Color(0xFF666666), fontWeight: FontWeight.w400);
  static const otpsubheading = TextStyle(
      color: Color(0xFF666666), fontSize: 21, fontWeight: FontWeight.w400);
  static const drhsubheading = TextStyle(
    color: Color(0xFF666666),
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

// Vehicle

  static const vehicleheading = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF333333));
  static const vehiclesubheading = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF333333));

// submit screen

  static const sumbitheading = TextStyle(
      fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF333333));
  static const submitsubheading = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF333333),
      textBaseline: TextBaseline.ideographic);

// welcome
  static const welcommehead = TextStyle(
      fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF333333));
  static const welcomesubheading = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w300, color: Color(0xFF333333));

// welcome ride item
  static const boldUpperText = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333));
  static const upperitemtmeemtext = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF333333));
  static const upperitemtmeemspantext = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w300, color: Color(0xFF333333));
  static const rideitemhead = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF333333));
  static const dropitmeemtext = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF333333));
  static const dropitmeemspantext = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w300, color: Color(0xFF333333));
  static const disitmeemtext = TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF333333));
  static const disitmeemspantext = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w300, color: Color(0xFF333333));

// Payment amount
  static const amounttext = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF333333));
  static const amounitmeemtext = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xFF333333));
  static const amountitmeemspantext = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w300, color: Color(0xFF333333));
  static const scanpaytext = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFF00B74C));

  //RIDE
  static const rideBold = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
  static const rideNormal = TextStyle(fontSize: 12);

  //Change password style
  static const changePassword =
      TextStyle(fontSize: 24, color: Color(0xFF333333));
  static const changePasswordContent =
      TextStyle(fontSize: 15, color: Colors.grey);

//location

  static const addressText = TextStyle(
      fontSize: 12, color: Color(0xFF262628), fontWeight: FontWeight.w400);

  static const listCardProfile = TextStyle(fontSize: 18);

  static const onboaringSubtitle = TextStyle(
      fontSize: 17, color: Color(0xFF262628), fontWeight: FontWeight.w400);
}
