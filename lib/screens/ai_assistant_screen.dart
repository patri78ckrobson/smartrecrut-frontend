import 'package:flutter/material.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({Key? key}) : super(key: key);

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Ajouter un message de bienvenue
    _messages.add(
      ChatMessage(
        text: 'Bonjour, je suis votre assistant IA de recrutement. Comment puis-je vous aider aujourd\'hui ?',
        isUser: false,
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _messageController.clear();
    
    if (text.trim().isEmpty) return;
    
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));
      _isTyping = true;
    });
    
    // Simuler une réponse de l'IA après un court délai
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(
          text: _getAIResponse(text),
          isUser: false,
        ));
      });
    });
  }

  String _getAIResponse(String userMessage) {
    // Simuler des réponses de l'IA basées sur des mots-clés
    final lowerCaseMessage = userMessage.toLowerCase();
    
    if (lowerCaseMessage.contains('offre') || lowerCaseMessage.contains('poste')) {
      return 'Je peux vous aider à rédiger une offre d\'emploi attractive. Veuillez me préciser le poste, les compétences requises et les responsabilités principales.\n\nVoici un exemple de structure pour une offre d\'emploi:\n- Titre du poste\n- Description de l\'entreprise\n- Missions principales\n- Profil recherché\n- Avantages proposés';
    } else if (lowerCaseMessage.contains('cv') || lowerCaseMessage.contains('candidat')) {
      return 'Je peux analyser les CV des candidats et les classer selon leur pertinence pour le poste. Souhaitez-vous que j\'analyse un CV spécifique ou que je vous aide à définir des critères de sélection ?\n\nJe peux également générer un score d\'adéquation entre un CV et une offre d\'emploi. Cliquez sur "Analyser un CV" pour commencer.';
    } else if (lowerCaseMessage.contains('entretien') || lowerCaseMessage.contains('question')) {
      return 'Je peux vous suggérer des questions pertinentes pour vos entretiens. Quel type de poste concerne cet entretien ?\n\nVoici quelques exemples de questions générales:\n1. Parlez-moi de votre expérience professionnelle\n2. Pourquoi êtes-vous intéressé par ce poste ?\n3. Quelles sont vos principales forces et faiblesses ?\n4. Comment gérez-vous les situations stressantes ?';
    } else if (lowerCaseMessage.contains('rapport') || lowerCaseMessage.contains('statistique')) {
      return 'Je peux générer des rapports détaillés sur vos processus de recrutement. Souhaitez-vous des statistiques sur les candidatures, les entretiens ou les embauches ?\n\nCliquez sur "Générer un rapport" pour créer un rapport personnalisé avec des graphiques et des analyses.';
    } else if (lowerCaseMessage.contains('bonjour') || lowerCaseMessage.contains('salut') || lowerCaseMessage.contains('hello')) {
      return 'Bonjour ! Je suis l\'assistant IA de SmartRecrut. Je peux vous aider dans toutes les étapes du processus de recrutement. Comment puis-je vous aider aujourd\'hui ?';
    } else if (lowerCaseMessage.contains('merci') || lowerCaseMessage.contains('thanks')) {
      return 'Je vous en prie ! N\'hésitez pas si vous avez d\'autres questions. Je suis là pour vous aider à optimiser votre processus de recrutement.';
    } else {
      return 'Je suis là pour vous aider dans toutes les étapes du processus de recrutement. N\'hésitez pas à me demander de l\'aide pour:\n\n- Rédiger des offres d\'emploi\n- Analyser des CV\n- Préparer des entretiens\n- Générer des rapports\n- Obtenir des conseils sur les meilleures pratiques de recrutement';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // En-tête
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.blue[50],
          child: Row(
            children: [
              Icon(
                Icons.smart_toy,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Assistant IA SmartRecrut',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Posez vos questions sur le recrutement',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Liste des messages
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            reverse: false,
            itemCount: _messages.length,
            itemBuilder: (context, index) => _messages[index],
          ),
        ),
        
        // Indicateur de frappe
        if (_isTyping)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        
        // Barre de saisie
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // Fonctionnalité pour joindre un fichier
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Posez votre question...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => _handleSubmitted(_messageController.text),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Theme.of(context).primaryColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }
}