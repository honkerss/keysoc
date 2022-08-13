import 'package:keysoc/model/album.dart';
import 'package:keysoc/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<Album> _bookmarks;

  ObjectBox._init(this._store) {
    _bookmarks = Box<Album>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();

    return ObjectBox._init(store);
  }

  Stream<List<Album>> getBookmarks() => _bookmarks
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  Album? getBookmark(int id) => _bookmarks.get(id);

  int insertBookmark(Album album) => _bookmarks.put(album);

  bool deleteBookmark(int id) => _bookmarks.remove(id);

  bool hasBookmark(int id) => _bookmarks.contains(id);
}
