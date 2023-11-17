import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Bookmark {
  final String malid;
  final String title;
  final String img;
  final String type;
  final String reminderwaktu;

  const Bookmark({
    required this.malid,
    required this.title,
    required this.img,
    required this.type,
    this.reminderwaktu = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'malid': malid,
      'title': title,
      'img': img,
      'type': type,
      'reminderwaktu': reminderwaktu,
    };
  }
}

class DatabaseHelper {
  static Database? _db;

  Future openDB() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'bookmarks.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE bookmarks (id INTEGER PRIMARY KEY, malid TEXT, title TEXT, img TEXT, type TEXT, reminderwaktu TEXT)');
      },
    );
    return _db;
  }

  Future<void> insertBookmark(Bookmark bookmark) async {
    checkDuplicate(bookmark.malid).then((value) async {
      if (value) {
        print("data duplicate");
      } else {
        await _db!.insert(
          'bookmarks',
          bookmark.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Bookmark>> listBookmark() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _db!.query('bookmarks');
    return List.generate(maps.length, (i) {
      return Bookmark(
        // id: maps[i]['id'],
        malid: maps[i]['malid'],
        title: maps[i]['title'],
        img: maps[i]['img'],
        type: maps[i]['type'],
        reminderwaktu: maps[i]['reminderwaktu'],
      );
    });
  }

  // check bookmarked
  Future<bool> isBookmarked(String malid) async {
    await openDB();
    final List<Map<String, dynamic>> maps =
        await _db!.query('bookmarks', where: "malid = ?", whereArgs: [malid]);
    //check isbookmark
    if (maps[0]['isbookmark'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  // check if there is duplicate malid
  Future<bool> checkDuplicate(String malid) async {
    await openDB();
    final List<Map<String, dynamic>> maps =
        await _db!.query('bookmarks', where: "malid = ?", whereArgs: [malid]);
    //check isbookmark
    if (maps.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteBookmark(Bookmark bookmark) async {
    await openDB();
    await _db!.delete(
      'bookmarks',
      where: "malid = ?",
      whereArgs: [bookmark.malid],
    );
  }

  // update method
  Future<void> updateBookmark(Bookmark bookmark) async {
    await openDB();
    await _db!.update(
      'bookmarks',
      bookmark.toMap(),
      where: "malid = ?",
      whereArgs: [bookmark.malid],
    );
  }
  // update reminder
  Future<void> updateReminderWaktu(String malId) async {
    await openDB();

    await _db!.update(
      'bookmarks',
      {'reminderwaktu': ''},
      where: "malid = ?",
      whereArgs: [malId],
    );
  }
}
