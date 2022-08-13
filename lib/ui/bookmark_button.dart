import 'package:flutter/material.dart';
import 'package:keysoc/helper/object_box.dart';
import 'package:keysoc/model/album.dart';
import 'package:keysoc/util/service_locator.dart';

class BookmarkButton extends StatefulWidget {
  const BookmarkButton({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  final objectBox = locator.get<ObjectBox>();

  @override
  Widget build(BuildContext context) {
    bool bookmarked = objectBox.hasBookmark(widget.album.id);
    return IconButton(
      onPressed: () {
        bookmarked
            ? objectBox.deleteBookmark(widget.album.id)
            : objectBox.insertBookmark(widget.album);
        bookmarked = !bookmarked;
        setState(() {});
      },
      icon: bookmarked
          ? const Icon(
              Icons.bookmark_added,
              color: Colors.red,
            )
          : const Icon(
              Icons.bookmark_add_outlined,
              color: Colors.green,
            ),
    );
  }
}
