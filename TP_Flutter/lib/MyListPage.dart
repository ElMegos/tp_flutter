import 'package:flutter/material.dart';
import 'package:tp_flutter/addPostPage.dart';
import 'package:tp_flutter/listWidget.dart';
import 'package:tp_flutter/post.dart';
import 'package:tp_flutter/postDetailsPage.dart';
import 'package:tp_flutter/myListBloc.dart';
import 'package:tp_flutter/postRepository.dart';
import 'package:tp_flutter/addPostBloc.dart';

class MyListPage extends StatefulWidget {
  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  late MyListBloc _bloc;
  late AddPostBloc _addPostBloc = AddPostBloc(PostRepository()); // Ajoutez cette ligne pour créer une instance de AddPostBloc

  @override
  void initState() {
    super.initState();
    _bloc = MyListBloc(PostRepository());
    _addPostBloc = AddPostBloc(PostRepository()); // Initialisez l'instance de AddPostBloc
  }

  @override
  void dispose() {
    _bloc.dispose();
    //A suprimer maybe
    _addPostBloc.dispose(); // N'oubliez pas de disposer l'instance de AddPostBloc
    super.dispose();
  }

  void addPost(Post post) {
    _bloc.addPost(post);
  }

  void updatePost(Post updatedPost) {
    _bloc.updatePost(updatedPost);
  }

  void deletePost(Post post) {
    _bloc.deletePost(post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma liste'),
      ),
      body: StreamBuilder<List<Post>>(
        stream: _bloc.postListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data!;
            return ListWidget(
              items: posts,
              onUpdatePost: updatePost,
              onDeletePost: deletePost,
              onPostUpdated: () => _bloc.getPosts(),
              onPostDeleted: () => _bloc.getPosts(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Une erreur s\'est produite.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostPage(
                bloc: _addPostBloc, // Utilisez l'instance de AddPostBloc
                onPostSaved: addPost,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
