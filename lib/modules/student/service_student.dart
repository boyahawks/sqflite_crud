part of "./student.dart";

class StudentService {
  static Future<void> createTable(Database db) async {
    try {
      await db.execute(
          'CREATE TABLE Student (id INTEGER PRIMARY KEY, username TEXT, birthdate TEXT, age INTEGER, gender TEXT, address TEXT)');
    } catch (e) {
      print("error create db : $e");
      UtilsAlert.showToast("error create database");
    }
  }

  static Future<List<Map<String, dynamic>>> checkTableOnDatabase(
      Database db) async {
    return await db
        .rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
  }

  static Future<List<Map>> selectAllStudent(db) async {
    return await db.rawQuery('SELECT * FROM Student');
  }

  static Future<bool> addRow(
      {required Database db,
      required int id,
      required String username,
      required String tanggalLahir,
      required int age,
      required bool gender,
      required String address,
      required}) async {
    bool result = false;
    try {
      await db.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO Student(id,username,birthdate,age,gender,address) VALUES($id,"$username","$tanggalLahir",$age,"$gender","$address")');
      });
      result = true;
    } catch (e) {
      print("error add student : $e");
      result = false;
    }
    return result;
  }

  static Future<bool> editRow(
      {required Database db,
      required int id,
      required String username,
      required String tanggalLahir,
      required int age,
      required bool gender,
      required String address,
      required}) async {
    bool result = false;
    try {
      await db.rawUpdate(
          'UPDATE Student SET username = ?, birthdate = ?, age = ?, gender = ?, address = ? WHERE id = ?',
          ['$username', '$tanggalLahir', age, '$gender', '$address', '$id']);
      result = true;
    } catch (e) {
      print("error edit student : $e");
      result = false;
    }
    return result;
  }

  static Future<bool> deleteRow({required Database db, required int id}) async {
    bool result = false;
    try {
      await db.rawDelete('DELETE FROM Student WHERE id = ?', [id]);
      result = true;
    } catch (e) {
      print("error edit student : $e");
      result = false;
    }
    return result;
  }
}
