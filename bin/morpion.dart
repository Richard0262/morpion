// bin/morpion.dart
import 'dart:io';
import 'package:morpion/morpion.dart';

void main() {
  final game = Game();
  print("=== Bienvenue dans le jeu du Morpion ===");
  print("X commence toujours. Les cases sont numérotées de 0 à 8.\n");

  while (game.inProgress) {
    // Affichage du plateau
    game.board.display();
    print("\nTour du joueur ${game.current.symbol}");

    // Demande de saisie
    stdout.write("Choisissez une case (0-8) ou 'q' pour quitter: ");
    final input = stdin.readLineSync();

    if (input == null) continue;
    if (input.toLowerCase() == 'q') {
      print("Partie interrompue. Merci d'avoir joué !");
      break;
    }

    final index = int.tryParse(input);
    if (index == null) {
      print("Entrée invalide. Veuillez entrer un nombre entre 0 et 8.");
      continue;
    }

    // Jouer le coup
    game.playTurn(index);
  }

  // Affichage final
  print("\nPlateau final:");
  game.board.display();
  print("\nStatut: ${game.inProgress ? "En cours" : "Terminé"}");
}