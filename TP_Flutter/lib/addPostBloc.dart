import 'package:tp_flutter/post.dart';
import 'package:tp_flutter/postRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddPostBloc {
  final PostRepository _repository;

  AddPostBloc(this._repository);

  Future<String> addPost(String title, String description) async {
    if (title.isNotEmpty && description.isNotEmpty) {
      CollectionReference postCollection = FirebaseFirestore.instance.collection('post');

      DocumentReference docRef = await postCollection.add({
        'title': title,
        'description': description,
      });

      return docRef.id;
    }

    return '';
  }



  void dispose() {}


}
