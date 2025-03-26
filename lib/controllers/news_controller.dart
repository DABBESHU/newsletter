import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../repositories/news_repository.dart';

class NewsController with ChangeNotifier {
  final NewsRepository repository;

  NewsController({required this.repository});

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _selectedCategory = 'general';
  String get selectedCategory => _selectedCategory;

  int _currentPage = 1;
  bool _hasMore = true;

  Future<void> fetchNews({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
    }

    if (!_hasMore || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newArticles = await repository.fetchNews(
        category: _selectedCategory,
        page: _currentPage,
      );

      if (refresh) {
        _articles = newArticles;
      } else {
        _articles.addAll(newArticles);
      }

      if (newArticles.length < 20) {
        _hasMore = false;
      } else {
        _currentPage++;
      }
    } catch (e) {
      debugPrint('Error fetching news: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void changeCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      _articles = [];
      _currentPage = 1;
      _hasMore = true;
      fetchNews(refresh: true);
    }
  }
}
