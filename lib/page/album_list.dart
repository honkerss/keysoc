import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keysoc/album_repository.dart';
import 'package:keysoc/cubit/listing_cubit.dart';
import 'package:keysoc/ui/album_tile.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({Key? key, this.bookmarks = false}) : super(key: key);

  final bool bookmarks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(bookmarks ? 'Bookmarks' : 'Albums'),
          centerTitle: true,
          actions: [
            if (!bookmarks)
              IconButton(
                  icon: const Icon(Icons.bookmarks),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<ListingCubit>(
                          create: (context) => ListingCubit(
                            repository: AlbumRepository(),
                            filterBookmarks: true,
                          ),
                          child: const AlbumListPage(
                            bookmarks: true,
                          ),
                        ),
                      ),
                    ).then((value) =>
                        context.read<ListingCubit>().rebuildAlbums());
                  }),
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ListingCubit>().getAlbums();
        },
        child: BlocBuilder<ListingCubit, ListingState>(
          builder: (context, state) {
            if (state is ListingLoaded) {
              final albums = state.albums;

              if (albums.isEmpty) {
                return const CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          "No albums here",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) => Card(
                  child: AlbumTile(album: albums[index]),
                ),
              );
            } else {
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: Center(
                      child: state is ListingLoading
                          ? const CircularProgressIndicator()
                          : state is ListingError
                              ? const Text(
                                  "Error!. Please try again.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
