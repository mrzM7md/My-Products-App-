import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/authentication/data/models/auth_model.dart';
import 'package:products/authentication/presentation/controller/auth_cubit.dart';
import 'package:products/authentication/presentation/controller/auth_states.dart';
import 'package:products/core/constants/componnets.dart';
import 'package:products/core/utilities/enums.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text("name"),
                TextFormField(
                  controller: nameController,
                  validator: (value){
                    if(value.toString().isEmpty){
                      return "name required";
                    }
                    return null;
                  },
                ),
                const Text("username"),

                TextFormField(
                  controller: usernameController,
                  validator: (value){
                    if(value.toString().isEmpty){
                      return "username required";
                    }
                    return null;
                  },
                ),

                const Text("email"),
                TextFormField(
                  controller: emailController,
                  validator: (value){
                    if(value.toString().isEmpty){
                      return "email required";
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
                        condition: (state is RegisterState) && state.status == ResponseAuthStatus.loading,
                        builder: (ctx) => const Center(child: CircularProgressIndicator()),
                        fallback:(ctx) => MaterialButton(
                          color: Colors.black,
                          child: const Text("Register", style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              String name = nameController.text;
                              String email = emailController.text;
                              String username = usernameController.text;
                              String password = passwordController.text;
                              AuthCubit.get(context).register(auth: AuthModel(name: name, email: email, password: password, confirmPassword: password, username: username));
                            }
                           },
                        )
                    );
                  }, listener: (BuildContext context, AuthState state) {
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
                MaterialButton(
                  color: Colors.black,
                  child: const Text("Login", style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
