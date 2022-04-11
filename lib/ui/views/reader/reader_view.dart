import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class ReaderView extends StatefulWidget {
  const ReaderView({Key? key}) : super(key: key);

  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          PhotoView(
            enableRotation: false,
            imageProvider: const CachedNetworkImageProvider(
              'https://img1.japanreader.com/uploads/20150211/5af44bf6d18eb/0014_074251.jpg',
              headers: {
                'User-Agent':
                    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',
                'Referer':
                    'https://lectortmo.com/viewer/5af44bf6d18eb/paginated/14'
              },
            ),
          ),
          PhotoView(
            enableRotation: false,
            imageProvider: const CachedNetworkImageProvider(
              'https://img1.japanreader.com/uploads/20150211/5af44bf6d18eb/0015_074251.jpg',
              headers: {
                'User-Agent':
                    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',
                'Referer':
                    'https://lectortmo.com/viewer/5af44bf6d18eb/paginated/15'
              },
            ),
          ),
        ],
      ),
    );
  }
}
