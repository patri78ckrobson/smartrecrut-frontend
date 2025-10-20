import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recruitment_provider.dart';

class JobOffersScreen extends StatelessWidget {
  const JobOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recruitmentProvider = Provider.of<RecruitmentProvider>(context);
    final jobOffers = recruitmentProvider.jobOffers;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec filtres
          Row(
            children: [
              const Text(
                'Offres d\'emploi',
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
                      title: const Text('Filtrer les offres'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CheckboxListTile(
                            title: const Text('Offres publiées'),
                            value: true,
                            onChanged: (value) {},
                          ),
                          CheckboxListTile(
                            title: const Text('Offres en brouillon'),
                            value: false,
                            onChanged: (value) {},
                          ),
                          CheckboxListTile(
                            title: const Text('Offres clôturées'),
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
          
          // Liste des offres d'emploi
          Expanded(
            child: ListView.builder(
              itemCount: jobOffers.length,
              itemBuilder: (context, index) {
                final jobOffer = jobOffers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                jobOffer.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _buildStatusChip(jobOffer.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          jobOffer.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoChip(Icons.business, jobOffer.department),
                            const SizedBox(width: 8),
                            _buildInfoChip(Icons.location_on, jobOffer.location),
                            const SizedBox(width: 8),
                            _buildInfoChip(Icons.work, jobOffer.contractType),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.edit),
                              label: const Text('Modifier'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Modifier l\'offre'),
                                    content: const Text('Formulaire de modification de l\'offre d\'emploi'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Annuler'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Offre modifiée avec succès')),
                                          );
                                        },
                                        child: const Text('Enregistrer'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              icon: const Icon(Icons.people),
                              label: const Text('Candidats'),
                              onPressed: () {
                                // Voir les candidats
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
      case 'draft':
        color = Colors.grey;
        label = 'Brouillon';
        break;
      case 'published':
        color = Colors.green;
        label = 'Publiée';
        break;
      case 'closed':
        color = Colors.red;
        label = 'Clôturée';
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

  Widget _buildInfoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(
        icon,
        size: 16,
        color: Colors.blue,
      ),
      label: Text(label),
      backgroundColor: Colors.blue[50],
    );
  }
}