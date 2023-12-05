
import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/src/features/course/domain/entities/course.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<List<Course>> getCourses();
  ResultFuture<List<Course>> getFeaturedCourses();
  ResultFuture<List<Course>> getRecommendCourses();
}
