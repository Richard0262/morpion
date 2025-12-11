// lib/morpion.dart

class Player {
  final String symbol; // "X" ou "O"
  Player(this.symbol);
}

class Board {
  List<String> cells = List.filled(9, ' ');

  // Affiche le plateau actuel.
  // Le plateau est affiché en forme de grille de 3x3 avec des séparateurs
  // entre les cases. Les cases sont affichées sous forme de symboles
  // (par exemple, "X" ou "O") ou bien d'un espace vide (" ") si
  // la case est vide.
  //
  void display() {
    for (int i = 0; i < 9; i += 3) {
      print('${cells[i]} | ${cells[i+1]} | ${cells[i+2]}');
      if (i < 6) print('--+---+--');
    }
  }

  // Place un symbole sur une case du plateau. 
  // L'indice doit être compris entre 0 et 8.
  // Si la case est déjà occupée, la méthode renvoie false.
  // Si la case est vide, le symbole est placé sur la case et la méthode renvoie true.
  
  bool place(int index, String symbol) {
    if (index < 0 || index > 8) return false;
    if (cells[index] != ' ') return false;
    cells[index] = symbol;
    return true;
  }


  // Vérifie si le plateau contient une combinaison gagnante.
  // Les combinaisons gagnantes sont les lignes, les colonnes et les diagonales.
  // Si une combinaison gagnante est trouvée, le symbole de la combinaison est renvoyé.
  // Si aucune combinaison gagnante n'est trouvée, `null` est renvoyé.
  
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


  // Joue un coup sur le plateau.
  // Si le plateau n'est plus en cours, cette méthode ne fait rien.
  // Si le coup est valide, cette méthode met à jour le plateau en placant le
  // symbole du joueur courant sur la case indiquée.
  // Si le coup est gagnant, cette méthode affiche un message de victoire et
  // met fin au jeu.
  // Si le plateau est plein sans que le coup soit gagnant, cette méthode
  // affiche un message d'égalité et met fin au jeu.
  // Si le coup est invalide, cette méthode affiche un message d'erreur.
  
  
  
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

  // Échange les joueurs courant et suivant.

  void _switchPlayer() {
    Player temp = current;
    current = other;
    other = temp;
  }
}