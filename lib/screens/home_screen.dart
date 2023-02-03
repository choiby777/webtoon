import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon.dart';
import 'package:webtoon/services/api_services.dart';

import '../widgets/webtoon_list_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  Future<List<WebToon>> webtoons = ApiService.getTodaysToons();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'WebToon',
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return makeGridView(snapshot);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  GridView makeGridView(AsyncSnapshot<List<WebToon>> snapshot) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      itemCount: snapshot.data?.length, //item 개수
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
        childAspectRatio: 0.7, //item 의 가로 1, 세로 2 의 비율
        mainAxisSpacing: 10, //수평 Padding
        crossAxisSpacing: 10, //수직 Padding
      ),
      itemBuilder: (BuildContext context, int index) {
        //item 의 반목문 항목 형성
        return WebtoonListItem(webtoon: snapshot.data![index]);
      },
    );
  }

  ListView makeList(AsyncSnapshot<List<WebToon>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebtoonListItem(webtoon: webtoon);
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: snapshot.data!.length,
    );
  }
}
