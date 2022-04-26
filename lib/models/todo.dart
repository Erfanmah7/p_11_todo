import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class todo{

  @HiveField(0)
  int priority=1;

  @HiveField(1)
  String text='';

todo({required this.text,required this.priority});


}