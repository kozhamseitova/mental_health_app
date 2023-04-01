import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/src/constants/sizes.dart';

import 'audio.dart';

class AudioItems extends StatelessWidget {
  const AudioItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            AudioItem(),
            SizedBox(height: tDefaultSizeS,)
          ],
        );
      }
    ),
  );
  }
}
