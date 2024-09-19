enum SourceMedia { camera, gallery, none }

enum TypeInputMedia { single, multiple }

enum TypeMedia { image, video, media, none }

extension SourceMediaExtension on SourceMedia {
  String get source {
    switch (this) {
      case SourceMedia.camera:
        return 'camera';
      case SourceMedia.gallery:
        return 'gallery';
      case SourceMedia.none:
        return 'none';
    }
  }
}

extension TypeMediaExtension on TypeMedia {
  String get type {
    switch (this) {
      case TypeMedia.image:
        return 'image';
      case TypeMedia.video:
        return 'video';
      case TypeMedia.media:
        return 'media';
      case TypeMedia.none:
        return 'none';
    }
  }
}
