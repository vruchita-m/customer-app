import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import '../../../config/colors/colors.dart';

class TimelineCustom extends StatefulWidget {
  final String complaintNo;
  const TimelineCustom({Key? key, required this.complaintNo}) : super(key: key);

  @override
  State<TimelineCustom> createState() => _TimelineCustomState();
}

class _TimelineCustomState extends State<TimelineCustom> {
  // List<String> completedStageIds = [];
  bool _isLoading = true;
  String? _errorMessage;
  Map<String,String> _completedStageIds = {};

  @override
  void initState() {
    super.initState();
    debugPrint("ticket ID received: ${widget.complaintNo}");
    _fetchTimelineData(); // initial API call
  }

  //  API call method so we can use it for initial load & refresh
  Future<void> _fetchTimelineData() async {
    // Date & Time
    debugPrint("Attempting to fetch timeline data...");
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'http://13.62.55.246:8000/get-timeline/?ticket_id=${widget.complaintNo}'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint("API Response Body (Success): $data");

        // setState(() {
        //   completedStageIds = List<String>.from(data['status_flags']);
        // }
        if (data['status_flags'] is List && data['created_at'] is List &&
            data['status_flags'].length == data['created_at'].length) {

          final statusFlags = List<String>.from(data['status_flags']);
          final createdAt = List<String>.from(data['created_at']);

          setState(() {
            _completedStageIds = Map.fromIterables(statusFlags, createdAt);
            _isLoading = false;
          });
        } else {
          throw Exception("Mismatched or invalid API data structure");
        }

        // );
      } else {
        debugPrint("API call failed with status code ${response.statusCode}. Body: ${response.body}");
        setState(() {
          _errorMessage = "Failed to load timeline. Please try again.";
          _isLoading = false;
        });
      }
    } catch (error) {
      debugPrint("An error occurred during API call: $error");
      setState(() {
        _errorMessage = "An error occurred. Check your connection.";
        _isLoading = false;
      });
    }
  }

  // Start - Date & Time
  String formatDateTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return '';
    try {
      DateTime parsed = DateTime.parse(dateTime);
      return DateFormat('dd MMM yyyy, hh:mm:ss a').format(parsed);
    } catch (e) {
      return dateTime;
    }
  }

  // Events
  final List<TimelineEvent> events = [
    TimelineEvent(id: 'TKTGEN', title: 'Ticket Generate'),
    TimelineEvent(id: 'MECASS', title: 'Mechanic Assigned'),
    TimelineEvent(id: 'ATTPRO', title: 'Attend Process'),
    TimelineEvent(id: 'INVEST', title: 'Vehicle Investigation'),
    TimelineEvent(id: 'ESTIMT', title: 'Estimate - Send to Customer'),
    TimelineEvent(id: 'ESTACC', title: 'Estimate Accepted'),
    TimelineEvent(
      id: 'REESTM',
      title: 'Re-estimate',
      // subStages: [
      //   TimelineEvent(id: 'REPRTU', title: 'Parts Updated'),
      //   TimelineEvent(id: 'REESTC', title: 'Estimate - Send to Customer'),
      //   TimelineEvent(id: 'REESTA', title: 'Estimate Accepted'),
      //   TimelineEvent(id: 'REDLYR', title: 'Delay Reason'),
      // ],
    ),
    TimelineEvent(id: 'DELRSN', title: 'Delay Reason'),
    TimelineEvent(id: 'WRKDON', title: 'Work Done'),
    TimelineEvent(id: 'FINBIL', title: 'Send Invoice To customer'),
    TimelineEvent(id: 'WAIPAY', title: 'Waiting For Payment'),
  ];

  @override
  Widget build(BuildContext context) {

    // Show a loading indicator while data is being fetched
    if (_isLoading) {
      return Scaffold(
        // appBar: AppBar(title: const Text("Timeline")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    // Show an error message if something went wrong
    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Timeline")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchTimelineData,
                child: const Text("Retry"),
              )
            ],
          ),
        ),
      );
    }

    final String lastCompletedId = _completedStageIds.isNotEmpty ? _completedStageIds.keys.last : '';
    final int lastCompletedIndex = events.indexWhere((event) => event.id == lastCompletedId);
    final String? nextStageId = (lastCompletedIndex + 1 < events.length) ? events[lastCompletedIndex + 1].id : null;

    final visibleEvents = events.where((event) => _completedStageIds.containsKey(event.id) || event.id == nextStageId).toList();

    return Scaffold(
      backgroundColor: AppColors.textformfieldcol,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [AppColors.textformfieldcol],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //     ),
        //   ),
        // ),
        title: Text(
          'Timeline',
          style: TextStyle(
              color: AppColors.primarycol,
              fontSize: 22,
              fontWeight: FontWeight.w600
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          // icon: const Icon(Icons.arrow_back, color: Colors.white),
          icon: CircleAvatar(
            radius: 16, // Adjust size
            backgroundColor: Colors.white.withOpacity(1), // Circle background color
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black, // Icon color
              size: 18, // Icon size
            ),
          ),
          onPressed: () {
            // Navigator.pushNamed(context, RoutesName.breakdown_alerts);
            Navigator.pop(context);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchTimelineData, // Called when user pulls down to refresh
        color: Colors.blue, // Color of the refresh indicator
        backgroundColor: Colors.white, // Background color of the refresh indicator
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
          itemCount: visibleEvents.length,
          itemBuilder: (context, index) {
            final event = visibleEvents[index];
            final isDone = _completedStageIds.containsKey(event.id);
            final isCurrent = event.id == nextStageId;
            final eventTime = _completedStageIds[event.id];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: isCurrent
                                ? Colors.blue
                                : isDone
                                ? Colors.green
                                : Colors.grey,
                            child: isDone && !isCurrent
                                ? const Icon(Icons.check,
                                size: 12, color: Colors.white)
                                : null,
                          ),
                        ),
                        if (index != visibleEvents.length - 1)
                          Container(
                            width: 2,
                            height: 40,
                            color: isCurrent
                                ? Colors.blue
                                : isDone
                                ? Colors.green
                                : Colors.grey,
                          ),
                      ],
                    ),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        color: isCurrent
                            ? Colors.blue.shade50
                            : isDone
                            ? Colors.green.shade50
                            : Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isCurrent
                                      ? Colors.blue
                                      : isDone
                                      ? Colors.green
                                      : Colors.black54,
                                ),
                              ),
                              if (eventTime != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  formatDateTime(eventTime),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                              if (event.subStages != null &&
                                  event.subStages!.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                Column(
                                  children: List.generate(event.subStages!.length,
                                          (subIndex) {
                                        final subEvent = event.subStages![subIndex];
                                        final isSubDone =
                                        _completedStageIds.containsKey(subEvent.id);
                                        final isSubCurrent =
                                            subEvent.id == nextStageId;
                                        final subEventTime =
                                        _completedStageIds[subEvent.id];
                                        final isLast = subIndex ==
                                            event.subStages!.length - 1;

                                        return Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor: isSubCurrent
                                                        ? Colors.blue
                                                        : isSubDone
                                                        ? Colors.green
                                                        : Colors.grey,
                                                  ),
                                                  if (!isLast)
                                                    Container(
                                                      width: 2,
                                                      height: 40,
                                                      color: isSubCurrent
                                                          ? Colors.blue
                                                          : isSubDone
                                                          ? Colors.green
                                                          : Colors.grey,
                                                    ),
                                                ],
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      subEvent.title,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: isSubCurrent
                                                            ? Colors.blue
                                                            : isSubDone
                                                            ? Colors.green
                                                            : Colors.black54,
                                                      ),
                                                    ),
                                                    if (subEventTime != null) ...[
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        formatDateTime(subEventTime),
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black45),
                                                      ),
                                                    ],
                                                    const SizedBox(height: 12),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TimelineEvent {
  final String id;
  final String title;
  final String? time;
  final List<TimelineEvent>? subStages;

  TimelineEvent({
    required this.id,
    required this.title,
    this.time,
    this.subStages,
  });
}
