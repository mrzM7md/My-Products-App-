import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/authentication/data/models/auth_model.dart';
import 'package:products/authentication/presentation/controller/auth_cubit.dart';
import 'package:products/authentication/presentation/controller/auth_states.dart';
import 'package:products/core/constants/componnets.dart';
import 'package:products/core/utilities/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:products/core/utilities/images.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

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
                      SizedBox(width: double.infinity, child: buildText(align: TextAlign.center, text: "register to app to save your products", fontSize: 16, maxLines: 1, isBold: false)),

                      const SizedBox(height: 20,),
                      appTextField(preIcon: const Icon(Icons.person_outline_rounded), controller: nameController, obscureText: false, hintText: "Name", onChange: (value){},
                          validate:(value){
                            if(value.toString().isEmpty){
                              return "name required";
                            }
                            return null;
                          }),

                      const SizedBox(height: 20,),
                      appTextField(preIcon: const Icon(CupertinoIcons.at), controller: usernameController, obscureText: false, hintText: "Username", onChange: (value){},
                          validate:(value){
                            if(value.toString().isEmpty){
                              return "username required";
                            }
                            return null;
                          }),


                      const SizedBox(height: 20,),
                      appTextField(preIcon: const Icon(Icons.email_outlined), controller: emailController, obscureText: false, hintText: "Email", onChange: (value){},
                          validate:(value){
                            if(value.toString().isEmpty){
                              return "email required";
                            }
                            return null;
                          }),

                      const SizedBox(height: 20,),
                      appTextField(preIcon: const Icon(Icons.password_outlined), controller: passwordController, obscureText: true, hintText: "Password", onChange: (value){},
                          validate:(value){
                            if(value.toString().isEmpty){
                              return "password required";
                            }
                            return null;
                          }),


                      const SizedBox(height: 20,),
                      appTextField(preIcon: const Icon(Icons.password_outlined), controller: confirmPasswordController, obscureText: true, hintText: "Confirm Password", onChange: (value){},
                          validate:(value){
                            if(value.toString().isEmpty){
                              return "confirmation required";
                            }
                            if(value.toString() != passwordController.text){
                              return "confirm not equal password";
                            }
                            return null;
                          }),


                      const SizedBox(height: 40,),

                      BlocConsumer<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return ConditionalBuilder(
                            condition: (state is RegisterState) && state.status == ResponseAuthStatus.loading,
                            builder: (ctx) => const Center(child: CircularProgressIndicator(color: Colors.black,)),
                            fallback:(ctx) => appButton(onTap: (){
                                if(formKey.currentState!.validate()){
                                  String name = nameController.text;
                                  String email = emailController.text;
                                  String username = usernameController.text;
                                  String password = passwordController.text;
                                  AuthCubit.get(context).register(auth: AuthModel(name: name, email: email, password: password, confirmPassword: password, username: username));
                              }
                            }, text: "register".toUpperCase()),
                          );
                        },
                        listener: (BuildContext context, AuthState state) {
                          if(state is RegisterState && state.status != ResponseAuthStatus.loading){
                            if(state.status == ResponseAuthStatus.success){
                              getToast(message: state.message, bkgColor: Colors.white, textColor: Colors.black);
                              Navigator.pop(context);
                            }
                            else{
                              getToast(message: state.message, bkgColor: Colors.white, textColor: Colors.red);
                            }
                          }
                        },
                        buildWhen: (prev, current) => current is RegisterState,
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
                      Navigator.pop(context);
                    }, child: Text("login".toUpperCase(), style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}