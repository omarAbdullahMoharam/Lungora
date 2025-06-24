part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  const CategoriesSuccess({required this.categories});

  @override
  List<Object> get props => [categories];
}

final class CategoriesFailure extends CategoriesState {
  final String errMessage;

  const CategoriesFailure({
    required this.errMessage,
  });

  @override
  List<Object> get props => [errMessage];
}
