import 'package:flutter/material.dart';
import 'package:lwp/Screens/DetailScreen/DetailScreen.dart';
// import 'package:lwp/Screens/Common/fancy_fab.dart';
import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:lwp/Model/WordModel.dart';

class SecondScreen extends StatefulWidget {
  final List<Word> _words;
  SecondScreen(this._words);

  @override
  _SecondScreenState createState() => _SecondScreenState(_words);
}

class _SecondScreenState extends State<SecondScreen> {
final List<Word> _words;
_SecondScreenState(this._words);

  String admobId() => Platform.isAndroid
        ? 'ca-app-pub-3568261915655391~9783325485'
        : 'ca-app-pub-3568261915655391~4433305191';

static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['Education', 'Learning, Picture, A-Z'],
  contentUrl: 'https://flutter.io',
  childDirected: true,
  // birthday: DateTime.now(),
  // designedForFamilies: false,
  // gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);


BannerAd _bannerAd;
InterstitialAd _interstitialAd;

BannerAd createBannerAd(){
  return BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: Platform.isAndroid
        ? 'ca-app-pub-3568261915655391/8470243819' //'ca-app-pub-3940256099942544/6300978111' test interestial ad
        : 'ca-app-pub-3568261915655391/3008542880',
  size: AdSize.smartBanner,               //AdSize.smartBanner
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);
}

InterstitialAd createInterstitialAd(){
  return InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: Platform.isAndroid
        ? 'ca-app-pub-3568261915655391/7552516456' //'ca-app-pub-3940256099942544/1033173712' test ad id
        : 'ca-app-pub-3568261915655391/2816971190',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);
}

@override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: admobId());
_bannerAd = createBannerAd() .. load() ..show();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('A-Z'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        // _interstitialAd = createInterstitialAd() .. load() .. show();
                        // navigate to next screen
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(_words[index])));
                      },
                      child: CardItems(index,_words[index].word, _words[index].picture),
                    );
                  },
                  childCount: _words.length,
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FancyFab(),
    );
  }
}

// class CardItems extends StatelessWidget {
//   final int index;
//   final String item;
//   CardItems(this.index,this.item);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       color: Colors.teal[100 * (index % 9)],
//       child: Text(item,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
//     );
//   }
// }
class CardItems extends StatelessWidget {
  final int index;
  final String pic;
  final String word;
  CardItems(this.index,this.word, this.pic);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal[100 * (index % 9)],
      child: Hero(
        transitionOnUserGestures: true,
        tag: '$word',
        child: Image.network(pic)
        // Image(
        //         image: AssetImage('images/appleTree.jpg'),
        //         fit: BoxFit.fill,
        //       ),
      ),
      // child: Text(
      //   item,
      //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      // ),
    );
  }
}