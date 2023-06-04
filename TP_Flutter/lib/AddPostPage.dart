import 'package:flutter/material.dart';
import 'package:tp_flutter/addPostBloc.dart';
import 'package:tp_flutter/post.dart';
import 'package:tp_flutter/postRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddPostPage extends StatefulWidget {
  final AddPostBloc bloc;
  final Function(Post) onPostSaved;

  AddPostPage({required this.bloc, required this.onPostSaved});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un poste'),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String title = _titleController.text;
          String description = _descriptionController.text;
          String postId = await widget.bloc.addPost(title, description);
          // Ajoutez cette ligne pour stocker l'ID du post

          await widget.bloc.addPost(title, description).then((id) {
            postId = id; // Récupérez l'ID du post après son ajout dans Firestore
          });

          widget.onPostSaved(Post(id: postId, title: title, description: description)); // Utilisez l'ID du post lors de la création de l'objet Post
          Navigator.pop(context);
        },

        child: Icon(Icons.save),
      ),
    );
  }
}
