// import 'package:firebase_admob/firebase_admob.dart';
// import 'dart:io';


// MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['Education', 'Learning, Picture, A-Z'],
//   contentUrl: 'https://flutter.io',
//   childDirected: false,
//   // birthday: DateTime.now(),
//   // designedForFamilies: false,
//   // gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
//   testDevices: <String>[], // Android emulators are considered test devices
// );

// BannerAd myBanner = BannerAd(
//   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//   // https://developers.google.com/admob/android/test-ads
//   // https://developers.google.com/admob/ios/test-ads
//   adUnitId: Platform.isAndroid
//         ? 'ca-app-pub-3568261915655391/8470243819'
//         : 'ca-app-pub-3568261915655391/3008542880',
//   size: AdSize.smartBanner,               //AdSize.smartBanner
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("BannerAd event is $event");
//   },
// );

// InterstitialAd myInterstitial = InterstitialAd(
//   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//   // https://developers.google.com/admob/android/test-ads
//   // https://developers.google.com/admob/ios/test-ads
//   adUnitId: Platform.isAndroid
//         ? 'ca-app-pub-3568261915655391/7552516456'
//         : 'ca-app-pub-3568261915655391/2816971190',
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("InterstitialAd event is $event");
//   },
// );