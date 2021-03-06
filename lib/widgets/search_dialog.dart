import 'package:parking_app/widgets/location_row.dart';
import 'package:parking_app/db/moor_database.dart';
import 'package:flutter/material.dart';

// Custom Widget displayed when user clicks Search Icon:
class SearchDialog extends StatelessWidget {
  // Parent's data:
  final List<Location> locations;
  final Function changeCameraPosition;

  SearchDialog({
    required this.locations,
    required this.changeCameraPosition
  });

  @override
  Widget build(BuildContext context) {
    List<Location> matchingLocations = locations;
    return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Enter parking name...',
              ),
              onChanged: (str) {
                setState(() {
                  matchingLocations = locations
                      .where((element) => element.name.toLowerCase().contains(str.toLowerCase()))
                      .toList();
                });
              },
            ),
            insetPadding: EdgeInsets.all(16),
            contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 0),
            content: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: matchingLocations.length,
                itemBuilder: (BuildContext context, int index) {
                  return LocationRow(
                      currentLocation: matchingLocations[index],
                      changeCameraPosition: changeCameraPosition
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  // Go back:
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
}
