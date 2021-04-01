import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Multi image Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Asset> imageList = List<Asset>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            imageList.isEmpty
                ? Container()
                : Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Asset asset = imageList[index];
                          return AssetThumb(
                              asset: asset, width: 300, height: 300);
                        }),
                  ),
            OutlineButton(
              borderSide: BorderSide(color: Colors.blue[200], width: 3),
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 250,
                child: Text(
                  '갤러리',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: () {
                getImage();
              },
            )
          ],
        ),
      ),
    );
  }

  getImage() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 10, enableCamera: true, selectedAssets: imageList);
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }

    setState(() {
      imageList = resultList;
    });
  }
}
