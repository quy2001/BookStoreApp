import 'package:bookstore/common/values/assets.dart';
import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/user/login_user/controller/login_user_provider.dart';
import 'package:bookstore/user/register/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../base/controller/base_provider.dart';
import '../../../../base/widgets/appbar_login_widget.dart';
import '../../../../base/widgets/button_widget.dart';
import '../../service/secure_storage.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class BodyLoginUserWidget extends StatefulWidget {
  const BodyLoginUserWidget({super.key});

  @override
  State<BodyLoginUserWidget> createState() => _BodyLoginUserState();
}

class _BodyLoginUserState extends State<BodyLoginUserWidget> {
  bool? _isChecked = false;
  bool _showPass = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginUserProvider loginUserProvider;

  final _formKey =  GlobalKey<FormState>();

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginUserProvider =  Provider.of<LoginUserProvider>(context, listen: false);
    saveAccount();
  }

  Future saveAccount() async {
    var keyName = await SecureStorage().read('name');
    var keyPassword = await SecureStorage().read('password');
    setState(() {
      _usernameController.text = keyName ?? '';
      _passwordController.text = keyPassword ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(child: AppBarLoginWidget(title: 'Đăng nhập',)),
        Selector<LoginUserProvider, Status>(builder: (context, value, child) {
          if (value == Status.loading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.show();
            });
          } else if (value == Status.loaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              ProgressHUD.of(context)?.dismiss();
              if (_isChecked == true) {
                SecureStorage().write('name', _usernameController.text);
                SecureStorage().write('password', _passwordController.text);
              }else {
                SecureStorage().delete('name');
                SecureStorage().delete('password');
              }
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (_) => MainTabScreen()));
            });
          } else if (value == Status.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHUD.of(context)?.dismiss();
            });
          }
          return buildData(loginUserProvider);
        }, selector: (context, pro) {
          return pro.statusLogin;
        }),
      ],
    );
  }

  Widget buildData(LoginUserProvider provider){
    return  SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 25,right: 25),
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4),
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
                        border: InputBorder.none),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Vui lòng điền thông tin!';
                        }
                        return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Vui lòng điền thông tin!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                    value: _isChecked,
                    activeColor: AppColors.primaryColor,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Ghi nhớ tài khoản',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              ButtonWidget(title: 'Đăng nhập', ontap: () {
                if(_formKey.currentState!.validate()){
                  provider.login(context, _usernameController.text, _passwordController.text);
                }
              }),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nếu bạn chưa có tài khoản? ',
                      style: TextStyle(color: Colors.black54)),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Text('Đăng ký',
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
