import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
class UrlNotifier extends StateNotifier<UrlModel>{
  UrlNotifier():super(UrlModel(url: ''));

  Future<String> getNewImage() async {
    String url = await _loadNewImage();
    state = UrlModel(url: url);
    return url;
  }

}
class UrlModel {
  String url;
  UrlModel({required this.url});
}
Future<String> _loadNewImage() async {
  String url='';
  final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    url = jsonResponse['message'];
  } else {
    url='';
  }
  return url;
}