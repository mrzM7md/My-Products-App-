import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(appLogoImage,
                  width: 120,
                  height: 120,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text("username/email"),
                      TextFormField(
                        controller: usernameController,
                        validator: (value){
                          if(value.toString().isEmpty){
                            return "email / username required";
                          }
                          return null;
                        },
                      ),
                      const Text("password"),
                      TextFormField(
                        controller: passwordController,
                        validator: (value){
                          if(value.toString().isEmpty){
                            return "password required";
                          }
                          return null;
                        },
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return ConditionalBuilder(
                              condition: state is LoginState && state.status == ResponseAuthStatus.loading,
                              builder: (ctx) => const Center(child: CircularProgressIndicator()),
                              fallback:(ctx) => MaterialButton(
                                color: Colors.black,
                                child: const Text("Login", style: TextStyle(color: Colors.white),),
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    String username = usernameController.text;
                                    String password = passwordController.text;
                                    // wakeup..
                                    AuthCubit.get(context)
                                        .login(auth: AuthModel(name: "", email: username, password: password, confirmPassword: password, username: username));
                                  }
                                  },
                              )
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

                      MaterialButton(
                        color: Colors.black,
                        child: const Text("Register", style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
