import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/nya_comment.dart';

class NyaCommentWidget extends StatelessWidget {
  final NyaComment comment;

  const NyaCommentWidget({required this.comment, Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  backgroundImage: comment.author.photoUrl == null
                      ? const AssetImage(
                      'assets/images/noavatar.jpg') as ImageProvider
                      : NetworkImage(comment.author.photoUrl!)
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.author.name + ' ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    Text(' '
                        + DateFormat('yyyy-MM-dd').format(comment.date)
                        + ' в '
                        + DateFormat('hh:mm').format(comment.date),
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: comment.predictions.map<Widget>((e) => NyaTagWidget
                          .fromGrad(e.grad, ' ' + e.label + ' ' + e.percent.toString() + ' ')
                      ).toList()
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                          comment.text,
                          style: const TextStyle(fontSize: 18)
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NyaTagWidget extends StatelessWidget {
  final Color color;
  final String text;

  const NyaTagWidget({
    required this .color,
    required this .text,
    Key? key
  }) : super(key: key);

  static NyaTagWidget fromGrad(int grad, String text)
    => NyaTagWidget(color: _floatColor(grad), text: text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
    );
  }

  static Color _floatColor(int grad) {
    if (grad == 1) return Colors.blue;
    if (grad == 0) return Colors.green;
    if (grad == 2) return Colors.red;
    return Colors.purple;
  }

}
