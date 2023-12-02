part of "./student.dart";

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  StudentController controller = Get.put(StudentController());

  @override
  void initState() {
    controller.loadinit();
    super.initState();
  }

  final _formKeyAddStudent = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MainScaffold(
        type: "default",
        colorBackground: Utility.baseColor2,
        returnOnWillpop: false,
        colorSafeArea: Utility.baseColor2,
        content: Padding(
          padding: EdgeInsets.only(left: Utility.medium, right: Utility.medium),
          child: Column(
            children: [
              SizedBox(
                height: Utility.medium,
              ),
              TextLabel(
                text: controller.usernameLogin.value,
                color: Utility.baseColor1,
                size: Utility.large,
              ),
              SizedBox(
                height: Utility.medium,
              ),
              _tabScreen(),
              SizedBox(
                height: Utility.large,
              ),
              Flexible(
                  child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: MaterialClassicHeader(color: Utility.maincolor1),
                onRefresh: () async {
                  controller.loadinit();
                  controller.refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  controller.refreshController.loadComplete();
                },
                controller: controller.refreshController,
                child: _listDataStudent(),
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ButtonSheetWidget().validasiButtomSheet(
                "Add Student", _formAddEditStudent(), "add", () async {
              if (!_formKeyAddStudent.currentState!.validate()) {
                hideKeyboard(Get.context!);
                return;
              } else {
                controller.addEditStudent(false);
              }
            });
          },
          backgroundColor: Utility.baseColor1,
          child: Icon(
            Iconsax.add_circle5,
            color: Utility.baseColor2,
          ),
        ),
      ),
    );
  }

  Widget _tabScreen() {
    return SizedBox(
      height: 50,
      child: ExpandedView2Row(
          flexLeft: 70,
          flexRight: 30,
          widgetLeft: const SizedBox(),
          widgetRight: Padding(
            padding: EdgeInsets.only(left: Utility.small),
            child: Button1(
              colorBtn: Utility.maincolor1,
              radius: Utility.small,
              colorSideborder: Utility.baseColor1,
              contentButton: Center(
                child: TextLabel(
                  text: "Logout",
                  color: Utility.baseColor1,
                ),
              ),
              onTap: () => ButtonSheetWidget().validasiButtomSheet(
                  "Keluar Halaman",
                  const TextLabel(text: "Yakin keluar halamana ?"),
                  "Keluar",
                  () => controller.logout()),
            ),
          )),
    );
  }

  Widget _listDataStudent() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: controller.listStudent.length,
        itemBuilder: ((context, index) {
          int id = controller.listStudent[index].id;
          String username = controller.listStudent[index].username;
          DateTime birthDate = controller.listStudent[index].birthDate;
          int age = controller.listStudent[index].age;
          bool gender = controller.listStudent[index].gender;
          String address = controller.listStudent[index].address;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Utility.small,
              ),
              CardCustom(
                radiusBorder: Utility.borderStyle1,
                colorBg: Utility.baseColor1,
                widgetCardCustom: Padding(
                  padding: EdgeInsets.all(Utility.small),
                  child: ExpandedView2Row(
                      flexLeft: 90,
                      flexRight: 10,
                      widgetLeft: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLabel(text: username),
                          SizedBox(
                            height: Utility.small,
                          ),
                          TextLabel(text: Utility.dateView(birthDate)),
                          SizedBox(
                            height: Utility.small,
                          ),
                          TextLabel(text: age.toString()),
                          SizedBox(
                            height: Utility.small,
                          ),
                          TextLabel(text: gender == true ? "Male" : "Female"),
                          SizedBox(
                            height: Utility.small,
                          ),
                          TextLabel(text: address),
                          SizedBox(
                            height: Utility.small,
                          ),
                        ],
                      ),
                      widgetRight: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.editDataStudent(
                                  controller.listStudent[index]);
                              ButtonSheetWidget().validasiButtomSheet(
                                  "Edit Student", _formAddEditStudent(), "Edit",
                                  () async {
                                if (!_formKeyAddStudent.currentState!
                                    .validate()) {
                                  hideKeyboard(Get.context!);
                                  return;
                                } else {
                                  controller.addEditStudent(true);
                                }
                              });
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            height: Utility.small,
                          ),
                          InkWell(
                            onTap: () {
                              ButtonSheetWidget().validasiButtomSheet(
                                  "Delete Student",
                                  TextLabel(
                                      text:
                                          "Anda yakin hapus data $username ? "),
                                  "Delete",
                                  () => controller.deleteStudent(id));
                            },
                            child: const Icon(
                              Icons.delete_forever_sharp,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              const Divider(),
            ],
          );
        }));
  }

  Widget _formAddEditStudent() {
    return StatefulBuilder(builder: (context, setState) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKeyAddStudent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextLabel(text: "Username"),
              SizedBox(
                height: Utility.normal,
              ),
              TextFieldMain(
                controller: controller.username.value,
                validator: (value) {
                  return Validator.required(
                      value, "Username tidak boleh kosong");
                },
              ),
              SizedBox(
                height: Utility.normal,
              ),
              const TextLabel(text: "Birth Date"),
              SizedBox(
                height: Utility.normal,
              ),
              TextFieldMain(
                controller: TextEditingController(
                    text: controller.birthDate.value.isEmpty
                        ? ""
                        : Utility.dateView(
                            DateTime.parse(controller.birthDate.value))),
                validator: (value) {
                  return Validator.required(
                      value, "Tanggal tidak boleh kosong");
                },
                readOnly: true,
                onTap: () async {
                  if (controller.birthDate.value.isEmpty) {
                    controller.birthDate.value =
                        Utility.dateUpload(DateTime.now());
                  }
                  DateTime? selectDate = await selectedCalenderDate(
                      Get.context!, DateTime.parse(controller.birthDate.value));
                  if (selectDate != null) {
                    setState(() {
                      controller.birthDate.value =
                          Utility.dateUpload(selectDate);
                      controller.birthDate.refresh();
                      double calculateAge = Utility.calculateYear(selectDate);
                      String decimalPart =
                          calculateAge.toString().split('.')[1];
                      int convertAge = calculateAge.toInt();
                      controller.age.value =
                          int.parse(decimalPart.substring(0, 2)) > 90
                              ? convertAge + 1
                              : convertAge;
                      controller.age.refresh();
                    });
                  }
                },
              ),
              SizedBox(
                height: Utility.normal,
              ),
              const TextLabel(text: "Age"),
              SizedBox(
                height: Utility.normal,
              ),
              TextFieldMain(
                controller: TextEditingController(
                    text: controller.age.value.toString()),
                validator: (value) {
                  return Validator.required(value, "Age tidak boleh kosong");
                },
              ),
              SizedBox(
                height: Utility.normal,
              ),
              const TextLabel(text: "Gender"),
              SizedBox(
                height: Utility.normal,
              ),
              Obx(
                () => DropdownButtom(
                  option: controller.optionGender,
                  selectedOption: controller.genderSelected.value,
                  onChange: (newValue) {
                    if (newValue == "Male") {
                      controller.gender.value = true;
                      controller.genderSelected.value = newValue;
                      controller.genderSelected.refresh();
                    } else {
                      controller.gender.value = false;
                      controller.genderSelected.value = newValue;
                      controller.genderSelected.refresh();
                    }
                    print("hasil gender ${controller.gender.value}");
                  },
                ),
              ),
              SizedBox(
                height: Utility.normal,
              ),
              const TextLabel(text: "Address"),
              SizedBox(
                height: Utility.normal,
              ),
              TextFieldMain(
                controller: controller.address.value,
                validator: (value) {
                  return Validator.required(
                      value, "Address tidak boleh kosong");
                },
              ),
              SizedBox(
                height: Utility.normal,
              ),
            ],
          ),
        ),
      );
    });
  }
}
