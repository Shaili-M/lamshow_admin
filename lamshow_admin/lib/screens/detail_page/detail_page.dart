import 'package:flutter/material.dart';
import 'package:lamshow_admin/models/lams.dart';

class DetailPage extends StatelessWidget {
  static String routeName = "/home_screen";

  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lol = ModalRoute.of(context)!.settings.arguments as Map;
    List<Lams> list = lol['list'];
    int index = lol['index'];
    PageController pageController = PageController(initialPage: index);
    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, ind) {
        return Hero(
          tag: list[ind].title!,
          child: Image.network(list[ind].image!),
        );
      },
      itemCount: list.length,
    );
  }
}
