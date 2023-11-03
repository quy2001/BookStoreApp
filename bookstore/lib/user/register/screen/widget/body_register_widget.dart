import 'package:flutter/material.dart';
import '../../../../base/controller/base_provider.dart';
import '../../../../base/widgets/appbar_login_widget.dart';
import '../../../../base/widgets/button_widget.dart';
import '../../../../base/widgets/dialog_widget.dart';
import '../../../../common/values/assets.dart';
import '../../../../common/values/colors.dart';
import '../../../login_user/screen/login_user_screen.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../controller/register_provider.dart';

class BodyRegisterWidget extends StatefulWidget {
  const BodyRegisterWidget({super.key});

  @override
  State<BodyRegisterWidget> createState() => _BodyRegisterWidgetState();
}

class _BodyRegisterWidgetState extends State<BodyRegisterWidget> {
  bool _showPass = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late RegisterProvider registerProvider;

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  @override
  void initState() {
    super.initState();
    registerProvider = Provider.of<RegisterProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<RegisterProvider, Status>(builder: (context, value, child) {
      if (value == Status.loading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ProgressHUD.of(context)?.show();
        });
      } else if (value == Status.loaded) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            ProgressHUD.of(context)?.dismiss();
            showDialog(
                context: context,
                builder: (context) {
                  return DialogWidget(
                    title: 'Thành công',
                    icon: AppAssets.icoDialogSuccess,
                    cancelButton: false,
                    content: 'Bạn đã đăng ký tài khoản thành công',
                    function: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => LoginUserScreen()));
                    },
                  );
                });
            //show
          },
        );
      } else if (value == Status.error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ProgressHUD.of(context)?.dismiss();
        });
      }
      return buildData(registerProvider);
    }, selector: (context, pro) {
      return pro.statusRegister;
    });
  }

  Widget buildData(RegisterProvider provider) {
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
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      icon: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.black38,
                          )),
                      hintText: 'Nhập tên đăng nhập',
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
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              Container(
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
                    controller: _passwordController,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                    obscureText: !_showPass,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              onToggleShowPass();
                            },
                            child: _showPass == true
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.black38,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black38,
                                  )),
                        icon: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.lock,
                              color: Colors.black38,
                            )),
                        hintText: 'Nhập mật khẩu',
                        hintStyle: const TextStyle(color: Colors.black38),
                        border: InputBorder.none),
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
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                    obscureText: !_showPass,
                    obscuringCharacter: "*",
                    decoration: const InputDecoration(
                        icon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.lock,
                              color: Colors.black38,
                            )),
                        hintText: 'Nhập lại mật khẩu',
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền thông tin';
                      } else if (value != _passwordController.text) {
                        return 'Mật khẩu nhập lại không chính xác!';
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
                  title: 'Đăng ký',
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      //show dialog thông báo thành công và truyền đến trang đăng nhập
                      provider.register(context, _usernameController.text,
                          _emailController.text, _passwordController.text);
                    }
                  }),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bạn đã có tài khoản? ',
                      style: TextStyle(color: Colors.black54)),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginUserScreen()));
                    },
                    child: const Text('Đăng nhập',
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
