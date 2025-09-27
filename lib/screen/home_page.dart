import 'package:flutter/material.dart';
import 'package:olah_data/data/game_store_data.dart';
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
    return InkWell(
      onTap: () {
        //jadi tugas
        //bawa data item yang diklik ke DetailPage -> Pakai Navigation.push
        //bikin DetailPage, tampilkan data sesuai kreasi
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(width: 2)
        ),
        child: Column(
          children: [
            Image.network(gameList[index].imageUrls[0]),
            Text(gameList[index].name),
            Text("Review : ${gameList[index].reviewAverage}")
          ],
        ),
      ),
      
    );
  }
}
