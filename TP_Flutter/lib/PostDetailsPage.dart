import 'package:flutter/material.dart';
import 'package:tp_flutter/post.dart';
import 'package:tp_flutter/postDetailsbBloc.dart';
import 'package:tp_flutter/postRepository.dart';
import 'package:tp_flutter/main.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;
  final Function() onPostUpdated;
  final Function() onPostDeleted;
  var onUpdatePost;
  var onDeletePost;

  PostDetailsPage({
    required this.post,
    required this.onUpdatePost,
    required this.onDeletePost,
    required this.onPostUpdated,
    required this.onPostDeleted,
  });

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late PostDetailsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController = TextEditingController(text: widget.post.description);
    _bloc = PostDetailsBloc(PostRepository());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void updatePost() {
    String updatedTitle = _titleController.text;
    String updatedDescription = _descriptionController.text;

    Post updatedPost = Post(
      id: widget.post.id, // Ajoutez l'argument id
      title: updatedTitle,
      description: updatedDescription,
    );
    _bloc.updatePost(updatedPost).then((_) {
      widget.onPostUpdated();
      Navigator.pop(context);
    });
  }


  void deletePost() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Voulez-vous vraiment supprimer ce post ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _bloc.deletePost(widget.post).then((_) {
                  widget.onPostDeleted();
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du poste'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Titre',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: updatePost,
                  child: Text('Mettre à jour'),
                ),
                ElevatedButton(
                  onPressed: deletePost,
                  child: Text('Supprimer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
