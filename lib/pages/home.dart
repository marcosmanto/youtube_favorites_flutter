import 'package:flutter/material.dart';
import 'package:youtube_favorites_flutter/delegates/data_search.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset('assets/yt_logo_rgb_dark.png'),
        ),
        elevation: 0,
        actions: [
          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset(0, 2.25),
              child: Text('0'),
            ),
          ),
          SizedBox(
            width: 30,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(Icons.star),
            ),
          ),
          IconButton(
            onPressed: () async {
              String? result =
                  await showSearch(context: context, delegate: DataSearch());
              print(result);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
