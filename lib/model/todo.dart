class Todo {
  Todo(
      {required this.id,
      required this.todo,
      required this.completed,
      required this.userId}); //tanımladığım değerleri bir constructur'a almam gerekiyor.

  int? id;
  String? todo;
  bool? completed;
  int? userId;
  //çekeceğimiz api'da olan şeyler.
  //her zaman gelecek olan değerler dolu olmayabilir.
  //o yüzden nullable hale getirmeliyiz.
//bunu da yanına ? koyarak yaparız.
//özellikle kendi yazmadığımız api'lerda mutlaka eklemeliyiz.

//From Json: bizim api'dan çektiğimiz veriler json formatında onu dnüştürmeliyiz.
  Todo.fromJson(Map<String, dynamic> json) {
//keyleri string value'ları dynamic yani karışık olan bir map.
    id = json["id"];
//id değişkenimi api'dan gelen id değerine eşitledim.
    todo = json["todo"];
    completed = json["completed"];
    userId = json["userId"];
  }

//to Json: eğer biz api'ye veri göndermek istersek de json formatında göndermeliyiz.
  Map<String, dynamic> toJson() {
    //Map<String, dynamic> return edilecek değişken türü
    //toJson metot ismi
    final Map<String, dynamic> data = {};
    //map'i initalize işlemi
    data["id"] = id;
    data["todo"] = todo;
    data["completed"] = completed;
    data["userId"] = userId;

    return data;
  }
}
//bunu elle yapmak yerine json to dart yazıp 
//api'daki verilerimizi girsek bu class'ı hazır halde bulabilirdik.