import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/response/trip_idx_get_res.dart';
import 'package:http/http.dart' as http;
import '../config/config.dart';

class TripPage extends StatefulWidget {
  int idx = 0;
  TripPage({super.key, required this.idx});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  String url = '';
  // Create late variables
  late TripIdxGetResponse trip;
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    // Call async function
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดทริป'),
      ),
      // Loading data with FutureBuilder
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          // Loading...
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Load Done
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(
                  16.0), // Set padding for the entire content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(trip.country),
                  const SizedBox(height: 16.0), // Space between widgets
                  Image.network(trip.coverimage),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ราคา ${trip.price.toString()} บาท'),
                      Text('โซน${trip.destinationZone}')
                    ],
                  ),
                  const SizedBox(height: 16.0), // Space between widgets
                  Text(trip.detail),
                  Center(
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('จองเลย!!'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Async function for API call
  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    var res = await http.get(Uri.parse('$url/trips/${widget.idx}'));
    log(res.body);
    trip = tripIdxGetResponseFromJson(res.body);
  }
}
