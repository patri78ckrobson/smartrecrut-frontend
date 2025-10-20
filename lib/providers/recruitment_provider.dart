import 'package:flutter/material.dart';

class JobOffer {
  final String id;
  final String title;
  final String description;
  final String department;
  final String location;
  final String contractType;
  final String status;

  JobOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.department,
    required this.location,
    required this.contractType,
    required this.status,
  });
}

class Candidate {
  final String id;
  final String name;
  final String email;
  final double aiScore;
  final String status;

  Candidate({
    required this.id,
    required this.name,
    required this.email,
    required this.aiScore,
    required this.status,
  });
}

class RecruitmentProvider with ChangeNotifier {
  List<JobOffer> _jobOffers = [];
  List<Candidate> _candidates = [];

  List<JobOffer> get jobOffers => _jobOffers;
  List<Candidate> get candidates => _candidates;

  RecruitmentProvider() {
    // Données de démonstration
    _loadDemoData();
  }

  void _loadDemoData() {
    _jobOffers = [
      JobOffer(
        id: '1',
        title: 'Développeur Full Stack',
        description: 'Nous recherchons un développeur Full Stack expérimenté pour rejoindre notre équipe.',
        department: 'Informatique',
        location: 'Paris',
        contractType: 'CDI',
        status: 'published',
      ),
      JobOffer(
        id: '2',
        title: 'Responsable RH',
        description: 'Poste de responsable des ressources humaines pour gérer le recrutement et la formation.',
        department: 'Ressources Humaines',
        location: 'Lyon',
        contractType: 'CDI',
        status: 'published',
      ),
      JobOffer(
        id: '3',
        title: 'Chef de Projet Digital',
        description: 'Gestion de projets digitaux et coordination des équipes techniques.',
        department: 'Marketing',
        location: 'Bordeaux',
        contractType: 'CDD',
        status: 'draft',
      ),
    ];

    _candidates = [
      Candidate(
        id: '1',
        name: 'Jean Dupont',
        email: 'jean.dupont@example.com',
        aiScore: 85.5,
        status: 'pre_selected',
      ),
      Candidate(
        id: '2',
        name: 'Marie Martin',
        email: 'marie.martin@example.com',
        aiScore: 92.0,
        status: 'interview',
      ),
      Candidate(
        id: '3',
        name: 'Pierre Durand',
        email: 'pierre.durand@example.com',
        aiScore: 78.3,
        status: 'received',
      ),
      Candidate(
        id: '4',
        name: 'Sophie Lefebvre',
        email: 'sophie.lefebvre@example.com',
        aiScore: 88.7,
        status: 'evaluation',
      ),
    ];
  }

  Future<void> createJobOffer(JobOffer jobOffer) async {
    // Simulation d'ajout d'une offre d'emploi
    _jobOffers.add(jobOffer);
    notifyListeners();
  }

  Future<void> updateJobOfferStatus(String id, String status) async {
    // Simulation de mise à jour du statut d'une offre
    final index = _jobOffers.indexWhere((offer) => offer.id == id);
    if (index != -1) {
      final updatedOffer = JobOffer(
        id: _jobOffers[index].id,
        title: _jobOffers[index].title,
        description: _jobOffers[index].description,
        department: _jobOffers[index].department,
        location: _jobOffers[index].location,
        contractType: _jobOffers[index].contractType,
        status: status,
      );
      _jobOffers[index] = updatedOffer;
      notifyListeners();
    }
  }

  Future<void> updateCandidateStatus(String id, String status) async {
    // Simulation de mise à jour du statut d'un candidat
    final index = _candidates.indexWhere((candidate) => candidate.id == id);
    if (index != -1) {
      final updatedCandidate = Candidate(
        id: _candidates[index].id,
        name: _candidates[index].name,
        email: _candidates[index].email,
        aiScore: _candidates[index].aiScore,
        status: status,
      );
      _candidates[index] = updatedCandidate;
      notifyListeners();
    }
  }
}