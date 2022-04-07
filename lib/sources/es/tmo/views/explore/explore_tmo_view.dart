// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:meronpan/sources/es/tmo/views/explore/widgets/filter_bottom_sheet.dart';
// import 'package:meronpan/sources/es/tmo/views/explore/widgets/widgets.dart';
// import 'package:meronpan/ui/providers/manga/selected_manga_provider.dart';
// import 'package:meronpan/ui/views/manga/manga_view.dart';
// import 'package:meronpan/ui/widgets/manga_cover.dart';

// class ExploreTmoView extends ConsumerStatefulWidget implements SourcePage {
//   const ExploreTmoView({Key? key}) : super(key: key);

//   @override
//   _ExploreTmoVieweState createState() => _ExploreTmoVieweState();

//   @override
//   String get name => 'TuMangaOnline';
// }

// class _ExploreTmoVieweState extends ConsumerState<ExploreTmoView> {
//   final ScrollController _scrollController = ScrollController();
//   int oldLength = 0;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() async {
//       if (_scrollController.position.maxScrollExtent ==
//           _scrollController.position.pixels) {
//         if (oldLength == ref.read(exploreMangasProvider).mangas!.length) {
//           ref.read(exploreMangasProvider.notifier).getMoreMangas();
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TuMangaOnline'),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.search),
//           ),
//           IconButton(
//             onPressed: () {
//               ref.read(exploreMangasProvider.notifier).refresh();
//             },
//             icon: const Icon(Icons.refresh),
//           )
//         ],
//       ),
//       body: Consumer(
//         builder: (context, ref, child) {
//           final isLoadMoreError =
//               ref.watch(exploreMangasProvider).isLoadMoreError;
//           final isLoadMoreDone =
//               ref.watch(exploreMangasProvider).isLoadMoreDone;
//           final isLoading = ref.watch(exploreMangasProvider).isLoading;
//           final mangas = ref.watch(exploreMangasProvider).mangas;

//           oldLength = mangas?.length ?? 0;

//           if (mangas == null) {
//             // error case
//             if (isLoading == false) {
//               return const Center(
//                 child: Text('error'),
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return Stack(
//             children: [
//               RefreshIndicator(
//                 onRefresh: () async {
//                   ref.read(exploreMangasProvider.notifier).refresh();
//                 },
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisSpacing: 8,
//                     crossAxisCount: 3,
//                     mainAxisExtent: 220,
//                   ),
//                   controller: _scrollController,
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   itemCount: mangas.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index == mangas.length) {
//                       if (isLoadMoreError) {
//                         return const Center(
//                           child: Text('Error'),
//                         );
//                       }
//                       // load more but reached to the last element
//                       if (isLoadMoreDone) {
//                         return const Center(
//                           child: Text(
//                             'Done!',
//                             style: TextStyle(color: Colors.green, fontSize: 20),
//                           ),
//                         );
//                       }

//                       return Container();
//                     }

//                     return GestureDetector(
//                       onTap: () {
//                         ref.read(selectedMangaProvider.notifier).state =
//                             mangas[index];
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const MangaView(),
//                           ),
//                         );
//                       },
//                       child: GridTile(
//                         child: Column(
//                           children: [
//                             MangaCover(
//                               manga: mangas[index],
//                             ),
//                             Text(
//                               mangas[index].title,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 2,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               if (isLoading)
//                 const Positioned(
//                   bottom: 40,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 )
//             ],
//           );
//         },
//       ),
//       floatingActionButton: FilterFAB(
//         onPressed: () {
//           showModalBottomSheet(
//             enableDrag: true,
//             isScrollControlled: true,
//             context: context,
//             builder: (context) {
//               return const FilterDraggableScrollableSheet();
//             },
//           );
//         },
//       ),
//     );
//   }
// }
