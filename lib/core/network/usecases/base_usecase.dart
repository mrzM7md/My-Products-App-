abstract class BaseUseCase<T, Parameters>{
  Future<T> call({required Parameters parameters});
}