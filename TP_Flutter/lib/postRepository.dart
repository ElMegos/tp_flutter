import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp_flutter/post.dart';

class PostRepository {
  final CollectionReference _postCollection = FirebaseFirestore.instance.collection('post');

  Future<List<Post>> getPosts() async {
    QuerySnapshot querySnapshot = await _postCollection.get();
    List<Post> posts = querySnapshot.docs.map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>)).toList();
    return posts;
  }

  Future<void> addPost(Post post) async {
    await _postCollection.add(post.toMap());
  }

  Future<void> updatePost(Post post) async {
    await _postCollection.doc(post.id).update(post.toMap());
  }

  Future<void> deletePost(Post post) async {
    await _postCollection.doc(post.id).delete();
  }
}
