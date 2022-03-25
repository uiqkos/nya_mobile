import 'package:flutter/material.dart';
import 'package:nya_mobile/widgets/comments/nya_comment_widget.dart';
import 'package:provider/provider.dart';
import 'package:nya_mobile/data/nya_request_model.dart';

import '../data/nya_api.dart';
import '../data/nya_comment.dart';
import '../data/nya_predict_response.dart';

class NyaResultsPage extends StatefulWidget {
  final List<NyaComment> comments = [];

  NyaResultsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NyaResultsPageState();
}

class _NyaResultsPageState extends State<NyaResultsPage> {
  @override
  Widget build(BuildContext context) {
    var requestModel = context.watch<NyaPredictRequestModel>();

    late Widget content;

    if (requestModel.isEmpty) {
      content = Padding(
        padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Результатов пока нет', style: Theme
                .of(context)
                .textTheme
                .headline4),
            const Image(image: AssetImage('assets/images/idk.png')),
          ],
        )
      );
    } else {
      content = FutureBuilder<NyaPredictResponse>(
        future: requestModel.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.stackTrace);
            print(snapshot.error);
          }
          else if (snapshot.hasData) {
            var response = snapshot.data!;
            var insertIndex = 0;
            var path = List.from(response.path);

            while (path.isNotEmpty) {
              var parentId = path.removeAt(0);

              while (
                insertIndex < widget.comments.length
              ) {

                if (widget.comments.elementAt(insertIndex).id != parentId) {
                  insertIndex += 1;
                  break;
                }
                insertIndex += 1;
              }

            }

            widget.comments.insertAll(insertIndex, response.items);
          }

          var children = <Padding>[];

          for (var comment in widget.comments) {
            children.add(
              Padding(
                padding: EdgeInsets.only(left: 30.0 * comment.level),
                child: Column(
                  children: [
                    NyaCommentWidget(comment: comment),
                    SizedBox(
                      width: 120,
                      height: 30,
                      child: TextButton(
                        child: const Text('Провести анализ', style: TextStyle(
                          fontSize: 10,
                        ),),
                        onPressed: () {
                          print(comment.path.join('/'));
                          requestModel.updateExpandPath(comment.path.join('/'));
                        }
                      ),
                    ),
                  ],
                )
              )
            );
          }

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: children
              )
            )
          );
        }
      );
    }

    return content;
  }
}
