import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/core/constants/firebase_collection_names.dart';
import 'package:facebook/core/constants/firebase_field_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';

import '../models/post.dart';

@immutable
class PostRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // make post
  Future<String?> makePost({
    required String content,
    required File file,
    required String postType,
  }) async {
    try {
      final postId = const Uuid().v1();
      final posterId = _auth.currentUser!.uid;
      final now = DateTime.now();

      // Post file to storage
      final fileUid = const Uuid().v1();
      final path = _storage.ref(postType).child(fileUid);
      final taskSnapshot = await path.putFile(file);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Create our post
      Post post = Post(
        postId: postId,
        posterId: posterId,
        content: content,
        postType: postType,
        fileUrl: downloadUrl,
        createdAt: now,
        likes: const [],
      );

      // Post to firestore
      _firestore.collection(FirebaseCollectionNames.posts).doc(postId).set(
            post.toMap(),
          );

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Like a post
  Future<String?> likeDislikePost({
    required String postId,
    required List<String> likes,
  }) async {
    try {
      final authorId = _auth.currentUser!.uid;

      if (likes.contains(authorId)) {
        // we already liked the post
        _firestore
            .collection(FirebaseCollectionNames.posts)
            .doc(postId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayRemove([authorId])
        });
      } else {
        // we need to like the post
        _firestore
            .collection(FirebaseCollectionNames.posts)
            .doc(postId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayUnion([authorId])
        });
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
