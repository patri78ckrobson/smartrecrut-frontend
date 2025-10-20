import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/recruitment_provider.dart';
import 'job_offers_screen.dart';
import 'candidates_screen.dart';
import 'ai_assistant_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<String> _appBarTitles = [
    'Tableau de bord',
    'Offres d\'emploi',
    'Candidats',
    'Assistant IA',
    'Paramètres'
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final recruitmentProvider = Provider.of<RecruitmentProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vous n\'avez pas de nouvelles notifications'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Utilisateur ${authProvider.userRole}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    authProvider.userRole.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Tableau de bord'),
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Offres d\'emploi'),
              selected: _selectedIndex == 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Candidats'),
              selected: _selectedIndex == 2,
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.smart_toy),
              title: const Text('Assistant IA'),
              selected: _selectedIndex == 3,
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              selected: _selectedIndex == 4,
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _buildBody(),
      floatingActionButton: _selectedIndex == 1 || _selectedIndex == 2
          ? FloatingActionButton(
              onPressed: () {
                // Action selon la page active
                if (_selectedIndex == 1) {
                  // Ajouter une offre d'emploi
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Nouvelle offre d\'emploi'),
                      content: const Text('Formulaire de création d\'une nouvelle offre d\'emploi'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Offre d\'emploi créée avec succès')),
                            );
                          },
                          child: const Text('Créer'),
                        ),
                      ],
                    ),
                  );
                } else if (_selectedIndex == 2) {
                  // Ajouter un candidat
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Nouveau candidat'),
                      content: const Text('Formulaire d\'ajout d\'un nouveau candidat'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Candidat ajouté avec succès')),
                            );
                          },
                          child: const Text('Ajouter'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardContent();
      case 1:
        return const JobOffersScreen();
      case 2:
        return const CandidatesScreen();
      case 3:
        return const AIAssistantScreen();
      case 4:
        return _buildSettingsContent();
      default:
        return _buildDashboardContent();
    }
  }

  Widget _buildDashboardContent() {
    final recruitmentProvider = Provider.of<RecruitmentProvider>(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cartes de statistiques
          Row(
            children: [
              _buildStatCard(
                'Offres actives',
                recruitmentProvider.jobOffers.where((offer) => offer.status == 'published').length.toString(),
                Icons.work,
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'Candidats',
                recruitmentProvider.candidates.length.toString(),
                Icons.people,
                Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard(
                'Entretiens',
                '5',
                Icons.calendar_today,
                Colors.orange,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'Recrutements',
                '2',
                Icons.check_circle,
                Colors.purple,
              ),
            ],
          ),
          
          // Activités récentes
          const SizedBox(height: 24),
          const Text(
            'Activités récentes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildActivityList(),
          
          // Candidats récents
          const SizedBox(height: 24),
          const Text(
            'Candidats récents',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildRecentCandidatesList(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Icon(
                    icon,
                    color: color,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    return Card(
      elevation: 2,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.primaries[index % Colors.primaries.length],
              child: Icon(
                index % 3 == 0 ? Icons.work : index % 3 == 1 ? Icons.person : Icons.calendar_today,
                color: Colors.white,
              ),
            ),
            title: Text(
              index % 3 == 0
                  ? 'Nouvelle offre publiée'
                  : index % 3 == 1
                      ? 'Nouveau candidat'
                      : 'Entretien programmé',
            ),
            subtitle: Text('Il y a ${index + 1} ${index == 0 ? 'heure' : 'heures'}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Afficher les détails de l'activité
            },
          );
        },
      ),
    );
  }

  Widget _buildRecentCandidatesList() {
    final recruitmentProvider = Provider.of<RecruitmentProvider>(context);
    final candidates = recruitmentProvider.candidates;
    
    return Card(
      elevation: 2,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: candidates.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final candidate = candidates[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Text(
                candidate.name.substring(0, 1),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(candidate.name),
            subtitle: Text(candidate.email),
            trailing: Chip(
              label: Text(
                'Score: ${candidate.aiScore.toStringAsFixed(1)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              backgroundColor: _getScoreColor(candidate.aiScore),
            ),
            onTap: () {
              // Afficher les détails du candidat
            },
          );
        },
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return Colors.green;
    if (score >= 80) return Colors.blue;
    if (score >= 70) return Colors.orange;
    return Colors.red;
  }

  Widget _buildSettingsContent() {
    return const Center(
      child: Text('Paramètres - À implémenter'),
    );
  }
}