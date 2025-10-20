import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recruitment_provider.dart';

class CandidatesScreen extends StatelessWidget {
  const CandidatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recruitmentProvider = Provider.of<RecruitmentProvider>(context);
    final candidates = recruitmentProvider.candidates;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec filtres
          Row(
            children: [
              const Text(
                'Candidats',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              OutlinedButton.icon(
                icon: const Icon(Icons.filter_list),
                label: const Text('Filtrer'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Filtrer les candidats'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CheckboxListTile(
                            title: const Text('Nouveaux candidats'),
                            value: true,
                            onChanged: (value) {},
                          ),
                          CheckboxListTile(
                            title: const Text('En cours d\'évaluation'),
                            value: true,
                            onChanged: (value) {},
                          ),
                          CheckboxListTile(
                            title: const Text('Entretiens planifiés'),
                            value: false,
                            onChanged: (value) {},
                          ),
                          CheckboxListTile(
                            title: const Text('Refusés'),
                            value: false,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Filtres appliqués')),
                            );
                          },
                          child: const Text('Appliquer'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Liste des candidats
          Expanded(
            child: ListView.builder(
              itemCount: candidates.length,
              itemBuilder: (context, index) {
                final candidate = candidates[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Text(
                                candidate.name.substring(0, 1),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    candidate.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    candidate.email,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildStatusChip(candidate.status),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildScoreIndicator(candidate.aiScore),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Score IA: ${candidate.aiScore.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.visibility),
                              label: const Text('Voir CV'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('CV du candidat'),
                                    content: const Text('Aperçu du CV du candidat avec ses compétences et expériences'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Fermer'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              icon: const Icon(Icons.calendar_today),
                              label: const Text('Entretien'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Planifier un entretien'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                            labelText: 'Date',
                                            prefixIcon: Icon(Icons.calendar_today),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          decoration: const InputDecoration(
                                            labelText: 'Heure',
                                            prefixIcon: Icon(Icons.access_time),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Annuler'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Entretien planifié avec succès')),
                                          );
                                        },
                                        child: const Text('Confirmer'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              icon: const Icon(Icons.assessment),
                              label: const Text('Évaluer'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Évaluation du candidat'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('Notez les compétences du candidat'),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List.generate(5, (index) => 
                                            IconButton(
                                              icon: Icon(Icons.star, color: Colors.amber),
                                              onPressed: () {},
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Annuler'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Évaluation enregistrée')),
                                          );
                                        },
                                        child: const Text('Enregistrer'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String label;

    switch (status) {
      case 'received':
        color = Colors.blue;
        label = 'Reçu';
        break;
      case 'pre_selected':
        color = Colors.orange;
        label = 'Présélectionné';
        break;
      case 'interview':
        color = Colors.purple;
        label = 'Entretien';
        break;
      case 'evaluation':
        color = Colors.teal;
        label = 'Évaluation';
        break;
      case 'offer':
        color = Colors.indigo;
        label = 'Offre';
        break;
      case 'hired':
        color = Colors.green;
        label = 'Embauché';
        break;
      case 'rejected':
        color = Colors.red;
        label = 'Rejeté';
        break;
      default:
        color = Colors.grey;
        label = status;
    }

    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: color,
    );
  }

  Widget _buildScoreIndicator(double score) {
    Color color;
    if (score >= 90) {
      color = Colors.green;
    } else if (score >= 80) {
      color = Colors.blue;
    } else if (score >= 70) {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return LinearProgressIndicator(
      value: score / 100,
      backgroundColor: Colors.grey[200],
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}