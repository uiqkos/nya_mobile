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
  Widget expandComment(
      NyaComment comment,
      NyaPredictRequestModel requestModel
  ) {
    var widgets = <Widget>[];

    widgets.add(NyaCommentWidget(comment: comment));

    for (var childComment in comment.comments) {
      widgets.add(expandComment(childComment, requestModel));
    }

    if (comment.commentCount > comment.comments.length) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child:
            SizedBox(
              width: 200,
              height: 40,
              child: TextButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_downward_rounded,
                        size: 17,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                          (comment.comments.isEmpty) ? ' показать комментарии' : ' показать больше',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        )
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty
                        .all<Color>(Colors.transparent),
                    overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey[200]!)
                  ),
                  onPressed: () {
                    var path = comment.path.join('/');
                    requestModel.nextPage(path);
                  }),
            )
        )
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: comment.level > 0 ? 20.0 : 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var requestModel = context.watch<NyaPredictRequestModel>();

    return FutureBuilder<NyaComment?>(
        future: NyaCacherProvider.provide('request').getCache(
            requestModel.request.toString(),
            requestModel.getComments
        ),
        builder: (
            BuildContext context,
            AsyncSnapshot<NyaComment?> snapshot
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

          if (snapshot.connectionState == ConnectionState.waiting) {
            if (requestModel.rootComment == null) {
              return const Image(
                  image: AssetImage('assets/images/catloading.gif'));
            }
          }

          NyaComment? comment;

          if (snapshot.hasError) {
            print(snapshot.stackTrace.toString());
            return idk(snapshot.error.toString());

          } else if (snapshot.hasData) {
            comment = snapshot.data!;

          } else {
            return idk('Результатов пока нет');

          }

          return Scaffold(
            body: SingleChildScrollView(
              child: expandComment(comment, requestModel)
            )
          );
        });
  }
}
