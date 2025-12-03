// lib/morpion.dart

class Player {
  final String symbol; // "X" ou "O"
  Player(this.symbol);
}

class Board {
  List<String> cells = List.filled(9, ' ');

  void display() {
    for (int i = 0; i < 9; i += 3) {
      print('${cells[i]} | ${cells[i+1]} | ${cells[i+2]}');
      if (i < 6) print('--+---+--');
    }
  }

  bool place(int index, String symbol) {
    if (index < 0 || index > 8) return false;
    if (cells[index] != ' ') return false;
    cells[index] = symbol;
    return true;
  }

  String? winner() {
    List<List<int>> combos = [
      [0,1,2],[3,4,5],[6,7,8], // lignes
      [0,3,6],[1,4,7],[2,5,8], // colonnes
      [0,4,8],[2,4,6]          // diagonales
    ];
    for (var c in combos) {
      if (cells[c[0]] != ' ' &&
          cells[c[0]] == cells[c[1]] &&
          cells[c[1]] == cells[c[2]]) {
        return cells[c[0]];
      }
    }
    return null;
  }

  bool isFull() => !cells.contains(' ');
}

class Game {
  final Board board = Board();
  Player current = Player("X");
  Player other = Player("O");
  bool inProgress = true;

  void playTurn(int index) {
    if (!inProgress) return;

    if (board.place(index, current.symbol)) {
      String? win = board.winner();
      if (win != null) {
        print("Victoire de $win !");
        inProgress = false;
      } else if (board.isFull()) {
        print("Égalité !");
        inProgress = false;
      } else {
        _switchPlayer();
      }
    } else {
      print("Coup invalide !");
    }
  }

  void _switchPlayer() {
    Player temp = current;
    current = other;
    other = temp;
  }
}