import 'package:flutter/material.dart';
import 'package:lwp/Screens/SecondScreen/SecondScreen.dart';
// import 'package:lwp/Screens/Common/fancy_fab.dart';
import 'package:lwp/Model/WordModel.dart';
import 'package:lwp/Services/Services.dart';

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

  @override
  void initState() {
    super.initState();
    fetch();
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
                      onTap: () {
                        // navigate to next screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondScreen(_wordModel[index].words)));
                      },
                      child: CardItems(index, _wordModel[index].latter),
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
  final String item;
  CardItems(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal[100 * (index % 9)],
      child: Text(
        item,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
