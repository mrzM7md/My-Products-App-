import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/authentication/data/models/auth_model.dart';
import 'package:products/authentication/presentation/controller/auth_cubit.dart';
import 'package:products/authentication/presentation/controller/auth_states.dart';
import 'package:products/authentication/presentation/screens/register_screen.dart';
import 'package:products/core/constants/componnets.dart';
import 'package:products/core/utilities/enums.dart';
import 'package:products/core/utilities/images.dart';
import 'package:products/products/presentation/screens/products_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    var formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),
              Image.asset(appLogoImage,
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 40,),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: double.infinity, child: buildText(align: TextAlign.center, text: "login to recover your own products", fontSize: 16, maxLines: 1, isBold: false)),
                      const SizedBox(height: 20,),
                      appTextField(preIcon: const Icon(CupertinoIcons.at), controller: usernameController, obscureText: false, hintText: "email or username", onChange: (value){},
                          validate:(value){
                            if(value.toString().isEmpty){
                              return "email / username required";
                            }
                            return null;
                          }),

                      const SizedBox(height: 20,),
                      buildText(text: "password", fontSize: 18, maxLines: 1, isBold: true),
                      const SizedBox(height: 10,),
                      appTextField(preIcon: const Icon(Icons.password), controller: passwordController, obscureText: true, hintText: "password", onChange: (value){},
                          validate:(value){
                            if(value.toString().isEmpty){
                              return "password required";
                            }
                            return null;
                          }),

                      const SizedBox(height: 40,),

                      BlocConsumer<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return ConditionalBuilder(
                              condition: state is LoginState && state.status == ResponseAuthStatus.loading,
                              builder: (ctx) => const Center(child: CircularProgressIndicator(color: Colors.black,)),
                              fallback:(ctx) => appButton(onTap: (){
                                if(formKey.currentState!.validate()){
                                  String username = usernameController.text;
                                  String password = passwordController.text;
                                  // wakeup..
                                  AuthCubit.get(context)
                                      .login(auth: AuthModel(name: "", email: username, password: password, confirmPassword: password, username: username));
                                }
                              }, text: "Login".toUpperCase()),

                          );
                        },
                        listener: (BuildContext context, AuthState state) {
                          if(state is LoginState && state.status != ResponseAuthStatus.loading){
                            if(state.status == ResponseAuthStatus.success) {
                              getToast(message: state.message, bkgColor: Colors.white, textColor: Colors.black);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder:(ctx) => const ProductsScreen()));
                            }
                            else{
                              getToast(message: state.message, bkgColor: Colors.white, textColor: Colors.red);
                            }
                          }
                        },
                        buildWhen: (prev, current) => current is LoginState,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildText(align: TextAlign.center, text: "do you have no account? ", fontSize: 16, maxLines: 1, isBold: false),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(ctx) => const RegisterScreen()));
                  }, child: Text("register".toUpperCase(), style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
