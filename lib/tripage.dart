import 'package:flutter/material.dart';

import 'médecin/médecin.dart';


class TriPage extends StatefulWidget {
  const TriPage({Key? key}) : super(key: key);

  @override
  State<TriPage> createState() => _TriPageState();
}

class _TriPageState extends State<TriPage> {
  int _selectedIndex = 0; // Indice de l'onglet sélectionné

  // Les pages correspondant à chaque onglet
  final List<Widget> _pages = [
    DoctorSearchScreen (),
    PharmacyPage(),
    MagazinePage(),
    QuestionPage(),
  ];

  // Méthode pour changer d'onglet
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/icons/llogo.png',
              height: 100,
            ),
            SizedBox(width: 8),
            Text(
              'PROD MEDICAL',
              style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _pages[_selectedIndex], // Afficher la page correspondant à l'onglet sélectionné
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Couleur de fond de la barre de navigation
        selectedItemColor: Colors.blue, // Couleur de l'onglet sélectionné
        unselectedItemColor: Colors.grey, // Couleur des onglets non sélectionnés
        currentIndex: _selectedIndex, // Indice de l'onglet sélectionné
        onTap: _onItemTapped, // Appelé lorsque l'utilisateur appuie sur un onglet
        elevation: 10, // Élévation pour une ombre sous la barre de navigation
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Médecin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy),
            label: 'Pharmacie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Magazine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Question',
          ),
        ],
      ),
    );
  }
}

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DoctorSearchScreenState();
  }
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  // Liste des données de boutons
  final List<Map<String, dynamic>> buttonsData = [
    {'name': 'Cardiologue', 'imagePath': 'assets/icons/galb.png'},
    {'name': 'Gastro', 'imagePath': 'assets/icons/gastro.png'},
    {'name': 'Ophtalmologue', 'imagePath': 'assets/icons/yeux.png'},
    {'name': 'Dentiste', 'imagePath': 'assets/icons/dentiste.png'},
    {'name': 'Orthopédiste', 'imagePath': 'assets/icons/adham.png'},
    {'name': 'Urologue', 'imagePath': 'assets/icons/klewi.png'},
    {'name': 'Gynécologue', 'imagePath': 'assets/icons/gnoclogue.png'},
    {'name': 'Psychiatre', 'imagePath': 'assets/icons/nafes.png'},
    {'name': 'Neurologue', 'imagePath': 'assets/icons/neuro.png'},
    {'name': 'Nutritionniste', 'imagePath': 'assets/icons/neutr.png'},
    {'name': 'Pédiatre', 'imagePath': 'assets/icons/pédiatre.png'},
    {'name': 'ORL', 'imagePath': 'assets/icons/widhn.png'},
    {'name': 'Généraliste', 'imagePath': 'assets/icons/ge.png'},
    {'name': 'Pédopsychiatre', 'imagePath': 'assets/icons/pé.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            children: [
              Image.asset(
                'assets/icons/r.png',
                width: 80,
                height: 80,

              ),
              SizedBox(width: 8), // Espacement entre le logo et le titre
              Text(
                'Spécialités',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),]
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un médecin...',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search), // icône à gauche de la zone de recherche
              ),
              onChanged: (value) {
                // Action à effectuer lorsqu'une nouvelle valeur est saisie dans la zone de recherche
                print('Recherche en cours... $value');
              },
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            'Les plus recherchées',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24.0, // Augmentation de la taille du texte
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 8.0, // Espace horizontal entre les boutons
              runSpacing: 8.0, // Espace vertical entre les lignes de boutons
              children: buttonsData.map((buttonData) {
                return GestureDetector(
                  onTap: () {
                    // Action à effectuer lorsque le bouton est pressé
                    print('Button ${buttonData['name']} pressed');
                    // Naviguer vers une autre interface spécifique à la catégorie
                    if (buttonData['name'] == 'Cardiologue') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardiologueScreen(),
                        ),
                      );
                    } else if (buttonData['name'] == 'Gastro') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GastroScreen(),
                        ),
                      );
                    }
                    // Ajoutez d'autres conditions pour chaque catégorie ici
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          buttonData['imagePath'], // Chemin de l'image
                          width: 80, // Largeur de l'image
                          height: 90, // Hauteur de l'image
                        ),
                        const SizedBox(height: 8),
                        Text(
                          buttonData['name'], // Nom du bouton
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


class PharmacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page Pharmacie'),
    );
  }
}

class MagazinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page Magazine'),
    );
  }
}

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page Question'),
    );
  }
}

