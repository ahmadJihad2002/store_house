
import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
import 'package:store_house/src/features/course/domain/entities/course.dart';
import 'package:store_house/src/features/course/domain/repositories/course_repository.dart';

class GetFeatureCourseUseCase extends UseCaseWithoutParams<List<Course>> {
  const GetFeatureCourseUseCase(this._courseRepository);
  final CourseRepository _courseRepository;
  @override
  ResultFuture<List<Course>> call() async {
    return await _courseRepository.getFeaturedCourses();
  }
}
