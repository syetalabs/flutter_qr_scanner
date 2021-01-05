import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _goTo(String route) {
      Navigator.of(context).pushNamed(route);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Select a method"),
              _optionButton(
                heading: "Scan QR/Barcode",
                icon: Icon(Icons.camera),
                onPressed: (){
                  _goTo("/scan");
                }
              ),
              _optionButton(
                heading: "Capture an image",
                icon: Icon(Icons.camera_alt),
                onPressed: (){
                  _goTo("/scan");
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionButton({String heading, Function onPressed, Widget icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: FlatButton(
        color: Colors.blue,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            icon,
            Text(
              heading,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
