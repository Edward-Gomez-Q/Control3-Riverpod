import 'package:controlriverpod/Riverpod/urlModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
final urlProvider=StateNotifierProvider((ref) => UrlNotifier());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:MyHomePage(),
    );
  }
}


class MyHomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url=ref.watch(urlProvider) as UrlModel;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Random Dog Image',
            ),
            url.url==''?const SizedBox(width: 200,height: 200,child: Center(child: Text('Presione el boton')),):Image.network(url.url, fit: BoxFit.cover,width: 200,height: 200,),
            ElevatedButton(onPressed: () async {
               ref.read(urlProvider.notifier).getNewImage();
            }, child: const Text('Cargar nueva Imagen')),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<String> _loadNewImage(WidgetRef ref) async {
    String url = await ref.read(urlProvider.notifier).getNewImage();
    return url;
  }
}
