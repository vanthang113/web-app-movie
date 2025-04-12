import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  bool _isLoading = false;

  // Giả lập dữ liệu phim để tìm kiếm
  List<String> _movies = [
    'Nha ba tien',
    'bo tu bao thu',
    'Doremon',
    'conan',
    'nuhon bac ty',
    'Lat mat',
    'khong tim thay film',
    'khong tim thay film',
  ];

  void _searchMovies() {
    setState(() {
      _isLoading = true;
      _searchResults.clear();
    });

    // Giả lập tìm kiếm với thời gian trễ
    Future.delayed(const Duration(seconds: 2), () {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _searchResults = _movies
            .where((movie) => movie.toLowerCase().contains(query))
            .toList();
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm phim...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[800],
              ),
              onChanged: (query) {
                if (query.isEmpty) {
                  setState(() {
                    _searchResults.clear();
                  });
                }
                _searchMovies();
              },
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                    ? const Center(
                        child: Text(
                          'Không có kết quả',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_searchResults[index]),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
