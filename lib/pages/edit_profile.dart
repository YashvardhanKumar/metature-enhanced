import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metature2/change%20notifiers/edit_profile_notifier.dart';
import 'package:metature2/components/button/Custombutton.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:metature2/constants.dart';
import 'package:metature2/models/profile_model.dart';
import 'package:metature2/pages/bottom%20navigation%20routes/Feed.dart';
import 'package:provider/provider.dart';

import '../components/progress_circle.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Check your internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    initConnectivity();
    FirebaseAuth.instance.currentUser?.reload();
    super.initState();
    // TODO: implement initState
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<EditProfileNotifier>(context).discard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileNotifier>(
        builder: (context, editProfile, child) {
      return WillPopScope(
        onWillPop: () async {
          bool willPop = false;

          if (editProfile.isChanged) {
            showDialog(
              context: context,
              builder: (context) => DiscardChangesDialogBox(
                onPressed: () {
                  Navigator.pop(context);
                  willPop = true;
                  setState(() {});
                },
                content: 'Are you sure you want to discard changes?',
                title: 'Discard Changes?',
              ),
            );
          } else {
            willPop = true;
          }
          return willPop;
        },
        child: Builder(builder: (context) {
          editProfile.getDocument();
          if (editProfile.isLoaded) {
            if (_connectionStatus == ConnectivityResult.none) {
              return const Center(
                child: NormalText('Check your internet connection'),
              );
            }
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    if (editProfile.isChanged) {
                      showDialog(
                        context: context,
                        builder: (context) => DiscardChangesDialogBox(
                          content: 'Are you sure you want to discard changes?',
                          title: 'Discard Changes?',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                title: const NormalText('Edit Profile'),
              ),
              body: Form(
                key: editProfile.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            height: 120,
                            width: 120,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              image: (editProfile.profileUrl != null)
                                  ? DecorationImage(
                                      image:
                                          NetworkImage(editProfile.profileUrl!),
                                      fit: BoxFit.fill,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage('images/User.png'),
                                      fit: BoxFit.fill,
                                    ),
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: editProfile.nameController,
                          maxLength: 30,
                          onChanged: (value) => editProfile.setName(value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name cannot be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Edit name',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: editProfile.usernameController,
                          maxLength: 20,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username cannot be empty';
                            } else if (editProfile.usedUsername != null &&
                                editProfile.usedUsername!) {
                              editProfile.setUsedUsername(false);
                              return 'Username already used';
                            }
                            return null;
                          },
                          onChanged: (value) => editProfile.setUsername(value),
                          decoration: const InputDecoration(
                            labelText: 'Edit username',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: editProfile.websiteController,
                          maxLength: 20,
                          onChanged: (value) => editProfile.setWebsite(value),
                          decoration: const InputDecoration(
                            labelText: 'Edit website',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: editProfile.bioController,
                          maxLength: 150,
                          maxLines: 3,
                          minLines: 1,
                          onChanged: (value) => editProfile.setBio(value),
                          decoration: const InputDecoration(
                            labelText: 'Edit bio',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        child: const NormalText(
                          'Save Changes',
                          color: kPrimaryThemeColor1,
                        ),
                        onPressed: (!editProfile.isChanged)
                            ? null
                            : () async {
                                editProfile.isUsedUsername();
                                if (editProfile.formKey.currentState!
                                        .validate() &&
                                    editProfile.usedUsername != null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        DiscardChangesDialogBox(
                                      onPressed: () {
                                        editProfile.updateDocument();
                                        Navigator.pop(context);
                                      },
                                      title: 'Save Changes?',
                                      content:
                                          'Are you sure you want to save changes?',
                                    ),
                                  );
                                }
                              },
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return const ProgressCircle();
        }),
      );
    });
  }
}

class DiscardChangesDialogBox extends StatelessWidget {
  const DiscardChangesDialogBox({
    super.key,
    required this.onPressed,
    required this.title,
    required this.content,
  });
  final VoidCallback onPressed;
  final String title, content;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
            child: const NormalText(
              'Yes',
            ),
            onPressed: onPressed),
        CupertinoDialogAction(
          child: const NormalText(
            'No',
            color: kSecondaryThemeColor3,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
