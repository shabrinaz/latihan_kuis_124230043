import 'package:flutter/material.dart';
import 'package:olah_data/data/game_store_data.dart';
import 'package:olah_data/screen/detail_page.dart';
import 'package:olah_data/screen/login_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        // automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text("Selamat Datang $username", style: TextStyle(fontSize: 25)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16
                  ), 
                  itemBuilder: (context, index){
                    return _gameStore(context, index);
                  },
                  itemCount: gameList.length,
                )
              )
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
      (route) => false,
    );
  }

Widget _gameStore(context, int index){
  final selectedGame = gameList[index]; // Ambil data game yang diklik

  return InkWell(
    onTap: () {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DetailPage(game: selectedGame);
          },
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 192, 247),
        border: Border.all(width: 2)
      ),
      child: Column(
        children: [
          Image.network(
            selectedGame.imageUrls[0],
            height: 100, // Sesuaikan tinggi agar grid view terlihat bagus
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            selectedGame.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Review : ${selectedGame.reviewAverage}",
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          )
        ],
      ),
    ),
  );
}
}
