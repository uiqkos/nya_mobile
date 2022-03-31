import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class NyaReportsPage extends StatefulWidget {
  const NyaReportsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NyaReportsPageState();
}

class _NyaReportsPageState extends State<NyaReportsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String _string ="""
  ## Api
  ### Модели

  `GET` /models/ - список моделей
  #### Пример ответа
  ### Анализ
  `GET` /predict/
  #### Параметры
  - **input**: тип ввода (auto, vk, youtube, ...)
  - **text**: что анализировать (текст или ссылка)
  - **toxic**: local_name модели анализа токсичности
  - **sentiment**: local_name модели анализа эмоциональности
  - **sarcasm**: local_name модели анализа саркастичности
  - **page**: номер страницы для пагинации (если 0, то все комментарии на одной странице)
  - **per_page**: количество комментариев на странице
  - **styled(временно)**: добавить стили для комментария
  - **stats(временно)**: добавить стили для общей оценки
  ### Пример ответа
  """;

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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Markdown(
        data: _string,
      )
    );
  }
}