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
  final _pageController = PageController(
    initialPage: 0,
  );
  double sliderValue = 0;
  int _currentPage = 0;

  bool _isVisible = false;

  bool _startAnimation = false;

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
    final pages = [
      PhotoView(
        enableRotation: false,
        imageProvider: const CachedNetworkImageProvider(
          'https://img1.japanreader.com/uploads/20150211/5af44bf6d18eb/0014_074251.jpg',
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',
            'Referer': 'https://lectortmo.com/viewer/5af44bf6d18eb/paginated/14'
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
            'Referer': 'https://lectortmo.com/viewer/5af44bf6d18eb/paginated/15'
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
            'Referer': 'https://lectortmo.com/viewer/5af44bf6d18eb/paginated/15'
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
            'Referer': 'https://lectortmo.com/viewer/5af44bf6d18eb/paginated/15'
          },
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Finalizado:',
              style: TextStyle(color: Colors.black),
            ),
            Text('Capítulo XXX: <Nombre del capítulo>')
          ],
        ),
      )
    ];
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });

              Future.delayed(
                const Duration(milliseconds: 1),
                () {
                  setState(() {
                    _startAnimation = !_startAnimation;
                  });
                },
              );
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                controller: _pageController,
                onPageChanged: (val) {
                  setState(
                    () {
                      _currentPage = val;
                    },
                  );
                },
                children: pages,
              ),
            ),
          ),
          AnimatedPositioned(
            top: _startAnimation ? 0 : -30,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 100),
            child: Visibility(
              visible: _isVisible,
              child: Container(
                height: 70,
                color: Colors.redAccent,
                child: Row(
                  children: const [
                    Text('<title>'),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: _startAnimation ? 30 : 0,
            left: 16,
            right: 16,
            duration: const Duration(milliseconds: 100),
            child: Visibility(
              visible: _isVisible,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 50,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous_rounded),
                      tooltip: 'Siguiente',
                    ),
                    Text(pages.length.toString()),
                    Expanded(
                      child: Slider(
                        label: '${_currentPage + 1}',
                        max: 4,
                        min: 0,
                        divisions: 4,
                        onChanged: (value) {
                          setState(() {
                            _currentPage = value.round();
                          });
                        },
                        onChangeEnd: (val) {
                          _pageController.animateToPage(
                              val.round(), // this line changed.
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                        value: _currentPage.toDouble(),
                      ),
                    ),
                    Text((_currentPage + 1).toString()),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next_rounded),
                      tooltip: 'Previo',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
