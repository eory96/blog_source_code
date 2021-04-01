import 'package:flutter/material.dart';

class HeroPage extends StatefulWidget {
  @override
  _HeroPage createState() => _HeroPage();
}

class _HeroPage extends State<HeroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HeroDetail Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hero animation이 작동이 됐습니다."),
            Hero(
              tag: "flutter",
              child: FlutterLogo(
                size: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}
