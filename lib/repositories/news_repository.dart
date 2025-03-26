import '../models/article_model.dart';
import '../models/news_response.dart';
import '../services/api_service.dart';

class NewsRepository {
  final ApiService apiService;

  NewsRepository({required this.apiService});

  Future<List<Article>> fetchNews({
    String category = 'general',
    int page = 1,
    String? query,
  }) async {
    final response = await apiService.fetchNews(
      category: category,
      page: page,
      query: query,
    );

    final newsResponse = NewsResponse.fromJson(response);
    return newsResponse.articles;
  }
}
