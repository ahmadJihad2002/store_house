//
// import 'package:get_it/get_it.dart';
// import 'package:store_house/src/features/auth/data/data_sources/course_remote_data_source.dart';
//  import 'package:store_house/src/features/course/data/repositories/course_repository_impl.dart';
// import 'package:store_house/src/features/course/domain/repositories/course_repository.dart';
// import 'package:store_house/src/features/course/domain/usecases/get_course.dart';
// import 'package:store_house/src/features/course/domain/usecases/get_feature_course.dart';
// import 'package:store_house/src/features/course/domain/usecases/get_recommend_course.dart';
// import 'package:store_house/src/features/course/pesentation/bloc/explore/course_bloc.dart';
// import 'package:store_house/src/features/course/pesentation/bloc/feature/feature_course_bloc.dart';
// import 'package:store_house/src/features/course/pesentation/bloc/recommend/recommend_course_bloc.dart';
//
// final locator = GetIt.instance;
//
// Future initLocator() async {
//   locator
//     ..registerFactory(() => CourseBloc(
//         getCourseUseCase: locator(), getFeaturedCourseUseCase: locator()))
//     ..registerLazySingleton(() => GetCourseUseCase(locator()))
//     ..registerLazySingleton<CourseRepository>(
//         () => CourseRepositoryImpl(locator()))
//     ..registerLazySingleton<AuthRemoteDataSource>(
//         () => AuthDataSourceImpl());
//
//   locator
//     ..registerFactory(() => FeatureCourseBloc(locator()))
//     ..registerLazySingleton(() => GetFeatureCourseUseCase(locator()));
//
//   locator
//     ..registerFactory(() => RecommendCourseBloc(locator()))
//     ..registerLazySingleton(() => GetRecommendCourseUserCase(locator()));
// }
