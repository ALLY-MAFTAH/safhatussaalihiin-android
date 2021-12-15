import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safhatussaalihiin/providers/data_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Safhatussaalihiin extends StatefulWidget {
   final DataProvider dataProvider;

  const Safhatussaalihiin({Key? key, required this.dataProvider}) : super(key: key);
  @override
  _SafhatussaalihiinState createState() => _SafhatussaalihiinState();
}

class _SafhatussaalihiinState extends State<Safhatussaalihiin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator( backgroundColor: Colors.brown,
      color: Colors.white,
     
        onRefresh: _reloadPage,
        child: Container(
            child: ListView(
          children: [
            Image(
              image: AssetImage("assets/icons/safhatussaalihiin.png"),
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: CircleAvatar(
                      backgroundColor: Colors.blue[400],
                      child: Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      String socialUrl = "https://twitter.com/salafitz1?s=09";
                      _launchURL(socialUrl);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: CircleAvatar(
                      backgroundColor: Colors.purple[800],
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      String socialUrl =
                          "https://www.instagram.com/safhatussaalihiin/";
                      _launchURL(socialUrl);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      var phone = "+255718656210";
                      String socialUrl = "whatsapp://send?phone=$phone";
                      _launchURL(socialUrl);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlue[700],
                      child: Icon(
                        FontAwesomeIcons.telegramPlane,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      String socialUrl = "https://t.me/safhatussaalihiin";
                      _launchURL(socialUrl);
                    },
                  ),
                )
              ],
            ),
            Divider(
                indent: 100, thickness: 2, endIndent: 100, color: Colors.brown),
            Container(
              height: 300,
              // width: 5,
              child: Image(
                  fit: BoxFit.fitHeight,
                  image: AssetImage("assets/images/Picture5.png")),
            ),
          ],
        )));
  }

  void _launchURL(String linkUrl) async {
    if (await canLaunch(linkUrl)) {
      await launch(linkUrl);
    } else {
      throw 'Could not launch $linkUrl';
    }
  }

  Future<void> _reloadPage() async {
    setState(() {
      widget.dataProvider.setPosts = [];
      widget.dataProvider.setTodayPosts = [];
      widget.dataProvider.setRadioList = [];
      widget.dataProvider.setStreams = [];
      widget.dataProvider.getAllPosts();
      widget.dataProvider.getAllStreams();
    });
  }
}
