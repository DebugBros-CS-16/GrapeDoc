import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  static const String feedUrl = 'https://rss.app/feeds/U8RqsLqe7qvZTkos.xml';
  late RssFeed _feed;
  late GlobalKey<RefreshIndicatorState> _refreshKey;
  bool _isLoading = false;

  Future<RssFeed?> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(feedUrl));
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  load() async {
    loadFeed().then((result) {
      updateFeed(result);
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
      _isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    load();
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return CachedNetworkImage(
      placeholder: (context, url) =>
          Image.asset("assets/images/grapedoclogo.png"),
      imageUrl: imageUrl,
      height: 90,
      width: 70,
      alignment: Alignment.center,
      fit: BoxFit.fill,
    );
  }

  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed.items?.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items![index];
        String? _url = item.link;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            title: title(item.title),
            subtitle: subtitle(DateFormat('yyyy MMM dd - kk:mm')
                .format(item.pubDate as DateTime)),
            leading: thumbnail(item.enclosure?.url),
            trailing: rightIcon(),
            contentPadding: EdgeInsets.all(5.0),
            onTap: () => openFeed(_url!),
          ),
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover more..."),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions:[
          IconButton(
              onPressed: null,
              padding: const EdgeInsets.only(right: 20.0),
              icon: const Icon(Icons.wb_incandescent_sharp, color: Colors.white,)),
        ],
      ),
      body: _isLoading == true ? body(): Center(child:CircularProgressIndicator()),
    );
  }
}
