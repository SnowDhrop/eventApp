import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/models/events/event.dart';

class GetAllEvent {
  static const String _baseUrl = 'http://localhost:3000';

  Future<List<Event>> fetchEvents() async {
    final response = await Dio().get(('$_baseUrl/event'));
    if (response.statusCode == 200) {
      Iterable jsonResponse = response.data['event'];
      List<Event> events = jsonResponse.map((eventJson) => Event.fromJson(eventJson)).toList();

      return events;
			
    } else {
      throw Exception('Failed to load events');
    }
  }
}

class CreateEvent {
  static const String _baseUrl = 'http://localhost:3000';

  Future<Event> createEvent(Event event) async {
		final response = await Dio().post(
			'$_baseUrl/event',
			data: json.encode(event.toJson()),
			options: Options(
				headers: {'Content-Type': 'application/json'},
			),
		);

		if (response.statusCode == 201) {
			return Event.fromJson(json.decode(response.data));
		} else {
			throw Exception('Failed to create event');
		}
	}
}

class DeleteEvent {
  static const String _baseUrl = 'http://localhost:3000';

  Future<void> deleteEvent(int eventId) async {
		final response = await Dio().delete('$_baseUrl/event/$eventId');

		if (response.statusCode != 200) {
			throw Exception('Failed to delete event');
		}
	}
}
class UpdateEvent {
  static const String _baseUrl = 'http://localhost:3000';

	Future<Event> updateEvent(int eventId, Event updatedEvent) async {
		final response = await Dio().put(
			'$_baseUrl/event/$eventId',
			data: json.encode(updatedEvent.toJson()),
			options: Options(
				headers: {'Content-Type': 'application/json'},
			),
		);

		if (response.statusCode == 200) {
			return Event.fromJson(json.decode(response.data));
		} else {
			throw Exception('Failed to update event');
		}
	}
}