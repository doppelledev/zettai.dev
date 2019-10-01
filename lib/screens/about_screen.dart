import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_app/style.dart';
import 'package:universal_html/html.dart' as html;

class AboutScreen extends StatelessWidget {
  final String about;

  AboutScreen(this.about);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 40,
                child: Container(),
              ),
              if (width > 800)
                Expanded(
                  flex: 60,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Image.asset(
                      'assets/images/about.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
          Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 40,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                AutoSizeText(
                                  'WHO',
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 100.0,
                                    color: myGrey,
                                  ),
                                ),
                                Text(
                                  about ?? '',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: myGrey,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      html.window.open(
                                          'https://twitter.com/AbdouOuahib',
                                          'radnomname1');
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.twitter,
                                      color: myGrey,
                                      size: 30.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      html.window.open(
                                          'https://fb.com/abdou.ii.ouahib',
                                          'radnomname2');
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.facebook,
                                      size: 30.0,
                                      color: myGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (width > 800)
                        Expanded(
                          flex: 60,
                          child: Container(),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
