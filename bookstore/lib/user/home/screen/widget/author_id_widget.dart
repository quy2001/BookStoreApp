import 'package:bookstore/user/home/model/author_id_response.dart';
import 'package:flutter/material.dart';
import '../../../../base/controller/consumer_base.dart';
import '../../../../common/values/styles.dart';
import '../../controller/author_id_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
class AuthorId extends StatefulWidget {
  AuthorId({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  State<AuthorId> createState() => _AuthorIdState();
}

class _AuthorIdState extends State<AuthorId> {
  late AuthorByIdProvider authorByIdProvider;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    authorByIdProvider =  Provider.of<AuthorByIdProvider>(context, listen: false);
    authorByIdProvider.data = Data(id: 0,name: '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authorByIdProvider.getAuthorById(context,widget.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return ConsumerBase<AuthorByIdProvider>(
        contextData: context,
        onRepository: (req) {
          AuthorByIdProvider provider = req;
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
          AuthorByIdProvider provider = rep;
          if (provider.isLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.dismiss();
            });
          }
          return Text(
            provider.data.name,
            style: AppStyles.subTitle,
            textAlign: TextAlign.center,
            maxLines: 2,
          );
        });
  }
}