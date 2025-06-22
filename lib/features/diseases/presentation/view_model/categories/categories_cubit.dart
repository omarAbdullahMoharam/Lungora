import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/diseases/data/model/category_model.dart';
import 'package:lungora/features/diseases/data/repo/disease_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.diseaseRepo) : super(CategoriesInitial());
  final DiseaseRepo diseaseRepo;
  void getAllCategories() async {
    emit(CategoriesLoading());
    try {
      final articles = await diseaseRepo.getArticles();
      if (articles.isSuccess) {
        emit(CategoriesSuccess(categories: articles.category));
      } else {
        emit(CategoriesFailure(errMessage: "Failed to load categories"));
      }
    } catch (e) {
      log("Error fetching categories: $e");
      emit(CategoriesFailure(errMessage: e.toString()));
    }
  }
}
