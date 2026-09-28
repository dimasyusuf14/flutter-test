import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/enum/data_load.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

class AvatarProfile extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final double size;
  final DataLoad isLoading;

  const AvatarProfile({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.size = 36,
    this.isLoading = DataLoad.done,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = this.imageUrl;
    final imageFile = this.imageFile;
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: size / 2,
            backgroundColor: kColorGray200,
            backgroundImage:
                imageFile != null
                    ? FileImage(imageFile)
                    : imageUrl != null
                    ? CachedNetworkImageProvider(imageUrl)
                    : null,
            child:
                imageFile == null &&
                        imageUrl == null &&
                        isLoading == DataLoad.done
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
          ),
          if (isLoading == DataLoad.loading)
            const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
