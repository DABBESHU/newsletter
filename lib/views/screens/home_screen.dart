import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/news_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../utils/constants.dart';
import '../widgets/article_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_indicator.dart';
import 'news_detail_screen.dart'; // Ensure this is the correct path to NewsDetailScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<NewsController>(context, listen: false).fetchNews();
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<NewsController>(context);
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'NewsWave',
        actions: [
          IconButton(
            icon: Icon(
              themeController.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              themeController.toggleTheme(
                themeController.themeMode != ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.categories.length,
              itemBuilder: (context, index) {
                final category = AppConstants.categories[index];
                return CategoryChip(
                  label: category,
                  isSelected: newsController.selectedCategory == category,
                  onSelected: () {
                    newsController.changeCategory(category);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await newsController.fetchNews(refresh: true);
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: newsController.articles.length + 1,
                itemBuilder: (context, index) {
                  if (index < newsController.articles.length) {
                    final article = newsController.articles[index];
                    return ArticleCard(
                      article: article,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => NewsDetailScreen(article: article),
                          ),
                        );
                      },
                    );
                  } else if (newsController.isLoading) {
                    return const LoadingIndicator();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
