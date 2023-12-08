import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key, required this.category, required this.author, required this.language});

  final String category;
  final String author;
  final String language;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.width * 0.06,
        ),
        const Text(
          'Thông tin chi tiết',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: size.width * 0.06,
        ),
        Row(
          children: [
            const Text('Thể loại : '),
            SizedBox(
              width: size.width * 0.18,
            ),
            Text(category)
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
            const Text('Tác giả : '),
            SizedBox(
              width: size.width * 0.2,
            ),
            Text(author)
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
            const Text('Ngôn ngữ : '),
            SizedBox(
              width: size.width * 0.16,
            ),
            Text(language)
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
