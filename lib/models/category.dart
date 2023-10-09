import 'package:hive/hive.dart';
part 'category.g.dart';


@HiveType(typeId: 1)
enum Category { 
  
  @HiveField(101)
  food, 
  
  @HiveField(102)
  travel, 
  
  
  @HiveField(103)
  leisure, 
  
  @HiveField(104)
  work, 
  
  @HiveField(105)
  stationary }