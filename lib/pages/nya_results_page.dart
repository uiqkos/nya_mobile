import 'package:flutter/material.dart';
import 'package:nya_mobile/data/nya_caching.dart';
import 'package:nya_mobile/data/nya_request_model.dart';
import 'package:nya_mobile/widgets/comments/nya_comment_widget.dart';
import 'package:provider/provider.dart';

import '../data/nya_comment.dart';

class NyaResultsPage extends StatefulWidget {

  NyaResultsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NyaResultsPageState();
}

class _NyaResultsPageState extends State<NyaResultsPage> {

  @override
  Widget build(BuildContext context) {
    var requestModel = context.watch<NyaPredictRequestModel>();

    return FutureBuilder<List<NyaComment>?>(
        future: NyaCacherProvider.provide('request').getCache(
            requestModel.request.toString(),
            requestModel.getComments
        ),
        builder: (
            BuildContext context,
            AsyncSnapshot<List<NyaComment>?> snapshot
        ) {
          idk(String message) => Padding(
                padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(message,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4),
                    const Image(image: AssetImage('assets/images/idk.png')),
                  ],
                )
            );

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return idk('Результатов пока нет');

            case ConnectionState.waiting:
              return const Image(image: AssetImage('assets/images/catloading.gif'));

            default:
              var comments = <NyaComment>[];
              if (snapshot.hasError) {
                print(snapshot.stackTrace.toString());
                return idk(snapshot.error.toString());
              } else if (snapshot.hasData) {
                comments = snapshot.data!;
              } else {
                return idk('Результатов пока нет');
              }

              var children = <Padding>[];

              for (var comment in comments) {
                children.add(Padding(
                    padding: EdgeInsets.only(left: 30.0 * comment.level),
                    child: Column(
                      children: [
                        NyaCommentWidget(comment: comment),
                        if (comment.comments > 0)
                          SizedBox(
                            width: 120,
                            height: 30,
                            child: TextButton(
                                child: const Text(
                                    'показать комментарии',
                                    style: TextStyle(fontSize: 10)
                                ),
                                onPressed: () {
                                  var path = comment.path.join('/');
                                  requestModel.nextPage(path);
                                }),
                          )
                        ]
                      ),
                    ));
              }

              return Scaffold(
                  body: SingleChildScrollView(
                      child: Column(
                          children: children
                      )
                  )
              );
          }
        });
  }
}
