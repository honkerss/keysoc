import 'package:flutter_test/flutter_test.dart';
import 'package:keysoc/album_repository.dart';
import 'package:keysoc/cubit/listing_cubit.dart';
import 'package:keysoc/model/album.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements AlbumRepository {}

void main() {
  late MockRepository albumRepository;
  late ListingCubit listingCubit;
  final albums = [
    const Album(
        id: 1469577723,
        name:
            'Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George',
        artworkUrl60:
            'https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/60x60bb.jpg'),
    const Album(
        id: 1440752312,
        name:
            'Jack Johnson & Friends - Best of Kokua Festival (A Benefit for the Kokua Hawaii Foundation)',
        artworkUrl60:
            'https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/60x60bb.jpg'),
  ];

  setUp(() {
    albumRepository = MockRepository();
    when(() => albumRepository.getMovies(false)).thenAnswer(
      (_) async => albums,
    );
  });
  test('Emits albums when repository answer correctly', () async {
    listingCubit = ListingCubit(repository: albumRepository);
    await expectLater(
      listingCubit.stream,
      emits(ListingLoaded(albums, true)),
    );
  });
}
