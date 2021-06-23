import 'package:hive/hive.dart';
import 'package:simple_todo_flutter/data/models/task/task.dart';
import 'package:simple_todo_flutter/resources/constants.dart';
import 'package:uuid/uuid.dart';

part 'task_regular.g.dart';

@HiveType(typeId: Models.TASK_REGULAR_ID)
class TaskRegular {

  @HiveField(0)
  String id = "${Uuid().v1()}";

  @HiveField(1)
  late String title = Constants.EMPTY_STRING;

  @HiveField(2)
  String description = Constants.EMPTY_STRING;

  @HiveField(3)
  List<CheckItem> checkList = [];

  @HiveField(4)
  int? time;

  @HiveField(5)
  int? initialDate;

  @HiveField(6)
  int? repeat;

  @HiveField(7)
  List<bool> repeatLayout = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @HiveField(8)
  bool status = Status.INCOMPLETE;
}