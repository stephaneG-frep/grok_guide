import 'package:flutter/material.dart';
import '../app_theme.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});
  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, _, _) => Column(
        children: [
          Container(
            color: context.cardBg,
            child: TabBar(
              controller: _tabController,
              indicatorColor: context.accentLight,
              labelColor: context.accentLight,
              unselectedLabelColor: context.onSurface.withValues(alpha: 0.4),
              tabs: const [Tab(text: 'Python'), Tab(text: 'JavaScript'), Tab(text: 'Dart')],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_PythonExamples(), _JsExamples(), _DartExamples()],
            ),
          ),
        ],
      ),
    );
  }
}

class _PythonExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _sectionLabel('Appel simple', context),
        const CodeBlock(
          title: 'Python — Grok simple',
          code: '''from openai import OpenAI

client = OpenAI(api_key="VOTRE_CLE", base_url="https://api.x.ai/v1")

response = client.chat.completions.create(
    model="grok-beta",
    messages=[{"role": "user", "content": "Explique le machine learning"}],
)
print(response.choices[0].message.content)''',
        ),
        _sectionLabel('Avec contexte système', context),
        const CodeBlock(
          title: 'Python — System prompt',
          code: '''response = client.chat.completions.create(
    model="grok-beta",
    messages=[
        {"role": "system", "content": "Tu es un expert Python. Réponds avec des exemples."},
        {"role": "user", "content": "Comment lire un fichier CSV ?"},
    ],
)
print(response.choices[0].message.content)''',
        ),
        _sectionLabel('Streaming', context),
        const CodeBlock(
          title: 'Python — Streaming',
          code: r'''stream = client.chat.completions.create(
    model="grok-beta",
    messages=[{"role": "user", "content": "Écris un poème sur l'espace"}],
    stream=True,
)

for chunk in stream:
    if chunk.choices[0].delta.content:
        print(chunk.choices[0].delta.content, end="", flush=True)''',
        ),
        _sectionLabel('Chat multi-tours', context),
        const CodeBlock(
          title: 'Python — Conversation',
          code: '''messages = [{"role": "system", "content": "Tu es Grok, assistant xAI."}]

def chat(user_input):
    messages.append({"role": "user", "content": user_input})
    response = client.chat.completions.create(model="grok-beta", messages=messages)
    reply = response.choices[0].message.content
    messages.append({"role": "assistant", "content": reply})
    return reply

print(chat("Bonjour !"))
print(chat("Quelles sont tes capacités ?"))''',
        ),
      ],
    );
  }
}

class _JsExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _sectionLabel('Appel simple', context),
        const CodeBlock(
          title: 'JavaScript — Grok simple',
          code: '''import OpenAI from "openai";

const client = new OpenAI({
  apiKey: "VOTRE_CLE",
  baseURL: "https://api.x.ai/v1",
});

const response = await client.chat.completions.create({
  model: "grok-beta",
  messages: [{ role: "user", content: "Explique le machine learning" }],
});
console.log(response.choices[0].message.content);''',
        ),
        _sectionLabel('Streaming', context),
        const CodeBlock(
          title: 'JavaScript — Streaming',
          code: r'''const stream = await client.chat.completions.create({
  model: "grok-beta",
  messages: [{ role: "user", content: "Écris un poème sur l'espace" }],
  stream: true,
});

for await (const chunk of stream) {
  process.stdout.write(chunk.choices[0]?.delta?.content || "");
}''',
        ),
        _sectionLabel('Avec vision (image)', context),
        const CodeBlock(
          title: 'JavaScript — Vision',
          code: '''const response = await client.chat.completions.create({
  model: "grok-vision-beta",
  messages: [{
    role: "user",
    content: [
      { type: "image_url", image_url: { url: "https://example.com/image.jpg" } },
      { type: "text", text: "Décris cette image" },
    ],
  }],
});
console.log(response.choices[0].message.content);''',
        ),
      ],
    );
  }
}

class _DartExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _sectionLabel('Appel HTTP direct', context),
        const CodeBlock(
          title: 'Dart — HTTP',
          code: r'''import 'dart:convert';
import 'package:http/http.dart' as http;

final response = await http.post(
  Uri.parse('https://api.x.ai/v1/chat/completions'),
  headers: {
    'Authorization': 'Bearer VOTRE_CLE',
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    'model': 'grok-beta',
    'messages': [
      {'role': 'user', 'content': 'Explique le machine learning'},
    ],
    'max_tokens': 2048,
  }),
);

final data = jsonDecode(response.body);
print(data['choices'][0]['message']['content']);''',
        ),
        _sectionLabel('Avec system prompt', context),
        const CodeBlock(
          title: 'Dart — System prompt',
          code: '''final response = await http.post(
  Uri.parse('https://api.x.ai/v1/chat/completions'),
  headers: {
    'Authorization': 'Bearer VOTRE_CLE',
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    'model': 'grok-beta',
    'messages': [
      {'role': 'system', 'content': 'Tu es un assistant expert en Flutter.'},
      {'role': 'user', 'content': "Comment gérer l'état en Flutter ?"},
    ],
    'max_tokens': 2048,
  }),
);''',
        ),
        _sectionLabel('Intégration Flutter Widget', context),
        CodeBlock(
          title: 'Dart — FutureBuilder',
          code: r'''FutureBuilder<String>(
  future: _getGrokResponse("Dis bonjour en 3 langues"),
  builder: (context, snapshot) {
    if (snapshot.hasData) return Text(snapshot.data!);
    if (snapshot.hasError) return Text("Erreur: ${snapshot.error}");
    return const CircularProgressIndicator();
  },
)''',
        ),
      ],
    );
  }
}

Widget _sectionLabel(String text, BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(text,
          style: TextStyle(
              color: context.accentLight, fontSize: 14, fontWeight: FontWeight.w600)),
    );
