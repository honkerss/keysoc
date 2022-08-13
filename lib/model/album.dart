import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
// @Sync()
class Album extends Equatable {
  const Album(
      {required this.id, required this.name, required this.artworkUrl60});

  @Id(assignable: true)
  final int id;
  final String name;
  final String artworkUrl60;

  @override
  List<Object> get props => [id, name, artworkUrl60];
}
