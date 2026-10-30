import 'dart:async';
import 'package:flutter/material.dart';

const Color rosa = Color(0xFFE879A9);
const Color rosaClaro = Color(0xFFFFE4EF);
const Color fundo = Color(0xFFFFF5F9);
const Color vinho = Color(0xFFAD416F);
const Color branco = Colors.white;

void main() {
  runApp(const GlowUpApp());
}

// APLICATIVO

class GlowUpApp extends StatelessWidget {
  const GlowUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlowUp',
      theme: ThemeData(
        scaffoldBackgroundColor: fundo,
        colorScheme: ColorScheme.fromSeed(seedColor: rosa),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// SPLASH SCREEN

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PrincipalScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: branco,
      body: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'glow.png',
                width: 260,
                height: 260,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.spa_outlined,
                    size: 100,
                    color: rosa,
                  );
                },
              ),
              const SizedBox(height: 12),
              const Text(
                'GlowUp',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: vinho,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Sua beleza, do seu jeito.',
                style: TextStyle(
                  fontSize: 16,
                  color: vinho,
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                color: vinho,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// NAVEGAÇÃO PRINCIPAL

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  int paginaAtual = 0;

  final List<String> titulos = [
    'Início',
    'Minha rotina',
    'Produtos',
    'Dicas',
    'Meu perfil',
  ];

  void navegarPara(int index) {
    setState(() {
      paginaAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> paginas = [
      InicioPage(onNavigate: navegarPara),
      const RotinaPage(),
      const ProdutosPage(),
      const DicasPage(),
      const PerfilPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: fundo,
        elevation: 0,
        centerTitle: true,
        title: Text(
          titulos[paginaAtual],
          style: const TextStyle(
            color: vinho,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: IndexedStack(
        index: paginaAtual,
        children: paginas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: navegarPara,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: vinho,
        unselectedItemColor: Colors.grey,
        backgroundColor: branco,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Rotina',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Produtos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Dicas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// TELA INICIAL

class InicioPage extends StatelessWidget {
  final Function(int) onNavigate;

  const InicioPage({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Olá, seja bem-vinda! 💗',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: vinho,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Que tal reservar um tempinho para cuidar de você?',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 22),

        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [rosa, vinho],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.spa, color: branco, size: 35),
              SizedBox(height: 12),
              Text(
                'Seu momento de autocuidado!',
                style: TextStyle(
                  color: branco,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pequenos cuidados fazem uma grande diferença. '
                'Cuide de você todos os dias.',
                style: TextStyle(color: branco),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Explore o GlowUp',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: vinho,
          ),
        ),
        const SizedBox(height: 13),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: [
            AtalhoCard(
              icone: Icons.check_circle_outline,
              titulo: 'Minha rotina',
              descricao: 'Organize seus cuidados',
              onTap: () => onNavigate(1),
            ),
            AtalhoCard(
              icone: Icons.shopping_bag_outlined,
              titulo: 'Produtos',
              descricao: 'Conheça produtos',
              onTap: () => onNavigate(2),
            ),
            AtalhoCard(
              icone: Icons.lightbulb_outline,
              titulo: 'Dicas',
              descricao: 'Aprenda novidades',
              onTap: () => onNavigate(3),
            ),
            AtalhoCard(
              icone: Icons.person_outline,
              titulo: 'Meu perfil',
              descricao: 'Suas informações',
              onTap: () => onNavigate(4),
            ),
          ],
        ),

        const SizedBox(height: 22),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: branco,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: rosa),
                  SizedBox(width: 8),
                  Text(
                    'Dica do dia',
                    style: TextStyle(
                      color: vinho,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Não se esqueça de beber água e usar protetor solar '
                'durante o dia. Sua pele merece esse cuidado! ☀️',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// CARDS DA TELA INICIAL

class AtalhoCard extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final VoidCallback onTap;

  const AtalhoCard({
    super.key,
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: branco,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, color: rosa, size: 32),
              const SizedBox(height: 9),
              Text(
                titulo,
                style: const TextStyle(
                  color: vinho,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                descricao,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MINHA ROTINA

class RotinaPage extends StatefulWidget {
  const RotinaPage({super.key});

  @override
  State<RotinaPage> createState() => _RotinaPageState();
}

class _RotinaPageState extends State<RotinaPage> {
  final List<Map<String, dynamic>> tarefas = [
    {'nome': 'Lavar o rosto', 'feito': false},
    {'nome': 'Aplicar hidratante', 'feito': false},
    {'nome': 'Usar protetor solar', 'feito': false},
    {'nome': 'Beber água', 'feito': false},
    {'nome': 'Cuidar do cabelo', 'feito': false},
    {'nome': 'Fazer rotina noturna', 'feito': false},
  ];

  @override
  Widget build(BuildContext context) {
    final int concluidas =
        tarefas.where((tarefa) => tarefa['feito'] == true).length;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Seus cuidados diários 🌷',
          style: TextStyle(
            fontSize: 22,
            color: vinho,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text('$concluidas de ${tarefas.length} tarefas concluídas'),
        const SizedBox(height: 12),

        LinearProgressIndicator(
          value: concluidas / tarefas.length,
          minHeight: 9,
          backgroundColor: rosaClaro,
          color: rosa,
          borderRadius: BorderRadius.circular(10),
        ),

        const SizedBox(height: 20),

        ...List.generate(tarefas.length, (index) {
          final tarefa = tarefas[index];

          return Card(
            color: branco,
            margin: const EdgeInsets.only(bottom: 10),
            child: CheckboxListTile(
              activeColor: rosa,
              title: Text(
                tarefa['nome'] as String,
                style: TextStyle(
                  decoration: tarefa['feito'] == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              value: tarefa['feito'] as bool,
              onChanged: (valor) {
                setState(() {
                  tarefas[index]['feito'] = valor ?? false;
                });
              },
            ),
          );
        }),

        const SizedBox(height: 12),
        const Text(
          'Lembre-se: cuidar de si também é uma prioridade. 💗',
          style: TextStyle(color: vinho),
        ),
      ],
    );
  }
}

// PRODUTOS

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  final Set<int> favoritos = {};

  final List<Map<String, String>> produtos = [
    {
      'nome': 'Gel de limpeza facial',
      'categoria': 'Skincare',
      'preco': 'R\$ 29,90',
      'descricao': 'Para a limpeza diária da pele.',
    },
    {
      'nome': 'Hidratante facial',
      'categoria': 'Hidratação',
      'preco': 'R\$ 39,90',
      'descricao': 'Ajuda a manter a pele hidratada.',
    },
    {
      'nome': 'Protetor solar FPS 50',
      'categoria': 'Proteção',
      'preco': 'R\$ 49,90',
      'descricao': 'Proteção para os cuidados diários.',
    },
    {
      'nome': 'Máscara capilar',
      'categoria': 'Cabelo',
      'preco': 'R\$ 34,90',
      'descricao': 'Um cuidado especial para os fios.',
    },
    {
      'nome': 'Lip balm',
      'categoria': 'Lábios',
      'preco': 'R\$ 19,90',
      'descricao': 'Ajuda a hidratar os lábios.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Produtos para seu autocuidado ✨',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: vinho,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Explore sugestões para sua rotina de beleza.',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 15),

        ...List.generate(produtos.length, (index) {
          final produto = produtos[index];

          return Card(
            color: branco,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: rosaClaro,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.spa_outlined,
                  color: vinho,
                  size: 28,
                ),
              ),
              title: Text(
                produto['nome']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: vinho,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  '${produto['categoria']}\n'
                  '${produto['descricao']}\n'
                  '${produto['preco']}',
                ),
              ),
              isThreeLine: true,
              trailing: IconButton(
                tooltip: favoritos.contains(index)
                    ? 'Remover dos favoritos'
                    : 'Favoritar produto',
                icon: Icon(
                  favoritos.contains(index)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: rosa,
                ),
                onPressed: () {
                  setState(() {
                    if (favoritos.contains(index)) {
                      favoritos.remove(index);
                    } else {
                      favoritos.add(index);
                    }
                  });
                },
              ),
            ),
          );
        }),

        const Text(
          'Os produtos e preços são exemplos ilustrativos.',
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}

// DICAS

class DicasPage extends StatelessWidget {
  const DicasPage({super.key});

  final List<Map<String, String>> dicas = const [
    {
      'titulo': 'Cuide da sua pele',
      'texto':
          'Mantenha uma rotina de limpeza, hidratação e proteção solar.',
    },
    {
      'titulo': 'Hidrate seus cabelos',
      'texto': 'Escolha produtos adequados ao seu tipo de cabelo.',
    },
    {
      'titulo': 'Beba água',
      'texto':
          'A hidratação é importante para o funcionamento do organismo.',
    },
    {
      'titulo': 'Tenha um momento para você',
      'texto':
          'Separe alguns minutos para descansar e fazer algo de que gosta.',
    },
    {
      'titulo': 'Cuide dos seus lábios',
      'texto': 'Use um hidratante labial quando sentir necessidade.',
    },
    {
      'titulo': 'Cuide do seu sono',
      'texto': 'Ter horários regulares de sono ajuda no seu bem-estar.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Inspire-se e cuide de você! 💕',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: vinho,
          ),
        ),
        const SizedBox(height: 15),

        ...dicas.map((dica) {
          return Card(
            color: branco,
            margin: const EdgeInsets.only(bottom: 13),
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: rosa,
                    size: 28,
                  ),
                  const SizedBox(height: 9),
                  Text(
                    dica['titulo']!,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: vinho,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(dica['texto']!),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// PERFIL

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final TextEditingController nomeController =
      TextEditingController(text: 'Usuária GlowUp');

  final TextEditingController emailController =
      TextEditingController(text: 'seuemail@email.com');

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void salvarPerfil() {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Informações atualizadas nesta sessão! 💗'),
        backgroundColor: vinho,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Center(
          child: CircleAvatar(
            radius: 55,
            backgroundColor: rosaClaro,
            child: Icon(
              Icons.person,
              size: 65,
              color: vinho,
            ),
          ),
        ),
        const SizedBox(height: 15),

        const Center(
          child: Text(
            'Meu perfil',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: vinho,
            ),
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Nome',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: vinho,
          ),
        ),
        const SizedBox(height: 7),

        TextField(
          controller: nomeController,
          decoration: InputDecoration(
            filled: true,
            fillColor: branco,
            prefixIcon: const Icon(
              Icons.person_outline,
              color: rosa,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'E-mail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: vinho,
          ),
        ),
        const SizedBox(height: 7),

        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: branco,
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: rosa,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 22),

        ElevatedButton.icon(
          onPressed: salvarPerfil,
          icon: const Icon(Icons.save),
          label: const Text('Salvar informações'),
          style: ElevatedButton.styleFrom(
            backgroundColor: rosa,
            foregroundColor: branco,
            padding: const EdgeInsets.all(15),
          ),
        ),

        const SizedBox(height: 25),

        const Center(
          child: Text(
            'GlowUp — Sua beleza, do seu jeito. 💗',
            style: TextStyle(color: vinho),
          ),
        ),
      ],
    );
  }
}