import 'package:medbot/models/article_model.dart';
import 'package:medbot/pages/article_screen.dart';
import 'package:medbot/widgets/bottom_nav_bar-this-one-i-think.dart';
import 'package:medbot/widgets/image_container.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});
  static const routeName = '/search';
  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Global', 'Local', 'Developing', 'Interesting'];
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Search.routeName);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(index: 0),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [const _SearchNews(), _CategoryNews(tabs: tabs)],
        ),
      ),
    );
  }
}

class _CategoryNews extends StatelessWidget {
  const _CategoryNews({
    super.key,
    required this.tabs,
  });

  final List<String> tabs;
  @override
  Widget build(BuildContext context) {
    final articles = Article.articles;
    return Column(
      children: [
        TabBar(
            isScrollable: true,
            indicatorColor: Colors.black,
            tabs: tabs
                .map(
                  (tab) => Tab(
                    icon: Text(
                      tab,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
                .toList()),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: TabBarView(
            children: tabs
                .map((tab) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: (() {
                            Navigator.pushNamed(
                                context, ArticleScreen.routeName,
                                arguments: articles[index]);
                          }),
                          child: Row(
                            children: [
                              ImageContainer(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.all(10),
                                borderRadius: 5,
                                imageUrl: articles[index].imageUrl,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      articles[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.schedule,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${DateTime.now().difference(articles[index].createdAt).inHours} hours ago',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}

class _SearchNews extends StatelessWidget {
  const _SearchNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Discover',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Health news around the world',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
            ),
          )
        ],
      ),
    );
  }
}
