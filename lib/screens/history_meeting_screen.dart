import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreMethods().meetingsHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('An error occurred: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('No meetings found'),
          );
        }
        
        var data = snapshot.data as QuerySnapshot;
        if (data.docs.isEmpty) {
          return const Center(
            child: Text('No meetings found'),
          );
        }
        
        return ListView.builder(
          itemCount: data.docs.length,
          itemBuilder: (context, index) {
            var meetingData = data.docs[index].data() as Map<String, dynamic>;
            var meetingName = meetingData['meetingName'] ?? 'Unnamed Meeting';
            var createdAt = meetingData.containsKey('created at') ? meetingData['created at'] : null;

            String formattedDate = 'Unknown Date';
            if (createdAt != null && createdAt is Timestamp) {
              formattedDate = DateFormat.yMMMd().format(createdAt.toDate());
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Room Name: $meetingName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'Joined On: $formattedDate',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
