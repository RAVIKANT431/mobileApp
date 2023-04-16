import 'package:apnaexam/drawerPage/sideMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class SearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }



class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(title: Text("Search"),),
        body: Center(child: Text("SearchPage")),
    );
  }
}
