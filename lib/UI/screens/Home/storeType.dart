import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pietyservices/UI/map/search_location.dart';
import 'package:pietyservices/UI/screens/Home/image_corsoel.dart';
import 'package:pietyservices/UI/screens/nav_bar.dart';
import 'package:pietyservices/UI/screens/nav_image.dart';
import 'package:video_player/video_player.dart';

class storeType extends StatefulWidget {
  final DocumentReference documentReference;

  storeType({Key? key, required this.documentReference}) : super(key: key);

  @override
  State<storeType> createState() => _storeTypeState();
}

class _storeTypeState extends State<storeType> {
  TextEditingController latController = TextEditingController();

  TextEditingController lngController = TextEditingController();

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/propp-400e1.appspot.com/o/298116172_453554619982222_1725426583638973441_n.mp4?alt=media&token=577df11a-3e57-439e-9777-d5941689042d'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          ImageCarousel(),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
              ),
            ),
          ),
          GestureDetector(
              onTap: () => Get.to(
                    () => const Navpageimg(),
                    transition: Transition.cupertino,
                  ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/propp-400e1.appspot.com/o/home_c.png?alt=media&token=44d17580-38a9-4a5d-967d-577e0cf46de8'),
              ))
        ],
      ),
    );
  }
}
