import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/core/constants/firebase_collection_names.dart';
import 'package:facebook/core/constants/firebase_field_names.dart';
import 'package:facebook/features/auth/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllFriendsProvider = StreamProvider.autoDispose((ref) {
  final myUid = FirebaseAuth.instance.currentUser!.uid;

  final controller = StreamController<Iterable<String>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.users)
      .where(
        FirebaseFieldNames.uid,
        isEqualTo: myUid,
      )
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    final userData = snapshot.docs.first;
    final user = UserModel.fromMap(userData.data());
    controller.sink.add(user.friends);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
