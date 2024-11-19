import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/core/constants/firebase_collection_names.dart';
import 'package:facebook/features/auth/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUserInfoProvider = FutureProvider.autoDispose<UserModel>(
  (ref) {
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (userData) {
        return UserModel.fromMap(userData.data()!);
      },
    );
  },
);