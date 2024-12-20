import 'dart:collection';
import 'dart:math';

class Short {
  final List<List<String>> grid;
  final Point<int> start;
  final Point<int> end;

  Short(this.grid, this.start, this.end);

  List<Point<int>> findShortestPath() {



    int rows = grid.length;
    int cols = grid[0].length;

    bool isValid(Point<int> point) {

      int x = point.x;
      int y = point.y;
      return x >= 0 && x < cols && y >= 0 && y < rows && grid[y][x] == '.';
    }

    Queue<List<Point<int>>> queue = Queue();
    Set<Point<int>> visited = {};

    queue.add([start]);
    visited.add(start);

    while (queue.isNotEmpty) {
      List<Point<int>> path = queue.removeFirst();
      Point<int> current = path.last;

      if (current == end) {
        return path;
      }



      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          if (dx == 0 && dy == 0) continue;

          Point<int> next = Point(current.x + dx, current.y + dy);

          if (isValid(next) && !visited.contains(next)) {
            visited.add(next);
            List<Point<int>> newPath = List.from(path)..add(next);
            queue.add(newPath);
          }
        }
      }
    }

    return [];
  }
}

void main() {
  List<List<String>> grid = [
    ['x', 'X', '.'],
    ['.', 'X', '.'],
    ['x', '.', '.'],
    ['.', 'X', 'x'],
    ['.', '.', '.'],
    ['.', '.', '.']
  ];

  if (grid.length < 1 || grid.length > 99) {
    throw Exception('Помилка,довжина сітки повинна бути > 1 та < 100');
  } else {
    // Short short1 = Short(grid, Point(0, 1), Point(2, 5));
    Short short = Short(grid, Point(0, 1), Point(2, 0));
    List<Point<int>> shortestPath = short.findShortestPath();


    if (shortestPath.isEmpty) {
      print("Щлях не знайдено");
    } else {
      print(
          "Найкоротший шлях: ${shortestPath.map((p) => '(${p.x}, ${p.y})').join(
              ' -> ')}");
    }
  }
}

