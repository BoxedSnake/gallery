import 'package:flutter/material.dart';
import 'package:gallery/controller/dbController.dart';

enum queryOptions { DateAscending, DateDescending, Filename, Favourites }

class SortOptions extends StatefulWidget {

  const SortOptions({Key? key}) : super(key: key);

  @override
  _SortOptionsState createState() => _SortOptionsState();
}

class _SortOptionsState extends State<SortOptions> {
  var sortType = queryOptions;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<queryOptions>(
      onSelected: (sortType) {
        switch (sortType) {
          case queryOptions.DateAscending:
            setState(() {
              Database().queryDateAscending();
            });
            // TODO: Handle this case.

            break;
          case queryOptions.DateDescending:
            // TODO: Handle this case.
            Database().queryDateDescending();
            break;
          case queryOptions.Filename:
            // TODO: Handle this case.
          Database().querySnapshot();
            break;
          case queryOptions.Favourites:
            // TODO: Handle this case.
          Database().queryFavourites();
            break;
        }
      },
      icon: Icon(Icons.sort_outlined),

      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
              value: queryOptions.Filename, child: Text("Name")),
          const PopupMenuItem(
              value: queryOptions.DateAscending, child: Text("DateAscending")),
          const PopupMenuItem(
              value: queryOptions.DateAscending, child: Text("DateAscending")),
          const PopupMenuItem(
              value: queryOptions.Favourites, child: Text("Favourites")),
        ];
      },
    );
  }
}
