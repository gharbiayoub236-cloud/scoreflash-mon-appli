import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 110,
          backgroundColor: Colors.black,
          title: Row(
            children: const [
              SizedBox(width: 15),
              Text(
                "Score",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "Flash ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              Icon(
                Icons.sports_soccer_outlined,
                size: 30,
                color: Colors.white,
              ),
              SizedBox(width: 20),
            ],
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.only(left: 27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 7),
              const Text(
                'BIENVENUE',
                style: TextStyle(fontSize: 15, color: Colors.green),
              ),
              const SizedBox(height: 20),
              const Text(
                "Connexion ",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "à votre compte",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Suivez les scores en direct,",
                style: TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),
              const Text(
                "partout, tout le temps.",
                style: TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),

              const SizedBox(height: 60),

              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nom',
                  labelStyle: const TextStyle(color: Colors.green),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    const BorderSide(color: Colors.green, width: 2),
                  ),
                  prefixIcon:
                  const Icon(Icons.email_outlined, color: Colors.green),
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'MOT DE PASSE',
                  labelStyle: const TextStyle(color: Colors.green),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    const BorderSide(color: Colors.green, width: 2),
                  ),
                  prefixIcon:
                  const Icon(Icons.password, color: Colors.green),
                ),
              ),

              const SizedBox(height: 45),

              // 🔥 BOUTON AVEC BUILDER (FORCÉ)
              Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              const Text(
                "────────ou continuer avec ────────",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.blueGrey),
              ),

              const SizedBox(height: 13),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata,
                        size: 17, color: Colors.green),
                    label: const Text("Google"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook,
                        size: 17, color: Colors.blue),
                    label: const Text("Facebook"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.apple,
                        size: 17, color: Colors.grey),
                    label: const Text("Apple"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ================= PAGE 2 =================
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _events = [];
  bool _loading = true;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://www.thesportsdb.com/api/v1/json/123/eventsseason.php?id=4332&s=2025-2026'));
    final data = json.decode(response.body);
    setState(() {
      _events = data['events'];
      _loading = false;
    }
    );
  }
  // fonction pour les categorie
  Future<void> fetchSport(int id) async {
    setState(() {
      _loading = true;
    });
    final response = await http.get(Uri.parse(
        'https://www.thesportsdb.com/api/v1/json/123/eventsseason.php?id=$id&s=2025-2026'));
    final data = json.decode(response.body);
    setState(() {
      _events = data['events'];
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Text("Score", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
            Text("Flash", style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold)),
          ],
        ),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(50), child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed:(){
              fetchSport(4332);
            }, child: const Text("Football",
            style: TextStyle(color: Colors.green),
            )),
            TextButton(onPressed:(){
              fetchSport(4387);
            }, child: const Text("Basket",
              style: TextStyle(color: Colors.green),
            )),
            TextButton(onPressed:(){
              fetchSport(4687);
            }, child: const Text("HandBall",
              style: TextStyle(color: Colors.green),
            )),
            TextButton(onPressed:(){
              fetchSport(4717);
            }, child: const Text("VolleyBall",
              style: TextStyle(color: Colors.green),
            )),
            
          ],
        )
        ),
      ),
      drawer:Drawer(backgroundColor: Colors.black87,
         child:Column(
           children: [
             DrawerHeader(child: Text("Menu",
             style: TextStyle(fontWeight: FontWeight.bold,
             color: Colors.white,
               fontSize: 25,
             ),
             )),
             Column(
               children: [
                 TextButton(onPressed: (){
                   Navigator.pop(context);
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const MyApp(),
                     ),
                   );
                 },
                     child: Text("Déconnexion",
                     style: TextStyle(color: Colors.green),
                     ))
               ],
             )
           ],
         ),
      ),
      body:
      _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : ListView.builder(
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final match = _events[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF111118),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF1A1A26)),
            ),
            child: Column(
              children: [
                // Liguedate
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(match['strLeague'] ?? '',
                        style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    Text(match['dateEvent'] ?? '',
                        style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 12),
                // Équipescore
                Row(
                  children: [
                    // Domicile
                    Expanded(
                      child: Column(
                        children: [
                          if (match['strHomeTeamBadge'] != null)
                            Image.network(match['strHomeTeamBadge'],
                                height: 35, width: 35,
                                errorBuilder: (_, __, ___) =>
                                const Icon(Icons.sports_soccer, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(match['strHomeTeam'] ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                    ),
                    // Score
                    Column(
                      children: [
                        Text(
                          match['intHomeScore'] != null
                              ? '${match['intHomeScore']} - ${match['intAwayScore']}'
                              : 'vs',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          match['strStatus'] == 'Match Finished' ? 'Terminé' : 'À venir',
                          style: const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                    // Extérieur
                    Expanded(
                      child: Column(
                        children: [
                          if (match['strAwayTeamBadge'] != null)
                            Image.network(match['strAwayTeamBadge'],
                                height: 35, width: 35,
                                errorBuilder: (_, __, ___) =>
                                const Icon(Icons.sports_soccer, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(match['strAwayTeam'] ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}