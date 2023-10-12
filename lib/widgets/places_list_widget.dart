import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/places_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/providers/user_places.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    final container = ProviderContainer();
    if (places.isEmpty) {
      return Center(
          child: Text(
        'No places added yet',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ));
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(places[index].id),
        onDismissed: (direction) {
          container
              .read(userPlacesProvider.notifier)
              .removePlace(places[index]);
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          width: double.infinity,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            places[index].location.address,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PlaceDetailScreen(
                  place: places[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
