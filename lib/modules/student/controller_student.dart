part of "./student.dart";

class StudentController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  RxList<StudentModel> listStudent = <StudentModel>[].obs;

  RxString usernameLogin = "".obs;
  RxInt lastId = 0.obs;

  // FORM ADD STUDENT
  RxInt idEdit = 0.obs;
  var username = TextEditingController().obs;
  RxString birthDate = "".obs;
  RxInt age = 0.obs;
  RxBool gender = true.obs;
  var address = TextEditingController().obs;
  RxString genderSelected = "Male".obs;
  List<String> optionGender = ['Male', 'Female'];

  Future<void> loadinit() async {
    usernameLogin.value = AppData.usernameLogin;
    usernameLogin.refresh();
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'student.db');
    Database db = await openDatabase('student.db');
    List<Map<String, dynamic>> tables =
        await StudentService.checkTableOnDatabase(db);
    ;
    if (tables.isEmpty) {
      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await StudentService.createTable(db);
      });
      getAllStudent(database);
    } else {
      var nameDb =
          tables.firstWhereOrNull((element) => element["name"] == "Student");
      if (nameDb == null) {
        await StudentService.createTable(db);
      }
      getAllStudent(db);
    }
  }

  Future<void> getAllStudent(Database database) async {
    // Get the records
    List<Map> getDataStudent = await StudentService.selectAllStudent(database);
    if (getDataStudent.isNotEmpty) {
      List<StudentModel> dataStudent = [];
      for (var element in getDataStudent) {
        dataStudent.add(StudentModel.fromMap(element));
      }
      listStudent.value = dataStudent;
      listStudent.refresh();
      lastId.value = getDataStudent.last["id"];
      lastId.refresh();
    }
  }

  Future<void> addEditStudent(bool type) async {
    var db = await openDatabase('student.db');
    if (db.isOpen) {
      if (type) {
        bool prosesEdit = await StudentService.editRow(
            db: db,
            id: idEdit.value,
            username: username.value.text,
            tanggalLahir: Utility.dateUpload(DateTime.parse(birthDate.value)),
            age: age.value,
            gender: gender.value,
            address: address.value.text);
        if (prosesEdit) {
          clearFormAddStudent();
          getAllStudent(db);
          UtilsAlert.showToast("Success edit Student");
        } else {
          UtilsAlert.showToast("Failed edit Student");
        }
      } else {
        bool prosesInsert = await StudentService.addRow(
            db: db,
            id: lastId.value + 1,
            username: username.value.text,
            tanggalLahir: Utility.dateUpload(DateTime.parse(birthDate.value)),
            age: age.value,
            gender: gender.value,
            address: address.value.text);
        if (prosesInsert) {
          clearFormAddStudent();
          getAllStudent(db);
          UtilsAlert.showToast("Success add Student");
        } else {
          UtilsAlert.showToast("Failed add Student");
        }
      }
    }
  }

  void editDataStudent(StudentModel dataStudent) {
    idEdit.value = dataStudent.id;
    idEdit.refresh();
    username.value.text = dataStudent.username;
    username.refresh();
    birthDate.value = Utility.dateUpload(dataStudent.birthDate);
    birthDate.refresh();
    age.value = dataStudent.age;
    age.refresh();
    gender.value = dataStudent.gender;
    gender.refresh();
    address.value.text = dataStudent.address;
    address.refresh();
  }

  Future<void> deleteStudent(int idStudent) async {
    var db = await openDatabase('student.db');
    if (db.isOpen) {
      bool prosesHapus = await StudentService.deleteRow(db: db, id: idStudent);
      if (prosesHapus) {
        getAllStudent(db);
        UtilsAlert.showToast("Success delete Student");
      }
    }
  }

  void logout() {
    AppData.usernameLogin = "";
    Routes.routeOff(type: "splash");
  }

  void clearFormAddStudent() {
    username.value.clear();
    username.refresh();
    birthDate.value = "";
    birthDate.refresh();
    age.value = 0;
    age.refresh();
    gender.value = false;
    gender.refresh();
    address.value.clear();
    address.refresh();
  }
}
