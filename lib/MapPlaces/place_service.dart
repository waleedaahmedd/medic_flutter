import 'dart:convert';
import 'dart:io';

import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:medic_flutter_app/MapPlaces/place_service.dart';
import 'package:medic_flutter_app/MapPlaces/address_search.dart';

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;
  String country;
  String latitude;
  String longitude;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
    this.country,
    this.latitude,
    this.longitude,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode, country: $country, latitude: $latitude, longitude: $longitude)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyDtrw3T_npouB9oxnda3GhJn9liXeWNjsQ';
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: androidKey);

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:pk&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;

        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];

          place.latitude = detail.result.geometry.location.lat.toString();
          place.longitude = detail.result.geometry.location.lng.toString();

          /*  if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }*/
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          /*     if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }*/
          if (type.contains('country')) {
            place.country = c['long_name'];
          }
          /* if (type.contains('geometry.location.lat')) {
            place.latitude = c['long_name'];
          }
          if (type.contains('longitude')) {
            place.longitude = c['long_name'];
          }*/
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
