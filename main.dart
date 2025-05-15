import 'package:flutter/material.dart';

void main() {
  runApp(CinemaApp());
}

class CinemaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema Intelligence',
      theme: ThemeData.dark(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> movies = [
    {"title": "Vikram", "image": "assets/vikram.jpg", "rating": "8.4"},
    {"title": "Beast", "image": "assets/beast.jpg", "rating": "7.7"},
    {"title": "Ponniyin Selvan", "image": "assets/ponniyin.jpg", "rating": "7.7"},
    {"title": "Doctor", "image": "assets/doctor.jpg", "rating": "8.4"},
    {"title": "Vaathi", "image": "assets/vaathi.jpg", "rating": "7.7"},
    {"title": "Don", "image": "assets/don.jpg", "rating": "7.0"},
  ];

  String selectedGenre = "All genres";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.play_circle_fill, color: Colors.red),
            SizedBox(width: 10),
            Text("CINEMA INTELLIGENCE", style: TextStyle(fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.mic, color: Colors.white),
            onPressed: () {
              // Implement voice search or any other action
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/vikram.jpg"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: ["Tamil", "English", "Telugu"]
                      .map(
                        (lang) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LanguageScreen(language: lang)),
                              );
                            },
                            child: Text(
                              lang,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                DropdownButton<String>(
                  value: selectedGenre,
                  dropdownColor: Colors.black,
                  underline: SizedBox(),
                  items: ["All genres", "Action", "Drama", "Comedy"]
                      .map((genre) => DropdownMenuItem(
                            value: genre,
                            child: Text(genre, style: TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedGenre = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Latest",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(movie['image']!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      movie['title']!,
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (movie['rating'] != null)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          movie['rating']!,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: "CI"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class LanguageScreen extends StatelessWidget {
  final String language;

  LanguageScreen({required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$language Movies")),
      body: Center(
        child: Text("Showing movies in $language", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
