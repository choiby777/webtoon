import 'package:flutter/material.dart';
import 'package:webtoon/services/api_services.dart';
import '../models/webtoon.dart';
import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';

class WebtoonDetail extends StatefulWidget {
  final WebToon webtoon;
  const WebtoonDetail({super.key, required this.webtoon});

  @override
  State<WebtoonDetail> createState() => _WebtoonDetailState();
}

class _WebtoonDetailState extends State<WebtoonDetail> {
  late Future<WebtoonDetailModel> detailInfo;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    detailInfo = ApiService.getToonById(widget.webtoon.id);
    episodes = ApiService.getLatestEpisodesById(widget.webtoon.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.webtoon.title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            getThumbImage(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getDetailInfo(),
                  const SizedBox(
                    height: 20,
                  ),
                  getEpisodes(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<WebtoonEpisodeModel>> getEpisodes() {
    return FutureBuilder(
      future: episodes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return getEpisodeListView(snapshot.data!);
        } else {
          return const Text('...');
        }
      },
    );
  }

  ListView getEpisodeListView(List<WebtoonEpisodeModel> episodes) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) {
        var episode = episodes[index];
        return getEpisodeListItem(episode);
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: episodes.length,
    );
  }

  Container getEpisodeListItem(WebtoonEpisodeModel episode) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              episode.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            const Icon(
              Icons.navigate_next,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<WebtoonDetailModel> getDetailInfo() {
    return FutureBuilder(
      future: detailInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snapshot.data!.about,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${snapshot.data!.genre} / ${snapshot.data!.age}',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          );
        } else {
          return const Text('...');
        }
      },
    );
  }

  Row getThumbImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: widget.webtoon.id,
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
            child: Image.network(widget.webtoon.thumb),
          ),
        ),
      ],
    );
  }
}
