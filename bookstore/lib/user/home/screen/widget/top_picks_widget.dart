import 'package:bookstore/base/controller/consumer_base.dart';
import 'package:bookstore/common/values/styles.dart';
import 'package:bookstore/user/home/controller/author_id_provider.dart';
import 'package:bookstore/user/home/controller/top_picks_provider.dart';
import 'package:bookstore/user/home/model/top_picks_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../../../base/service/dio_option.dart';
import '../../service/author_id_service.dart';
import 'author_id_widget.dart';

class TopPicksWidget extends StatefulWidget {
  const TopPicksWidget({Key? key}) : super(key: key);

  @override
  State<TopPicksWidget> createState() => _TopPicksWidgetState();
}

class _TopPicksWidgetState extends State<TopPicksWidget> {
  late TopPickProvider topPickProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topPickProvider = Provider.of<TopPickProvider>(context, listen: false);
    topPickProvider.topPickArr = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      topPickProvider.getTopPick(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: ConsumerBase<TopPickProvider>(
          contextData: context,
          onRepository: (req) {
            TopPickProvider provider = req;
            if (provider.isLoading) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ProgressHUD.of(context)?.show();
              });
            }
            return const SizedBox();
          },
          onRepositoryError: (req) {
            return Center(
                child: Text(
              req.messagesError ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ));
          },
          onRepositoryNoData: (req) {
            return const Center(
              child: Text(
                'Không có dữ liệu',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            );
          },
          onRepositorySuccess: (rep) {
            TopPickProvider provider = rep;
            if (provider.isLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ProgressHUD.of(context)?.dismiss();
              });
            }
            return SizedBox(
              width: size.width,
              height: size.width * 0.8,
              child: CarouselSlider.builder(
                // itemCount: provider.topPickArr.length,
                itemCount: 5,
                itemBuilder: (BuildContext context, int itemIndex,
                    int pageViewIndex) {
                  return builData(context,provider.topPickArr[itemIndex]);
                },
                options: CarouselOptions(
                  autoPlay: false,
                  // autoPlayInterval: const Duration(seconds: 4),
                  aspectRatio: 1,
                  enlargeCenterPage: true,
                  viewportFraction: 0.45,
                  enlargeFactor: 0.4,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                ),
              ),
            );
          }),
    );
  }
}

Widget builData (BuildContext context, TopPick topPick){
  var size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    child: GestureDetector(
      onTap: (){
        print('sách nè');
      },
      child: SizedBox(
        width: size.width * 0.32,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 4),
                      blurRadius: 5,
                    )
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  topPick.cover,
                  width: size.width * 0.32,
                  height: size.width * 0.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              // iObj["name"].toString(),
              topPick.name,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: AppStyles.titleBook,
            ),
          MultiProvider(providers: [
            ChangeNotifierProvider(
                create: (context)=>AuthorByIdProvider(AuthorIdServices(DioOption().createDio()))),
          ],
            child:AuthorId(id: topPick.idAuthor),
          ),
          ],
        ),
      ),
    ),
  );
}

