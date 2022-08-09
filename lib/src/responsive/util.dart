import 'enum.dart';
import 'package:flutter/cupertino.dart';

DeviceScreenType getDeviceType(Size size) {
// DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  // var orientation = mediaQuery.orientation;

  double deviceWidth = 0;

  // if (orientation == Orientation.landscape) {
  //   deviceWidth = mediaQuery.size.height;
  // } else {
  // deviceWidth = mediaQuery.size.width;
  deviceWidth = size.width;
  // }

  if (deviceWidth > 950) {
    return DeviceScreenType.Desktop;
  } else if (deviceWidth > 600) {
    return DeviceScreenType.Tablet;
  } else if (deviceWidth > 428) {
    return DeviceScreenType.Mobile_Iphone_12_Promax;
  } else if (deviceWidth > 375) {
    return DeviceScreenType.Mobile_Iphone_6_Plus;
  } else if (deviceWidth > 300) {
    return DeviceScreenType.Mobile;
  }
  return DeviceScreenType.Watch;
}

DeviceScreenType getDeviceTypeheight(Size size) {
// DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  // var orientation = mediaQuery.orientation;

  double deviceHeight = 0;

  // if (orientation == Orientation.landscape) {
  //   deviceWidth = mediaQuery.size.height;
  // } else {
  // deviceWidth = mediaQuery.size.width;
  deviceHeight = size.height;
  // }

  // if (deviceHeight > 950) {
  //   return DeviceScreenType.Desktop;
  // } else if (deviceHeight <= 1000) {
  //   return DeviceScreenType.Tablet;
  // } else if (deviceHeight <= 926) {
  //   return DeviceScreenType.Mobile_Iphone_12_Promax;
  // } else if (deviceHeight <= 667) {
  //   return DeviceScreenType.Mobile_Iphone_6_Plus;
  // } else if (deviceHeight <= 568) {
  //   return DeviceScreenType.Mobile;
  // }
  // return DeviceScreenType.Watch;


  if (deviceHeight >= 1000) {
    return DeviceScreenType.Desktop;
  } else if (deviceHeight <= 568) {
    return DeviceScreenType.Mobile;
  } else if (deviceHeight <= 667) {
    return DeviceScreenType.Mobile_Iphone_6_Plus;
  } else if (deviceHeight <= 926) {
    return DeviceScreenType.Mobile_Iphone_12_Promax;
  } else if (deviceHeight <= 999) {
    return DeviceScreenType.Tablet;
  }
  return DeviceScreenType.Watch;
}


