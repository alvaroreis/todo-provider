import './tasks_service.dart';
import '../../domain/dto/total_tasks_dto.dart';
import '../../domain/dto/week_tasks_dto.dart';
import '../../domain/models/task_model.dart';
import '../../repositories/tasks/tasks_repository.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) {
    return _tasksRepository.save(date, description);
  }

  @override
  Future<List<TaskModel>> findAllToday() {
    final date = DateTime.now();
    return _tasksRepository.findByPeriod(date, date);
  }

  @override
  Future<List<TaskModel>> findAllTomorrow() {
    final date = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findByPeriod(date, date);
  }

  @override
  Future<WeekTasksDTO> findAllWeek() async {
    final weekDays = _weekDays;
    final listModels = await _tasksRepository.findByPeriod(
      weekDays.first,
      weekDays.last,
    );
    return WeekTasksDTO(
      start: weekDays.first,
      end: weekDays.last,
      tasks: listModels,
    );
  }

  @override
  Future<TotalTasksDTO> countToday() {
    final date = DateTime.now();
    return _tasksRepository.countByPeriod(date, date);
  }

  @override
  Future<TotalTasksDTO> countTomorrow() {
    final date = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.countByPeriod(date, date);
  }

  @override
  Future<TotalTasksDTO> countWeek() async {
    final weekDays = _weekDays;
    return _tasksRepository.countByPeriod(
      weekDays.first,
      weekDays.last,
    );
  }

  List<DateTime> get _weekDays {
    final today = DateTime.now();
    DateTime start = DateTime(today.year, today.month, today.day, 0, 0, 0);
    if (start.weekday != DateTime.monday) {
      start.subtract(Duration(days: (start.weekday - 1)));
    }
    final end = start.add(const Duration(days: 7));

    return [start, end];
  }

  @override
  Future<void> updateStatus({required bool finish, required int taskId}) {
    return _tasksRepository.updateStatus(finish: finish, taskId: taskId);
  }
}
