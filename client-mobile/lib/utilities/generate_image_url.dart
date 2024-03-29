import '../config/api_constants.dart';

class GenerateImageUrl {
  static String getImage(String image) {
    if (image.startsWith('../')) {
      image = image.substring(3);
    }
    String url = "${ApiConstants.baseUrl}/$image";
    return url;
  }
}
