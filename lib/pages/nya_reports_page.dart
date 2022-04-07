import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nya_mobile/data/nya_api.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/nya_caching.dart';
import '../prefs/nya_prefs.dart';

class NyaReportsPage extends StatefulWidget {
  const NyaReportsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NyaReportsPageState();
}

class _NyaReportsPageState extends State<NyaReportsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemScrollController itemScrollController = ItemScrollController();
  final String baseUrl = NyaPrefs.getInstance().getString('api_url')!;
  NyaReport? report;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NyaCacherProvider
          .provide('reports')
          .getCache('reports', NyaApi(baseUrl).reports),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<NyaReport>> snapshot
      ) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Empty');

          case ConnectionState.waiting:
            return const Image(
                image: AssetImage('assets/images/catloading.gif'));

          default:
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.hasData) {
              var reports = snapshot.data!;
              report ??= reports.first;

              return Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    title: Text(
                      "Содержание",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).textTheme.headline6?.color,
                      ),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                  drawer: Drawer(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        var chapters = reports[index].chapters;
                        return Column(children: [
                          ListTile(
                            title: Text(
                              reports[index].title,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.left,
                            )
                          ),
                          Column(
                            children: List.generate(chapters.length, (i) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      '${i + 1}.' + chapters[i].name,
                                      // style: Theme.of(context).textTheme.headline1,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        report = reports[index];
                                        itemScrollController.scrollTo(
                                          index: i + 1,
                                          duration: const Duration(
                                              milliseconds: 500),
                                        );
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                  // const Divider(
                                  //   color: Color(0x2E0C1914),
                                  //   thickness: 2,
                                  // ),
                                ],
                              );
                            }),
                          )
                        ]);
                      })),
                  body: ScrollablePositionedList.builder(
                      itemCount: report!.chapters.length + 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MarkdownBody(
                            data: (index > 0)
                                ? report!.chapters[index - 1].text
                                : '# **' + report!.title + '**',
                            onTapLink: (text, url, title) {
                              _launchURL(url!);
                            },
                            imageBuilder: (Uri uri, String? title, String? alt) {
                              return Image.network(baseUrl + 'static/' + uri.toString());
                            },
                          ),
                        );
                      },
                      itemScrollController: itemScrollController),
                );
            }

            throw Exception();
          }
      }
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}