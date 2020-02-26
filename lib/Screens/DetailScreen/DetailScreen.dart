import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
// import 'package:lwp/Screens/Common/fancy_fab.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lwp/Model/WordModel.dart';

class DetailScreen extends StatefulWidget {
  final Word _word;
  DetailScreen(this._word);

  @override
  _DetailScreenState createState() => _DetailScreenState(this._word);
}

enum TtsState { playing, stopped }

class _DetailScreenState extends State<DetailScreen> {
  final Word _word;
  _DetailScreenState(this._word);

  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;
  int silencems;
  // String _newVoiceText = "Hello Kishor";

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  String admobId() => Platform.isAndroid
      ? 'ca-app-pub-3568261915655391~9783325485'
      : 'ca-app-pub-3568261915655391~4433305191';

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['Education', 'Learning, Picture, A-Z'],
    contentUrl: 'https://flutter.io',
    childDirected: true,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3568261915655391/8470243819'
          : 'ca-app-pub-3568261915655391/3008542880',
      size: AdSize.mediumRectangle, //AdSize.smartBanner
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: admobId());
    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show();
    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3568261915655391/8470243819'
          : 'ca-app-pub-3568261915655391/3008542880',
      size: AdSize.largeBanner, //AdSize.smartBanner
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.loaded) {
          // dispose after you received the loaded event seems okay.
          if (mounted) {
            _bannerAd..show();
          } else {
            _bannerAd = null;
          }
        }
      },
    )..load();
    _bannerAd?.dispose();

    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    if (Platform.isAndroid) {
      flutterTts.ttsInitHandler(() {
        _getLanguages();
        _getVoices();
      });
    } else if (Platform.isIOS) {
      _getLanguages();
      _getVoices();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak() async {
    if (_word.word != null) {
      if (_word.word.isNotEmpty) {
        var result = await flutterTts.speak(_word.word);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    if (voices != null) setState(() => voices);
  }

//  Future _stop() async {
//    var result = await flutterTts.stop();
//    if (result == 1) setState(() => ttsState = TtsState.stopped);
//  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_word.word),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () => {_speak()},
          )
        ],
      ),
      body: SafeArea(
        child: Container(
            // padding: EdgeInsets.all(10),
            child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: _word.word,
                  child: CachedNetworkImage(
                    imageUrl: _word.picture,
                    placeholder: (context, url) => Image.asset(
                        'images/loading.gif'), //CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )),
            SizedBox(height: 15),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height * 0.12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _word.word,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      children: <Widget>[
                        Text(_word.desc, style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Expanded(
            //   child:
            // ),
          ],
        )),
      ),
      // floatingActionButton: FancyFab(),
    );
  }
}

class CardItems extends StatelessWidget {

  final int index;
  final String item;
  CardItems(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.teal[100 * (index % 9)],
        child: Row(
          children: <Widget>[
            Text(
              item,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            RaisedButton(
              onPressed: () => {},
              child: Text('Disabled Button', style: TextStyle(fontSize: 20)),
            ),
          ],
        ));
  }
}
