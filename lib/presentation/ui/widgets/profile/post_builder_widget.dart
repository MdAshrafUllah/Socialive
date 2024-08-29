import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget postListViewBuilder(List<String> posts) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.only(top: 4),
    child: ListView.builder(
      itemBuilder: (context, index) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Image.network(posts[index], fit: BoxFit.cover),
            ));
      },
      shrinkWrap: true,
      itemCount: posts.length,
    ),
  ));
}

Widget postGridViewBuilder(List<String> posts) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.only(top: 8),
    child: GridView.custom(
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
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              posts[index],
              fit: BoxFit.cover,
            )),
      ),
      shrinkWrap: true,
    ),
  ));
}
