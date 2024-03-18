import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/post_widget.dart';
import '../widgets/posting_widget.dart';

class BlogsPage2 extends StatefulWidget {
  final String userId;
  const BlogsPage2({Key? key, required this.userId}) : super(key: key);
  @override
  State<BlogsPage2> createState() => _BlogsPage();
}

class _BlogsPage extends State<BlogsPage2> {
  final ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> _data = [];
  bool _loading = false;
  final int _perPage = 3; // Number of items to fetch per page

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  Future<void> _fetchData() async {
    if (!_loading) {
      setState(() {
        _loading = true;
      });

      QuerySnapshot querySnapshot;
      if (_data.isNotEmpty) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('post').orderBy('postingDate',
            descending: true).
            startAfterDocument(_data[_data.length - 1])
            .limit(_perPage)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('post')
            .limit(_perPage)
            .get();
      }

      setState(() {
        _loading = false;
        _data.addAll(querySnapshot.docs);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Pagination'),
      ),
      body: ListView.builder(
        itemCount: _data.length + (_loading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _data.length) {
            return ListTile(
              title: Text(_data[index]['postText']),
              // Add more fields or customize according to your Firestore schema
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
        controller: _scrollController,
      ),
    );
  }
}
