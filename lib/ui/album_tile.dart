import 'package:flutter/material.dart';
import 'package:keysoc/model/album.dart';
import 'package:keysoc/ui/bookmark_button.dart';

class AlbumTile extends StatelessWidget {
  const AlbumTile({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(album.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(album.artworkUrl60),
      ),
      trailing: BookmarkButton(album: album),
    );
  }
}
