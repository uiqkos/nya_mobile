import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nya_mobile/data/nya_api.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

class NyaReportsPage extends StatefulWidget {
  const NyaReportsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NyaReportsPageState();
}

class _NyaReportsPageState extends State<NyaReportsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final List<NyaReport> data;
  late NyaReport report;
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    var text = """# Nyaural Nyatworks

Мобильный клиент к сервису Nyaural Nyatworks by [uiqkos](https://github.com/uiqkos).
    
## Функционал
* Анализ токсичности
* Анализ эмоцианольной окраски
* Информация о моделях и датасетах
* Использование нескольких социальных сетей в качестве источника
## Спринты
* [3 спринт.pdf](https://drive.google.com/file/d/10YDX3f46g3BK9lTlMCMkKHoJJCBeaadI/view?usp=sharing)
* [4 спринт.pdf](https://drive.google.com/file/d/10b4MF-Pj8Ggp6u_qfvfsQmLcR8NOP7pH/view?usp=sharing)
* [5 спринт.pdf](https://drive.google.com/file/d/10pgA78zsIYeJ5mIzX_PGUplpHo_6xqvp/view?usp=sharing)
""" * 10;
    //data = await NyaApi(NyaPrefs.instance.getString('api_url')!).reports();
    data = [
      NyaReport.fromJson({'name': "Name", 'title': "Title", 'text': "1\n" + text, 'tags': [{'name': 'name', 'grad': 12}]}),
      NyaReport.fromJson({'name': "Name", 'title': "Title", 'text': "1\n" + text, 'tags': [{'name': 'name', 'grad': 12}]}),
      ];
    report = data.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Содержание",
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).textTheme.headline6?.color,),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: Drawer(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            var chapters = data[index].chapters;
            return Column(
              children: [
                ListTile(
                  title: Text(
                    data[index].name,
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.left,
                  )
                ),
                Column(
                  children: List.generate(
                    chapters.length,
                    (i) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              chapters[i].name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            onTap: () {
                              setState(() {
                                report = data[index];
                                itemScrollController.scrollTo(
                                  index: i,
                                  duration: const Duration(milliseconds: 500),
                                );
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                          const Divider(
                            color: Color(0x2E0C1914),
                            thickness: 2,
                          ),
                        ],
                      );
                    }
                  ),
                )
              ]
            );
          }
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ScrollablePositionedList.builder(
          itemCount: report.chapters.length,
          itemBuilder: (context, index) {
            return MarkdownBody(
              data: report.chapters[index].text,
              onTapLink: (text, url, title) {
                _launchURL(url!);
              },
            );
          },
          itemScrollController: itemScrollController
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}