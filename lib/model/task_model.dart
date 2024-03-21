class TaskModel {
  static const String collectionName= 'Tasks';
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  TaskModel(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  TaskModel.fromJason(Map<String,dynamic> data):this(
    id: data['id'],
    title: data['title'],
    description:data['description'] ,
    dateTime:DateTime.fromMillisecondsSinceEpoch(data['dateTime']) ,
    isDone: data['isDone']
  );

  Map<String,dynamic> toJason(){
    return {
      'id' : id as String,
      'title':title as String,
      'description':description as String,
      'dateTime':dateTime?.millisecondsSinceEpoch as int,
      'isDone':isDone as bool
    };
  }
}
