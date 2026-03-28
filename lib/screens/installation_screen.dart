import 'package:flutter/material.dart';
import '../app_theme.dart';

class InstallationScreen extends StatelessWidget {
  const InstallationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, _, _) => _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        sectionTitle('Installation Python', context),
        _StepCard(step: '1', title: 'Installer le SDK OpenAI', content: 'pip install openai', color: context.palette[0]),
        _StepCard(
          step: '2',
          title: 'Configurer le client xAI',
          content: '''from openai import OpenAI

client = OpenAI(
    api_key="VOTRE_CLE_XAI",
    base_url="https://api.x.ai/v1",
)''',
          color: context.palette[1],
        ),
        _StepCard(
          step: '3',
          title: 'Premier appel API',
          content: '''response = client.chat.completions.create(
    model="grok-beta",
    messages=[
        {"role": "system", "content": "Tu es Grok, un assistant IA par xAI."},
        {"role": "user", "content": "Explique l'IA en 3 lignes"},
    ],
    max_tokens=2048,
)
print(response.choices[0].message.content)''',
          color: context.palette[2],
        ),
        sectionTitle('Installation JavaScript / TypeScript', context),
        _StepCard(step: '1', title: 'Installer le SDK OpenAI JS', content: 'npm install openai', color: context.palette[3]),
        _StepCard(
          step: '2',
          title: 'Premier appel JS',
          content: '''import OpenAI from "openai";

const client = new OpenAI({
  apiKey: "VOTRE_CLE_XAI",
  baseURL: "https://api.x.ai/v1",
});

const response = await client.chat.completions.create({
  model: "grok-beta",
  messages: [{ role: "user", content: "Explique l'IA en 3 lignes" }],
});
console.log(response.choices[0].message.content);''',
          color: context.palette[4],
        ),
        sectionTitle('Installation Dart / Flutter', context),
        _StepCard(step: '1', title: 'Ajouter http', content: 'flutter pub add http', color: context.palette[5]),
        _StepCard(
          step: '2',
          title: 'Appel HTTP direct',
          content: '''import 'dart:convert';
import 'package:http/http.dart' as http;

final response = await http.post(
  Uri.parse('https://api.x.ai/v1/chat/completions'),
  headers: {
    'Authorization': 'Bearer VOTRE_CLE_XAI',
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    'model': 'grok-beta',
    'messages': [
      {'role': 'user', 'content': "Explique l'IA en 3 lignes"},
    ],
    'max_tokens': 2048,
  }),
);
final data = jsonDecode(response.body);
print(data['choices'][0]['message']['content']);''',
          color: context.palette[0],
        ),
        sectionTitle('Test avec cURL', context),
        _StepCard(
          step: 'cURL',
          title: 'Appel direct HTTP',
          content: r'''curl -X POST https://api.x.ai/v1/chat/completions \
  -H "Authorization: Bearer VOTRE_CLE_XAI" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "grok-beta",
    "messages": [{"role": "user", "content": "Explique l'\''IA en 3 lignes"}]
  }' ''',
          color: context.palette[1],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: context.tipBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.tipBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: context.accentLight, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'L\'API xAI est compatible OpenAI : vous pouvez utiliser le SDK openai en changeant simplement la base_url.',
                  style: TextStyle(color: context.tipText, height: 1.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  final String step;
  final String title;
  final String content;
  final Color color;
  const _StepCard({required this.step, required this.title, required this.content, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Center(
                  child: Text(step,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title,
                    style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 15)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CodeBlock(code: content),
        ],
      ),
    );
  }
}
