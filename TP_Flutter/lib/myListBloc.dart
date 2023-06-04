import 'dart:async';

import 'package:tp_flutter/post.dart';
import 'package:tp_flutter/postRepository.dart';

class MyListBloc {
  final PostRepository _repository;
  StreamController<List<Post>> _postListController = StreamController<List<Post>>.broadcast();

  Stream<List<Post>> get postListStream => _postListController.stream;

  MyListBloc(this._repository) {
    getPosts();
  }

  Future<void> getPosts() async {
    List<Post> posts = await _repository.getPosts();
    _postListController.add(posts);
  }

  Future<void> updatePost(Post updatedPost) async {
    await _repository.updatePost(updatedPost);
    getPosts();
  }

  Future<void> deletePost(Post post) async {
    await _repository.deletePost(post);
    getPosts();
  }

  Future<void> addPost(Post post) async {
    await _repository.addPost(post);
    getPosts();
  }

  void dispose() {
    _postListController.close();
  }
}
