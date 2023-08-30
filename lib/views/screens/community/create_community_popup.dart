import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/community_controller.dart';

class CommunityNamePopup extends StatelessWidget {
  final CommunityController _communityController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Community'),
      content: TextFormField(
        controller: _communityController.communityNameController,
        decoration: InputDecoration(labelText: 'Community Name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the popup
            _communityController.resetCommunityName();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final communityName = _communityController.communityNameController.text;
            if (communityName.isNotEmpty) {
              _communityController.createCommunity(communityName);
              _communityController.resetCommunityName();
              Get.back(); // Close the popup
            } else {
              // Handle empty input
            }
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
