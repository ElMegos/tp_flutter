import 'package:flutter/material.dart';
import 'package:tp_flutter/post.dart';
import 'package:tp_flutter/postDetailsPage.dart';

class ListWidget extends StatelessWidget {
  final List<Post> items;
  final Function(Post) onUpdatePost;
  final Function(Post) onDeletePost;
  final Function() onPostUpdated; // Ajoutez cette ligne pour déclarer la fonction onPostUpdated
  final Function() onPostDeleted; // Ajoutez cette ligne pour déclarer la fonction onPostDeleted

  const ListWidget({
    required this.items,
    required this.onUpdatePost,
    required this.onDeletePost,
    required this.onPostUpdated,
    required this.onPostDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailsPage(
                  post: items[index],
                  onUpdatePost: onUpdatePost,
                  onDeletePost: onDeletePost,
                  onPostUpdated: onPostUpdated, // Ajoutez cette ligne pour passer la fonction onPostUpdated
                  onPostDeleted: onPostDeleted, // Ajoutez cette ligne pour passer la fonction onPostDeleted
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].description),
          ),
        );
      },
    );
  }
}
