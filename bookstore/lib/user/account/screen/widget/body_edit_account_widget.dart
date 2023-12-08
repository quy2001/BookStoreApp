import 'package:flutter/material.dart';
import '../../../../base/widgets/button_widget.dart';
import '../../../../common/values/colors.dart';
import '../../controller/account_provider.dart';
import 'package:provider/provider.dart';
class BodyEditAccountWidget extends StatefulWidget {
   BodyEditAccountWidget({super.key, required this.name, required this.email});

   String name;
   String email;

  @override
  State<BodyEditAccountWidget> createState() => _BodyEditAccountWidgetState();
}

class _BodyEditAccountWidgetState extends State<BodyEditAccountWidget> {
  bool _showPass = false;
   TextEditingController _usernameController = TextEditingController();
   TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late AccountProvider accountProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.text = widget.name;
    _emailController.text = widget.email;
  }

  void editAccount(BuildContext context){
    accountProvider = Provider.of<AccountProvider>(context,listen: false);
    accountProvider.editAccount(context,_usernameController.text, _emailController.text);

  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            left: 25, right: 25, top: MediaQuery.of(context).size.width * 0.2),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 20),
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.primaryLightColor,
                        blurRadius: 10,
                      )
                    ]),
                child: Center(
                  child: TextFormField(
                    controller: _usernameController,
                    // initialValue: widget.name.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      icon: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.black38,
                          )),
                      // hintText: 'Nhập tên tài khoản',
                      hintStyle: TextStyle(color: Colors.black38),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền thông tin!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.primaryLightColor,
                        blurRadius: 10,
                      )
                    ]),
                child: Center(
                  child: TextFormField(
                    controller: _emailController,
                    // initialValue: widget.email.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                        icon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.email,
                              color: Colors.black38,
                            )),
                        hintText: 'Nhập email',
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền thông tin!';
                      } else if (!value.contains("@") || !value.contains(".")) {
                        return 'Không đúng định dạng email!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ),
              ButtonWidget(
                  title: 'Cập nhật thông tin',
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      editAccount(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
