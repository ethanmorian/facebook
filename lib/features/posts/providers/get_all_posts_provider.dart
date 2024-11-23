import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/core/constants/firebase_collection_names.dart';
import 'package:facebook/core/constants/firebase_field_names.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';

final getAllPostsProvider = StreamProvider<Iterable<Post>>(
  (ref) {
    final controller = StreamController<Iterable<Post>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.posts)
        .orderBy(
          FirebaseFieldNames.createdAt,
          descending: true,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final posts =
            snapshot.docs.map((postData) => Post.fromMap(postData.data()));
        controller.sink.add(posts);
      },
    );

    ref.onDispose(
      () {
        sub.cancel();
        controller.close();
      },
    );

    return controller.stream;
  },
);