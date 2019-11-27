import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lwp/Screens/SecondScreen/SecondScreen.dart';
// import 'package:lwp/Screens/Common/fancy_fab.dart';
import 'package:lwp/Model/WordModel.dart';
import 'package:lwp/Services/Services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WordModel> _wordModel = List<WordModel>();
  var _count = 0;

  fetch() async {
    List<WordModel> data = await loadWordModel();

    this.setState(() {
      _wordModel = data;
      _count = _wordModel.length;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enjoying lwp app? '),
            content: Container(
                height: 120,
                child: Column(
                  children: <Widget>[
                    Image.asset('images/rating.jpg'),
                    Center(
                      child: Text(
                          'Rate us 5 star which help other to find it useful.Thanks!'),
                    )
                  ],
                )),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text(
                    'NO THANKS',
                    style: TextStyle(color: Colors.black45),
                  )),
              FlatButton(
                onPressed: () {
                  print('HelloWorld!');
                  // _dismissDialog();
                  launch(
                      "https://play.google.com/store/apps/details?id=com.sanchi.lwp");
                },
                child: Text('5 STARTS'),
              )
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabets'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Colors.blue,
                      Colors.white,
                    ],
                  ),
                ),
                height: 200,
                // color: Colors.blue,
                child: Center(
                  child: Image.asset(
                    'images/logo.png',
                    height: 100,
                    width: 100,
                  ),
                )),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Rate App"),
              leading: Icon(Icons.star),
              onTap: () {
                _showDialog();
              },
            ),
            ListTile(
              title: Text("Share App"),
              leading: Icon(Icons.share),
              onTap: () {
                Share.share('check out this useful app for kids https://play.google.com/store/apps/details?id=com.sanchi.lwp');
              },
            ),
            ListTile(
              title: Text("Feedback"),
              leading: Icon(Icons.feedback),
              onTap: () {
                _launchURL(
                    'mailto:yashmaurya76@gmail.com?subject=LWP Feedback');
              },
            ),
            ListTile(
                title: Text("Privacy Policy"),
                leading: Icon(Icons.insert_drive_file),
                onTap: () {
                  _launchURL(
                      'http://app.passkardo.com/lwp/privacy-policy/index.htm');
                }),
          ],
        ),
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
                        // navigate to next screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SecondScreen(_wordModel[index])));
                      },
                      child: CardItems(index, _wordModel[index].image),
                    );
                  },
                  childCount: _count,
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FancyFab()
    );
  }
}

class CardItems extends StatelessWidget {
  final int index;
  final String image;
  CardItems(this.index, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black12)),
      alignment: Alignment.center,
      // color: Colors.teal[100 * (index % 9)],
      child: CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) =>
            Image.asset('images/loading.gif'), //CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
