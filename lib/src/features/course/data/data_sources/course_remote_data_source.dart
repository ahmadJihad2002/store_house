import 'package:store_house/core/errors/exception.dart';
import 'package:store_house/core/utils/dummy_data.dart';
import 'package:store_house/src/features/course/data/models/course_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getCourses();

  Future<List<CourseModel>> getFeaturedCourses();

  Future<List<CourseModel>> getRecommendCourses();

  Future<List<CourseModel>> getAllGoods();
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  @override
  Future<List<CourseModel>> getCourses() async {
    //==== Todo: implement the call to real api =====
    try {
      // dummy data
      return courses.map((e) => CourseModel.fromMap(e)).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<CourseModel>> getFeaturedCourses() async {
    //==== Todo: implement the call to real api =====
    try {
      // dummy data
      return features.map((e) => CourseModel.fromMap(e)).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<CourseModel>> getRecommendCourses() async {
    //==== Todo: implement the call to real api =====
    try {
      // dummy data
      return recommends.map((e) => CourseModel.fromMap(e)).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<CourseModel>> getAllGoods() {
    // TODO: implement getAllGoods
    throw UnimplementedError();
  }
}
