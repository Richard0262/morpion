// test/morpion_test.dart
import 'package:test/test.dart';
import 'package:morpion/morpion.dart';

void main() {
  group('Board', () {
    test('place un symbole sur une case vide', () {
      final board = Board();
      expect(board.place(0, "X"), isTrue);
      expect(board.cells[0], equals("X"));
    });

    test('refuse de placer sur une case occupée', () {
      final board = Board();
      board.place(0, "X");
      expect(board.place(0, "O"), isFalse);
    });

    test('détecte une victoire horizontale', () {
      final board = Board();
      board.place(0, "X");
      board.place(1, "X");
      board.place(2, "X");
      expect(board.winner(), equals("X"));
    });

    test('détecte une victoire verticale', () {
      final board = Board();
      board.place(0, "O");
      board.place(3, "O");
      board.place(6, "O");
      expect(board.winner(), equals("O"));
    });

    test('détecte une victoire diagonale', () {
      final board = Board();
      board.place(0, "X");
      board.place(4, "X");
      board.place(8, "X");
      expect(board.winner(), equals("X"));
    });

    test('détecte une égalité', () {
      final board = Board();
      final sequence = ["X","O","X","X","O","O","O","X","X"];
      for (int i = 0; i < 9; i++) {
        board.cells[i] = sequence[i];
      }
      expect(board.isFull(), isTrue);
      expect(board.winner(), isNull);
    });

    test('refuse un index invalide', () {
      final board = Board();
      expect(board.place(-1, "X"), isFalse);
      expect(board.place(9, "O"), isFalse);
    });
  });

  group('Game', () {
    test('alterne les joueurs après un coup valide', () {
      final game = Game();
      game.playTurn(0);
      expect(game.current.symbol, equals("O"));
    });

    test('déclare victoire de X', () {
      final game = Game();
      game.playTurn(0); // X
      game.playTurn(3); // O
      game.playTurn(1); // X
      game.playTurn(4); // O
      game.playTurn(2); // X gagne
      expect(game.inProgress, isFalse);
    });

    test('déclare victoire de O', () {
      final game = Game();
      game.playTurn(0); // X
      game.playTurn(3); // O
      game.playTurn(1); // X
      game.playTurn(4); // O
      game.playTurn(8); // X
      game.playTurn(5); // O gagne
      expect(game.inProgress, isFalse);
    });

    test('déclare égalité si plateau plein sans gagnant', () {
      final game = Game();
      final sequence = [0,1,2,4,3,5,7,6,8]; // X O X O X O X O X
      for (final move in sequence) {
        game.playTurn(move);
      }
      expect(game.inProgress, isFalse);
    });

    test('refuse un coup sur une case déjà occupée', () {
      final game = Game();
      game.playTurn(0); // X
      final before = game.current.symbol;
      game.playTurn(0); // tentative invalide
      expect(game.current.symbol, equals(before)); // joueur n’a pas changé
    });
  });
}