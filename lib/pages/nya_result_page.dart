import 'package:fluent_ui/fluent_ui.dart';

import '../data/nya_api.dart';
import '../widgets/comments/nya_comment_widget.dart';

class NyaResultPage extends StatelessWidget {
  const NyaResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              NyaCommentWidget(
                comment: NyaComment(
                  id: "",
                  text: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal',
                  author: NyaAuthor(name: 'Lost', photoUrl: 'https://steamuserimages-a.akamaihd.net/ugc/957471226141680749/E6FC3A96964FDED4009F393582B9599E31076A32/?imw=512&amp;imh=512&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true'),
                  date: DateTime.now(),
                  level: 0,
                  predictions: {
                    'toxic': NyaPrediction(
                        'no toxic',
                        99,
                        1
                    ),
                    'sentiment': NyaPrediction(
                      'positive',
                      56,
                      1
                    ),
                    'sarcasm': NyaPrediction(
                      'sarcasm',
                      62,
                      0
                    )
                  }
                )
              ),
              NyaCommentWidget(
                comment: NyaComment(
                  id: "",
                  text: 'Are you okay man???',
                  author: NyaAuthor(name: 'Micha`el', photoUrl: 'https://static.tumblr.com/9ba4a620adbbd4f563070ee8ebe19df7/zjmqr0n/ANImubwng/tumblr_static_rei.jpg'),
                  date: DateTime.now(),
                  level: 0,
                  predictions: {
                    'toxic': NyaPrediction(
                        'no toxic',
                        86,
                        1
                    ),
                    'sentiment': NyaPrediction(
                      'netrual',
                      99,
                      0.5
                    ),
                    'sarcasm': NyaPrediction(
                      'no sarcasm',
                      62,
                      1
                    )
                  }
                )
              ),
              NyaCommentWidget(
                comment: NyaComment(
                  id: "",
                  text: 'FAAAAAAAAAAAAAAAAAAAAAAAAACk you',
                  author: NyaAuthor(name: 'Lost', photoUrl: 'https://steamuserimages-a.akamaihd.net/ugc/957471226141680749/E6FC3A96964FDED4009F393582B9599E31076A32/?imw=512&amp;imh=512&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true'),
                  date: DateTime.now(),
                  level: 0,
                  predictions: {
                    'toxic': NyaPrediction(
                        'toxic',
                        99,
                        0
                    ),
                    'sentiment': NyaPrediction(
                      'negative',
                      99,
                      0
                    ),
                    'sarcasm': NyaPrediction(
                      'sarcasm',
                      62,
                      0
                    )
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}