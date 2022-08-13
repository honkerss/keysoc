import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keysoc/album_repository.dart';
import 'package:keysoc/cubit/listing_cubit.dart';
import 'package:keysoc/page/album_list.dart';
import 'package:keysoc/util/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<ListingCubit>(
        create: (context) => ListingCubit(
          repository: AlbumRepository(),
        ),
        child: const AlbumListPage(),
      ),
    );
  }
}
