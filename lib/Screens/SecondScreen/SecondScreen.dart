import 'package:flutter/material.dart';
import 'package:lwp/Screens/DetailScreen/DetailScreen.dart';
// import 'package:lwp/Screens/Common/fancy_fab.dart';
import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:lwp/Model/WordModel.dart';

var adCount = 0;

class SecondScreen extends StatefulWidget {
  final WordModel _alphabet;
  SecondScreen(this._alphabet);

  @override
  _SecondScreenState createState() => _SecondScreenState(_alphabet);
}

class _SecondScreenState extends State<SecondScreen> {
  final WordModel _alphabet;
  _SecondScreenState(this._alphabet);

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

  BannerAd createBannerAd() {
    return BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3568261915655391/8470243819' //'ca-app-pub-3940256099942544/6300978111' test interestial ad
          : 'ca-app-pub-3568261915655391/3008542880',
      size: AdSize.smartBanner, //AdSize.smartBanner
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
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
    _bannerAd = createBannerAd()
      ..load()
      ..show();
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
        title: Text(_alphabet.latter + " is for ..."),
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
                      onTap: () {
                        print("adCount: $adCount");
                        if(adCount == 3){
                          _bannerAd?.dispose();
                          _interstitialAd = createInterstitialAd()
                          ..load()
                          ..show();
                          adCount = 0;
                        }else{
                          adCount += 1; 
                        }

                        // navigate to next screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(_alphabet.words[index])));
                      },
                      child: CardItems(index, _alphabet.words[index].word,
                          _alphabet.words[index].picture),
                    );
                  },
                  childCount: _alphabet.words.length,
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

class CardItems extends StatelessWidget {
  final int index;
  final String pic;
  final String word;
  CardItems(this.index, this.word, this.pic);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black12)),
      // alignment: Alignment.center,

      child: Hero(
          transitionOnUserGestures: true,
          tag: '$word',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'images/loading.gif',
                    image: pic,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // SizedBox(height: 2,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Colors.blue,
                      Colors.white,
                      // Colors.black.withAlpha(0),
                      // Colors.black12,
                      // Colors.black45
                    ],
                  ),
                ),
                padding: EdgeInsets.only(left: 10, top: 1),
                height: 25,
                child: Text(word,
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ],
          )
          // ClipRRect(
          //   borderRadius: new BorderRadius.circular(10),
          //   child: FadeInImage.assetNetwork(
          //     placeholder: 'images/loading.gif',
          //     image: pic,
          //     fit: BoxFit.fill,
          //   ),
          // )
          ),
    );
  }
}
