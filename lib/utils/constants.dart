class AppConstants {
  static const String apiKey = '087bf35175fa469caa66931ff97432e5';
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String country = 'us';
  static const int pageSize = 20;

  static const List<String> categories = [
    'general',
    'business',
    'technology',
    'sports',
    'entertainment',
    'health',
    'science',
  ];

  static const Map<String, String> categoryIcons = {
    'general': 'assets/icons/general.png',
    'business': 'assets/icons/business.png',
    'technology': 'assets/icons/tech.png',
    'sports': 'assets/icons/sports.png',
    'entertainment': 'assets/icons/entertainment.png',
    'health': 'assets/icons/health.png',
    'science': 'assets/icons/science.png',
  };
}
