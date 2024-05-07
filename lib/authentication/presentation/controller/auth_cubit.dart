import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/authentication/domain/entities/auth.dart';
import 'package:products/authentication/domain/usecases/login_usecase.dart';
import 'package:products/authentication/domain/usecases/register_new_account_usecase.dart';
import 'package:products/authentication/presentation/controller/auth_states.dart';
import 'package:products/core/local/cache_helper.dart';
import 'package:products/core/utilities/enums.dart';

class AuthCubit extends Cubit<AuthState> {

  final LoginUseCase loginUseCase;
  final RegisterNewAccountUseCase registerNewAccountUseCase;
  AuthCubit({required this.loginUseCase, required this.registerNewAccountUseCase}) : super(InitialAuthState());

  static AuthCubit get(context) => BlocProvider.of(context);

  // ############### Start Login Business // ###############
  void login({required Auth auth}){
    emit(const LoginState(status: ResponseAuthStatus.loading, message: "Loading")); // emit = call state
    loginUseCase(parameters: LoginParameters(auth: auth)).then((authResponse) {
        emit(LoginState(status: authResponse.statue, message: authResponse.message));
        if (authResponse.statue == ResponseAuthStatus.success){
          _storeUserInfoInsideSharedPreferences(auth: authResponse.data!);
        }
    });
  }
  // ############### End Register Business // ###############


  // ############### Start Register Business // ###############
  void register({required Auth auth}){
    emit(const RegisterState(status: ResponseAuthStatus.loading, message: "Loading"));
    registerNewAccountUseCase(parameters: RegisterParameters(auth: auth)).then((authResponse) {
      emit(RegisterState(status: authResponse.statue, message: authResponse.message));
    });
  }
  // ############### End Register Business // ###############


  // ############### Start Helper Methods // ###############
  void _storeUserInfoInsideSharedPreferences({required Auth auth}) {
    CacheHelper.setData(key: "user_id", value: auth.id!.toInt());
    CacheHelper.setData(key: "user_name", value: auth.name.toString());
    CacheHelper.setData(key: "user_username", value: auth.username.toString());
    CacheHelper.setData(key: "user_email", value: auth.email.toString());
  }
// ############### End Helper Methods // ###############


}