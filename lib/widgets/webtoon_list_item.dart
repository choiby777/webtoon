import 'package:flutter/material.dart';

import '../models/webtoon.dart';
import '../screens/detail_screen.dart';

class WebtoonListItem extends StatelessWidget {
  const WebtoonListItem({
    Key? key,
    required this.webtoon,
  }) : super(key: key);

  final WebToon webtoon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTabItem(context),
      child: Column(
        children: [
          Hero(
            tag: webtoon.id,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(10, 10),
                  )
                ],
              ),
              height: 200,
              child: Image.network(webtoon.thumb),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(webtoon.title),
        ],
      ),
    );
  }

  void onTabItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebtoonDetail(webtoon: webtoon),
        fullscreenDialog: true,
      ),
    );
  }
}
