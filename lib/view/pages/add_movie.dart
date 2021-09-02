import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/auth_controller.dart';
import 'package:movie_app/controller/file_picker_controller.dart';
import 'package:movie_app/controller/movie_controller.dart';
import 'package:movie_app/model/movie_model.dart';

class AddMovie extends StatelessWidget {
  AddMovie({Key? key}) : super(key: key);

  final _fromKey = GlobalKey<FormState>();
  final _movieName = TextEditingController();
  final _director = TextEditingController();
  final FilePickerController _filePickerController =
      Get.put(FilePickerController());
  final MovieController _movieController = Get.put(MovieController());
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Add Movie"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Form(
                child: Column(
                  children: [
                    buildTextField("Enter movie name", _movieName),
                    buildTextField("Enter director name", _director),
                  ],
                ),
                key: _fromKey,
              ),
              Row(
                children: [
                  Obx(() => SizedBox(
                        width: 200,
                        child: Text(
                          _filePickerController.filename.value,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                  IconButton(
                    onPressed: () async {
                      await _filePickerController.pickImage();
                    },
                    icon: const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Colors.blue,
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_authController.googleuse.value != null) {
                        if (_fromKey.currentState!.validate()) {
                          if (_filePickerController.file.value != null) {
                            Get.defaultDialog(
                                content: const CircularProgressIndicator(),
                                title: "Loading");
                            await _movieController.addMovie(
                                MovieModel("", _movieName.text, _director.text,
                                    "", ""),
                                _filePickerController.file.value!);
                            Get.back();
                            Get.offNamed('/home');
                          } else {
                            Get.snackbar(
                                "No Image Selected", "Please select a Image",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.white,
                                colorText: Colors.black);
                          }
                        }
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(20),
                                height: 300,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "Please sign in to continue",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    ElevatedButton(
                                        style: const ButtonStyle().copyWith(
                                            minimumSize:
                                                MaterialStateProperty.all<Size>(
                                                    const Size(
                                                        double.infinity, 40)),
                                            elevation: MaterialStateProperty.all<double>(
                                                30),
                                            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                            backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    const Color(0xff2a2d3e))),
                                        onPressed: () async {
                                          Get.defaultDialog(
                                              content:
                                                  const CircularProgressIndicator(),
                                              title: "Loading");
                                          await _authController.googleSignIn();
                                          Get.back();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Image(
                                                    image: AssetImage(
                                                        'images/google_logo.png'))),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text("Sign in with google"),
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            });
                      }
                    },
                    child: const Text(
                      "Add Movie",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: const ButtonStyle().copyWith(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity, 40)),
                      elevation: MaterialStateProperty.all<double>(30),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please ' + label;
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }
}
