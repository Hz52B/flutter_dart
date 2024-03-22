import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:localstore/localstore.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class Article {
  final String title;
  final String description;
  final String? author;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    required this.title,
    required this.description,
    this.author,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      author: json['author'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'author': author,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}


class NewsApiService {
  Future<List<Article>> fetchNewsWithKeyword(String keyword) async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q=$keyword&from=2024-02-22&sortBy=publishedAt&apiKey=114cd461e71c459e9d7673318ebb9fb4'));
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body);
    List<Article> articles = [];
    if (parsed['articles'] != null) {
      articles = List<Article>.from(
          parsed['articles'].map((article) => Article.fromJson(article)));
    }
    return articles;
  } else {
    throw Exception('Failed to load news with keyword $keyword');
  }
}
  Future<List<Article>> fetchPopularWithKeyword(String keyword) async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=114cd461e71c459e9d7673318ebb9fb4'));
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body);
    List<Article> articles = [];
    if (parsed['articles'] != null) {
      articles = List<Article>.from(
          parsed['articles'].map((article) => Article.fromJson(article)));
    }
    return articles;
  } else {
    throw Exception('Failed to load popular news with keyword $keyword');
  }
}

  Future<List<Article>> fetchPopularHeadlines() async {
    final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=114cd461e71c459e9d7673318ebb9fb4'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      List<Article> articles = [];
      if (parsed['articles'] != null) {
        articles = List<Article>.from(
            parsed['articles'].map((article) => Article.fromJson(article)));
      }
      return articles;
    } else {
      throw Exception('Failed to load popular headlines');
    }
  }

  Future<List<Article>> fetchTopHeadlines() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2024-02-22&sortBy=publishedAt&apiKey=114cd461e71c459e9d7673318ebb9fb4'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      List<Article> articles = [];
      if (parsed['articles'] != null) {
        articles = List<Article>.from(
            parsed['articles'].map((article) => Article.fromJson(article)));
      }
      return articles;
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NewsApiService _newsApiService = NewsApiService();
  late TextEditingController _searchController;
  late List<Article> _articles = [];
  int _selectedIndex = 0;
  
  List<Tab> _tabList = [
  Tab(text: 'Tesla'), 
  Tab(text: 'Country US'), 
];


  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadTopNews(); // Gọi hàm để tải tin tức từ API khi trang được tạo ra
    _tabController = TabController(vsync: this, length: _tabList.length);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      // Cập nhật dữ liệu tùy thuộc vào tab được chọn
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          _loadTopNews();
        } else if (_tabController.index == 1) {
          _loadPopularNews();
        }
      }
    });
  }

  void _loadTopNews() async {
  try {
    List<Article> articles = await _newsApiService.fetchTopHeadlines();
    setState(() {
      _articles = articles;
    });
  } catch (e) {
    print('Error loading top news: $e');
  }
}

void _loadPopularNews() async {
  try {
    List<Article> articles = await _newsApiService.fetchPopularHeadlines();
    setState(() {
      _articles = articles;
    });
  } catch (e) {
    print('Error loading popular news: $e');
  }
}


  void _searchNews(String query) async {
    try {
      List<Article> searchResults;
      // Tùy thuộc vào tab hiện tại, gọi hàm tương ứng để tìm kiếm
      if (_tabController.index == 0) {
        searchResults = await _newsApiService.fetchNewsWithKeyword(query);
      } else if (_tabController.index == 1) {
        searchResults = await _newsApiService.fetchPopularWithKeyword(query);
      }
      // Xử lý kết quả tìm kiếm ở đây
    } catch (e) {
      print('Error searching news: $e');
      // Xử lý lỗi khi tìm kiếm tin tức.
    }
  }

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'News App',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()), // Thay đổi dòng này
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            _searchNews(_searchController.text);
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SavedArticlesPage(),
              ),
            );
          },
          icon: Icon(Icons.bookmark),
        ),
      ],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: _tabList.length,
            child: Column(
              children: [
                TabBar(
                  tabs: _tabList,
                  controller: _tabController,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Widget cho Tab 1 (Top News)
                      ListView.builder(
                        itemCount: _articles.length,
                        itemBuilder: (context, index) {
                          final article = _articles[index];
                          return ListTile(
                            leading: Container(
                              width: 300,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(article.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(article.description),
                                SizedBox(height: 8),
                                Text(
                                  'Published At: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(article.publishedAt!))}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetailPage(article: article),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      // Widget cho Tab 2 (Popular)
                      ListView.builder(
                        itemCount: _articles.length,
                        itemBuilder: (context, index) {
                          final article = _articles[index];
                          return ListTile(
                            leading: Container(
                              width: 150,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(article.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(article.description),
                                SizedBox(height: 8), // Thêm khoảng cách giữa mô tả và thời gian đăng bài
                                Text(
                                  'Published At: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(article.publishedAt!))}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetailPage(article: article),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
      if (index == 0) { // Nếu chọn nút News
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewsPage()),
      );
    }
      else if (index == 1) { 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 2) { 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SavedArticlesPage()),
      );
    }
        });
      },
      selectedItemColor: Colors.blue, 
      unselectedItemColor: Colors.grey, 
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'User',
        ),
      ],
    ),
  );
}
}


class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: [
          IconButton(
            onPressed: () {
              _saveArticle(article);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lưu thành công')));
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              Image.network(article.urlToImage!),
            const SizedBox(height: 16.0),
            Text(
              article.description,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            // Hiển thị thông tin theo yêu cầu
            if (article.title == 'level1')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'By ${article.author ?? 'Unknown'}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Published At: ${article.publishedAt ?? 'Unknown'}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _saveArticle(Article article) async {
    try {
      final store = Localstore.instance;
      await store.collection('saved_articles').doc(article.title).set(article.toJson());
    } catch (e) {
      print('Error saving article: $e');
    }
  }
}


class SavedArticlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Các bài đã lưu'),
      ),
      body: FutureBuilder<List<Article>>(
        future: _getSavedArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final savedArticles = snapshot.data!;
            return ListView.builder(
              itemCount: savedArticles.length,
              itemBuilder: (context, index) {
                final article = savedArticles[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailPage(article: article),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Article>> _getSavedArticles() async {
  final store = Localstore.instance;
  final articles = await store.collection('saved_articles').get();
  List<Article> savedArticles = [];
  if (articles != null) {
    for (var entry in articles.entries) {
      if (entry.value is Map<String, dynamic>) {
        savedArticles.add(Article.fromJson(entry.value));
      }
    }
  }
  return savedArticles;
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Home Page',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Quay lại'),
            ),
          ],
        ),
      ),
    );
  }
}