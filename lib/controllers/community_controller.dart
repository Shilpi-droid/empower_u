import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  final TextEditingController communityNameController = TextEditingController();
  String communityName = '';

  void resetCommunityName() {
    communityName = '';
    communityNameController.clear();
  }

  void createCommunity(String communityName) async {
    try {
      final CollectionReference communitiesCollection = FirebaseFirestore.instance.collection('communities');
      final DocumentReference newCommunityDoc = await communitiesCollection.add({
        'name': communityName,
        'messages': [], // Initialize messages as an empty array
      });

      // Add a subcollection named 'messages' with a dummy document to hold the structure
      await newCommunityDoc.collection('messages').add({
        'username': '',
        'message': '',
        'timestamp': null,
      });

      print('Community created successfully');
    } catch (error) {
      print('Error creating community: $error');
    }
  }


  Future<List<String>> fetchCommunityNames() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('communities').get();
      final communityNames = querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      return communityNames;
    } catch (error) {
      print('Error fetching community names: $error');
      return [];
    }
  }

  Future<void> joinCommunity(String communityId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final membershipDoc = await FirebaseFirestore.instance
            .collection('userMemberships')
            .where('userId', isEqualTo: user.uid)
            .where('communityId', isEqualTo: communityId)
            .get();

        if (membershipDoc.docs.isEmpty) {
          await FirebaseFirestore.instance.collection('userMemberships').add({
            'userId': user.uid,
            'communityId': communityId,
          });

          print('Joined community successfully');
        } else {
          print('User is already a member of this community');
        }
      }
    } catch (error) {
      print('Error joining community: $error');
    }
  }


  Stream<List<Map<String, dynamic>>> getChatMessagesStream(String communityId) {
    return FirebaseFirestore.instance
        .collection('communities')
        .doc(communityId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}
