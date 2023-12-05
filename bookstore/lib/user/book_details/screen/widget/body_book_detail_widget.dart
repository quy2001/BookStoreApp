import 'package:bookstore/user/book_details/controller/book_provider.dart';
import 'package:bookstore/user/read_book/screen/read_book_screen.dart';
import 'package:flutter/material.dart';
import '../../../../base/controller/consumer_base.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../model/book_response.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class BodyBookDetailWidget extends StatefulWidget {
  BodyBookDetailWidget({super.key, required this.id, required this.statusBook});
  final int id;
  final bool statusBook;
  @override
  State<BodyBookDetailWidget> createState() => _BodyBookDetailWidgetState();
}

class _BodyBookDetailWidgetState extends State<BodyBookDetailWidget> {
  late BookProvider bookProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookProvider.getBookDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: ConsumerBase<BookProvider>(
            contextData: context,
            onRepository: (rep) {
              BookProvider pro = rep;
              if (pro.isLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ProgressHUD.of(context)?.show();
                });
              }
              return const SizedBox();
            },
            onRepositoryError: (rep) {
              return Center(
                  child: Text(
                rep.messagesError ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ));
            },
            onRepositoryNoData: (rep) {
              return const Center(
                child: Text(
                  'Không có dữ liệu',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              );
            },
            onRepositorySuccess: (rep) {
              BookProvider pro = rep;
              if (pro.isLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ProgressHUD.of(context)?.dismiss();
                });
              }
              return buildData(pro.book);
            }),
      ),
    );
  }

  Widget buildData(Book book) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                book.cover,
                width: size.width * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: AppStyles.titleBookDetails,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    book.aname,
                    style: AppStyles.subTitle,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: RatingBar.builder(
                      initialRating: 3.5,
                      // double.tryParse(widget.srObj["rate"].toString()) ?? 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: book.price.toString(),
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                          const TextSpan(
                            text: " VNĐ",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w600),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  widget.statusBook == true
                      ? Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Container(
                                height: 35.0,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: AppColors.button),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.primaryColor,
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => ReadBookScreen(
                                                linkBook: book.file.toString(),
                                                titleBook: book.name)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: Text(
                                    'Đọc sách',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 35,
                                )),
                          ],
                        )
                      : Container(
                          height: 35.0,
                          decoration: BoxDecoration(
                              gradient:
                                  LinearGradient(colors: AppColors.button),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.primaryColor,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                )
                              ]),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            child: Text(
                              'Thêm vào giỏ hàng',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(book.description),
        SizedBox(
          height: size.width * 0.06,
        ),
        Text(
          'Thông tin chi tiết',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: size.width * 0.06,
        ),
        Row(
          children: [
            Text('Thể loại : '),
            SizedBox(
              width: size.width * 0.18,
            ),
            Text(book.cname)
          ],
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        SizedBox(
          height: size.width * 0.06,
        ),
        Row(
          children: [
            Text('Tác giả : '),
            SizedBox(
              width: size.width * 0.2,
            ),
            Text(book.aname)
          ],
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        SizedBox(
          height: size.width * 0.06,
        ),
        Row(
          children: [
            Text('Ngôn ngữ : '),
            SizedBox(
              width: size.width * 0.15,
            ),
            Text('Tiếng Việt')
          ],
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
