part of 'listing_cubit.dart';

@immutable
abstract class ListingState extends Equatable {}

class ListingInitial extends ListingState {
  @override
  List<Object> get props => [];
}

class ListingLoading extends ListingState {
  @override
  List<Object> get props => [];
}

class ListingLoaded extends ListingState {
  ListingLoaded(this.albums, this.toggle);

  final List<Album> albums;
  final bool toggle;

  @override
  List<Object> get props => [albums, toggle];
}

class ListingError extends ListingState {
  @override
  List<Object> get props => [];
}
