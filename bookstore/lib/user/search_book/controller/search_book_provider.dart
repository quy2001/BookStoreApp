import 'package:bookstore/base/controller/base_provider.dart';
import 'package:bookstore/user/search_book/model/search_book_request.dart';
import 'package:bookstore/user/search_book/service/book_service.dart';
import 'package:dio/dio.dart';
import '../../login_user/service/secure_storage.dart';
import '../model/search_books_response.dart';
class SearchBookProvider extends BaseProvider<SearchBookServices>{
  SearchBookProvider(SearchBookServices service) : super(service);

  List<SearchBook> listBook=[];
  List<SearchBook> listBookDisplay=[];
  String name = '';
  Status statusBook = Status.none;

  int page =1;
  int idAuthor = 0;
  int idCategory =0;
  late bool canLoadMore;
  bool refresh = false;

  //truyền vào các id để reset khi vào sách của tác giả, sách của thể loại.
  void resetPage({int? idAu, int? idCa}) {
    page = 1;
    idAuthor = idAu ?? 0;
    idCategory =idCa ?? 0;
    name='';
    canLoadMore = true;
  }

  void loadMore() {
    if (canLoadMore) {
      page += 1;
      getListBook();
    }
  }

  void search(String nameSearch) {
    if(nameSearch != ''){
      page = 1;
      name = nameSearch;
      listBookDisplay=[];
      getListBook();
    }else{
      resetPage();
      listBookDisplay=[];
      getListBook();
    }
  }

  void searchAuthCate(int idFAuthor, int idFCategory){
    resetPage();
    page = 1;
    idAuthor = idFAuthor;
    idCategory = idFCategory;
    listBookDisplay=[];
    getListBook();
  }

  Future<void> getListBook() async{
    resetStatus();
    try{
      startLoading(() {
        statusBook = Status.loading;
      });
      var keyidUser = await SecureStorage().read('idUser');
      listBook = await service.postSearchBook(request: SearchBookRequest(
          idAuthor: idAuthor,
          idCategory: idCategory,
          page: page,
          name: name,
          userid: int.parse(keyidUser))
      );
      if(refresh == true){
        listBookDisplay = listBook;
        refresh = false;
      }else{
        listBookDisplay += listBook;
      }
      if(listBook.length < 5){
        canLoadMore = false;
      }
      // if (listBook.isNotEmpty) {
        finishLoading(() {
          statusBook = Status.loaded;
        });
      // } else {
      //   receivedNoData(() {
      //     statusBook = Status.noData;
      //   });
      // }
    }on DioException catch (e){
      messagesError = e.message ?? 'Có lỗi hệ thống';
      receivedError(() {
        statusBook = Status.error;
      });
      canLoadMore = false;
    }
  }
}