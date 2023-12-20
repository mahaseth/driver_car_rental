import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget showImage(String url) {
  return url.isEmpty
      ? const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 25,
          child: Icon(
            Icons.person,
            size: 45,
            color: Colors.white,
          ),
        )
      : ClipOval(
          child: Image.network(
            url,
            width: 75, // Adjust the width and height as needed
            height: 75,
            fit: BoxFit.contain, // You can adjust the fit as needed
          ),
        );
}

Future<Uint8List> getImages(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
      targetHeight: width);
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
