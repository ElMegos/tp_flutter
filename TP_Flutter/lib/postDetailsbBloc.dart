import 'dart:async';

import 'package:tp_flutter/post.dart';
import 'package:tp_flutter/postRepository.dart';

class PostDetailsBloc {
  final PostRepository _repository;

  PostDetailsBloc(this._repository);

  Future<void> updatePost(Post updatedPost) async {
    await _repository.updatePost(updatedPost);
  }

  Future<void> deletePost(Post post) async {
    await _repository.deletePost(post);
  }
}
