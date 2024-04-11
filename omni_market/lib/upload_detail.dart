import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UploadDetails extends StatefulWidget {
  const UploadDetails({Key? key}) : super(key: key);

  @override
  State<UploadDetails> createState() => _UploadDetailsState();
}

class _UploadDetailsState extends State<UploadDetails> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  final List<MediaItem> mediaItems = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      selectedImages.forEach((image) => mediaItems
          .add(MediaItem(type: MediaType.image, file: File(image.path))));
      setState(() {});
    }
  }

  Future<void> pickVideoFromGallery() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      final videoFile = File(pickedVideo.path);
      try {
        final videoPlayerController = VideoPlayerController.file(videoFile);
        await videoPlayerController.initialize();
        mediaItems.add(MediaItem(
            type: MediaType.video,
            videoPlayerController: videoPlayerController));
        setState(() {});
      } catch (e) {
        print('Error initializing video: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error loading video. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    for (var item in mediaItems) {
      if (item.type == MediaType.video) {
        item.videoPlayerController?.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (mediaItems.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1,
                          mainAxisExtent: 250,
                          crossAxisCount: 3,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: mediaItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          final mediaItem = mediaItems[index];

                          switch (mediaItem.type) {
                            case MediaType.image:
                              return Image.file(
                                mediaItem.file!,
                                fit: BoxFit.cover,
                              );

                            case MediaType.video:
                              return Stack(
                                children: [
                                  mediaItem.videoPlayerController!.value
                                          .isInitialized
                                      ? VideoPlayer(
                                          mediaItem.videoPlayerController!)
                                      : const SizedBox(),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: FloatingActionButton(
                                      mini: true,
                                      onPressed: () {
                                        if (mediaItem.videoPlayerController!
                                            .value.isPlaying) {
                                          mediaItem.videoPlayerController!
                                              .pause();
                                        } else {
                                          mediaItem.videoPlayerController!
                                              .play();
                                        }
                                        setState(() {});
                                      },
                                      child: Icon(
                                        mediaItem.videoPlayerController!.value
                                                .isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                          }
                        },
                      ),
                    ),
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            pickVideoFromGallery();
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.videocam,
                                size: 50,
                              ),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text(
                                'Upload A Video',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            selectImages();
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 55,
                              ),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text(
                                'Upload A Photos',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 60),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // print('Form submitted!');
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Please enter proper information',
                            style: TextStyle(color: Colors.red),
                          ),
                          backgroundColor: Colors.white,
                        ));
                      }
                    },
                    child: const Text(
                      'SUBMIT REQUEST',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MediaItem {
  final MediaType type;
  final File? file;
  final VideoPlayerController? videoPlayerController;

  MediaItem({required this.type, this.file, this.videoPlayerController});
}

enum MediaType {
  image,
  video,
}
