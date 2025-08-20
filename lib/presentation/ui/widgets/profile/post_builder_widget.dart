import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget postListViewBuilder(List<String> posts) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.only(top: 4),
    child: ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return const SizedBox(
            height: 70,
          );
        }
        return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child:
                  Image.network(posts[index], height: 250, fit: BoxFit.cover),
            ));
      },
      shrinkWrap: true,
      itemCount: posts.length + 1,
    ),
  ));
}

Widget postGridViewBuilder(List<String> posts) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.only(top: 8),
    child: GridView.custom(
      padding: const EdgeInsets.only(top: 0),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(1, 2),
          const QuiltedGridTile(1, 2),
          //QuiltedGridTile(1, 1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(childCount: posts.length,
          (context, index) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              posts[index],
              fit: BoxFit.cover,
            ));
      }),
      shrinkWrap: true,
    ),
  ));
}
