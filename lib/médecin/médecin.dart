import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:url_launcher/url_launcher.dart' as url_launcher;


class CardiologueScreen extends StatelessWidget {
  final List<String> tunisianCities = [
    'Tunis', 'Ariana', 'Ben Arous', 'La Manouba', 'Nabeul', 'Zaghouan',
    'Bizerte', 'Béja', 'Jendouba', 'Le Kef', 'Siliana', 'Kairouan', 'Kasserine',
    'Sidi Bouzid', 'Sousse', 'Monastir', 'Mahdia', 'Sfax', 'Gabès', 'Médenine',
    'Tataouine', 'Gafsa', 'Tozeur'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardiologue'),
      ),
      body: Stack(
        children: [
          // Arrière-plan avec une image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/patient.jpg'), // Remplacez 'assets/background_image.jpg' par le chemin de votre image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu de la page
          Center(
            child: Text(
              'Ceci est une interface spécifique pour Cardiologue.',
              style: TextStyle(
                color: Colors.white, // Couleur du texte
                fontSize: 20.0, // Taille du texte
                fontWeight: FontWeight.bold, // Style de police
              ),
            ),
          ),
          // PopupMenuButton
          Positioned(
            top: 0,
            right: 0,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.location_city, color: Colors.orange.shade900, size:60),
              // Ajout d'une icône
              onSelected: (String value) {
                // Naviguer vers la page des médecins de cette ville
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorListScreen(city: value, specialty: 'Cardiologue'),
                  ),
                );
              },
              itemBuilder: (BuildContext context) {
                // Remplissez le menu déroulant avec la liste des villes en Tunisie
                return tunisianCities.map((city) {
                  return PopupMenuItem<String>(
                    value: city,
                    child: Row(
                      children: [
                        Icon(Icons.location_on), // Icône à gauche du texte
                        SizedBox(width: 8), // Espacement entre l'icône et le texte
                        Text(
                          city,
                          style: TextStyle(
                            color: Colors.black, // Couleur du texte
                            fontSize: 16.0, // Taille du texte
                            fontWeight: FontWeight.bold, // Style de police
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
    );
  }
}



class GastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gastro'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Naviguer vers la page des médecins de cette ville
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorListScreen(city: value, specialty: 'Gastro'),
                ),
              );
            },
            itemBuilder: (BuildContext context) {
              // Remplissez le menu déroulant avec la liste des villes en Tunisie
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Tunis',
                  child: Text('Tunis'),
                ),
                PopupMenuItem<String>(
                  value: 'Sousse',
                  child: Text('Sousse'),
                ),
                // Ajoutez d'autres villes ici
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Ceci est une interface spécifique pour Gastro.'),
      ),
    );
  }
}
class DoctorListScreen extends StatelessWidget {
  final String city;
  final String specialty;

  DoctorListScreen({required this.city, required this.specialty});

  final Map<String, List<Map<String, String>>> doctorsByCity = {
    'Tunis': [
      {
        'name': 'Dr. Jean Dupont',
        'photo': 'assets/images/doctor1.jpg',
        'address': 'Avenue Habib Bourguiba, Tunis',
        'phone': '123456789',
        'latitude': '36.7991',
        'longitude': '10.1865'
      },
      {
        'name': 'Dr. Fatima Ahmed',
        'photo': 'assets/images/doctor2.jpg',
        'address': 'Rue Charles de Gaulle, Tunis',
        'phone': '987654321',
        'latitude': '36.8065',
        'longitude': '10.1815'
      },
      // Ajoutez d'autres médecins pour Tunis
    ],
    // Ajoutez d'autres villes et leurs médecins ici
  };

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> doctors = doctorsByCity[city] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Médecins - $specialty à $city'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (BuildContext context, int index) {
          final doctor = doctors[index];
          final String name = doctor['name'] ?? '';
          final String photo = doctor['photo'] ?? '';
          final String address = doctor['address'] ?? '';
          final String phone = doctor['phone'] ?? '';
          final double latitude = double.tryParse(doctor['latitude'] ?? '') ?? 0;
          final double longitude = double.tryParse(doctor['longitude'] ?? '') ?? 0;

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(photo),
              ),
              title: Text(name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address),
                  Text(phone),
                ],
              ),
              onTap: () {

              },
              trailing: IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  openMapInGoogleMaps(latitude, longitude);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void openMap(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openMapInGoogleMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

