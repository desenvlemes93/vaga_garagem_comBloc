import 'package:flutter/material.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  bool _loading = false;

  void showLoader() {
    if (!_loading) {
      _loading = true;
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.amber,
          ));
        },
      );
    }
  }

  void hideLoader() {
    if (_loading) {
      _loading = false;
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    hideLoader();
    super.dispose();
  }
}
