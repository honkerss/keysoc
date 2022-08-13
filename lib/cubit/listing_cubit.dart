import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keysoc/album_repository.dart';
import 'package:keysoc/model/album.dart';

part 'listing_state.dart';

class ListingCubit extends Cubit<ListingState> {
  ListingCubit({required this.repository, this.filterBookmarks = false})
      : super(ListingInitial()) {
    getAlbums();
  }

  final AlbumRepository repository;
  bool filterBookmarks;

  void getAlbums() async {
    try {
      emit(ListingLoading());
      final album = await repository.getMovies(filterBookmarks);
      emit(ListingLoaded(album, false));
    } catch (e) {
      emit(ListingError());
    }
  }

  void rebuildAlbums() {
    if (state is ListingLoaded) {
      final currentState = state as ListingLoaded;
      emit(ListingLoaded(currentState.albums, !currentState.toggle));
    }
  }
}
