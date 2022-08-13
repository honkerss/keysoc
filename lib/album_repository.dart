import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:keysoc/helper/object_box.dart';
import 'package:keysoc/model/album.dart';
import 'package:keysoc/util/service_locator.dart';

class AlbumRepository {
  AlbumRepository();

  final client = locator.get<Dio>();

  Future<List<Album>> getMovies(bool filterBookmarks) async {
    try {
      const url =
          'https://itunes.apple.com/search?term=jack+johnson&entity=album';

      final response = await client.get(url);

      Map<String, dynamic> data = jsonDecode(response.data);

      List results = data['results'];

      final albums = List<Album>.of(
        results.map<Album>(
          (json) => Album(
            id: json['collectionId'],
            name: json['collectionName'],
            artworkUrl60: json['artworkUrl60'],
          ),
        ),
      );

      if (filterBookmarks) {
        final objectBox = locator.get<ObjectBox>();
        albums.removeWhere((album) => !objectBox.hasBookmark(album.id));
      }

      return albums;
    } catch (e) {
      rethrow;
    }
  }
}
