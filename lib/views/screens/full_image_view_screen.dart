// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// class FullImageViewScreen extends StatelessWidget {
//   final String imageUrl;
//
//   const FullImageViewScreen({Key? key, required this.imageUrl}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: const Text("Full Image")),
//       body: Center(
//         child: PhotoView(
//           imageProvider: NetworkImage(imageUrl),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class FullImageViewScreen extends StatefulWidget {
  final String imageUrl;

  const FullImageViewScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _FullImageViewScreenState createState() => _FullImageViewScreenState();
}

class _FullImageViewScreenState extends State<FullImageViewScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ Delay precache until first frame is ready (context is safe now)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        precacheImage(
          CachedNetworkImageProvider(widget.imageUrl),
          context,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // better for image view
      body: Center(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.imageUrl),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          loadingBuilder: (context, event) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
