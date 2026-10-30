import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:projeto_final_mobile/main.dart';

void main() {
  // TESTE 1: SPLASH SCREEN E TELA INICIAL
  testWidgets('GlowUp abre e apresenta a tela inicial',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GlowUpApp());

    // Verifica a Splash Screen
    expect(find.text('GlowUp'), findsOneWidget);
    expect(
      find.text('Sua beleza, do seu jeito.'),
      findsOneWidget,
    );

    // Aguarda os 3 segundos da Splash Screen
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 500));

    // Verifica a tela inicial
    expect(
      find.text('Olá, seja bem-vinda! 💗'),
      findsOneWidget,
    );

    expect(find.text('Explore o GlowUp'), findsOneWidget);
    expect(find.text('Minha rotina'), findsOneWidget);
    expect(find.text('Produtos'), findsOneWidget);
    expect(find.text('Dicas'), findsOneWidget);
    expect(find.text('Meu perfil'), findsOneWidget);
  });

  // TESTE 2: CARDS CLICÁVEIS
  testWidgets('Card Minha rotina abre a tela de rotina',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GlowUpApp());

    // Aguarda a abertura da tela inicial
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 500));

    // Clica no card Minha rotina
    await tester.tap(find.text('Minha rotina').first);
    await tester.pump();

    // Verifica se a tela de rotina abriu
    expect(
      find.text('Seus cuidados diários 🌷'),
      findsOneWidget,
    );
  });

  // TESTE 3: MARCAR TAREFAS
  testWidgets('Permite marcar tarefas da rotina',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GlowUpApp());

    // Aguarda a abertura da tela inicial
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 500));

    // Entra na aba Rotina
    await tester.tap(find.text('Rotina').last);
    await tester.pump();

    // Verifica a lista de tarefas
    expect(find.text('Lavar o rosto'), findsOneWidget);

    // Marca a primeira tarefa
    final checkbox = find.byType(CheckboxListTile).first;

    await tester.tap(checkbox);
    await tester.pump();

    // Confirma que foi marcada
    expect(
      tester.widget<CheckboxListTile>(checkbox).value,
      true,
    );

    expect(
      find.text('1 de 6 tarefas concluídas'),
      findsOneWidget,
    );
  });

  // TESTE 4: FAVORITAR PRODUTOS
  testWidgets('Permite favoritar produtos',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GlowUpApp());

    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 500));

    // Entra na aba Produtos
    await tester.tap(find.text('Produtos').last);
    await tester.pump();

    // Verifica se os produtos aparecem
    expect(find.text('Gel de limpeza facial'), findsOneWidget);

    // Clica no primeiro botão de favorito
    final favorito = find.byTooltip('Favoritar produto').first;

    await tester.tap(favorito);
    await tester.pump();

    // Verifica se o ícone mudou para coração preenchido
    expect(
      find.byIcon(Icons.favorite),
      findsOneWidget,
    );
  });
}