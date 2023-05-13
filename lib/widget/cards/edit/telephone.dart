import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plain_launcher/widget/cards/edit/_background_color.dart';
import '../../../const/colors.dart';
import '../../../modal/card.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

import '_bottom_actions.dart';

class EditTelephone extends StatefulWidget {
  final TelephoneCard? telephoneCard;
  const EditTelephone({super.key, this.telephoneCard});

  @override
  State<EditTelephone> createState() => _EditTelephoneState();
}

class _EditTelephoneState extends State<EditTelephone> {
  TelephoneCard? _telephoneCard;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  bool _isNameError = false;
  bool _isTelError = false;
  String _temName = '';
  bool _isEditing = false;
  final ImagePicker picker = ImagePicker();

  void setIsNameError(bool value) {
    setState(() {
      _isNameError = value;
    });
  }

  void setIsTelError(bool value) {
    setState(() {
      _isTelError = value;
    });
  }

  void setTemName(String value) {
    setState(() {
      _temName = value;
    });
  }

  void setTelephoneCard(TelephoneCard value) {
    setState(() {
      _telephoneCard = value;
    });
  }

  @override
  void initState() {
    super.initState();

    _isEditing = widget.telephoneCard != null;
    _temName = _isEditing ? widget.telephoneCard!.name : '';

    _telephoneCard = TelephoneCard(
        id: _isEditing
            ? widget.telephoneCard!.id
            : DateTime.now().millisecondsSinceEpoch,
        name: _isEditing ? widget.telephoneCard!.name : '',
        number: _isEditing ? widget.telephoneCard!.number : null,
        avatar: _isEditing ? widget.telephoneCard!.avatar : null,
        avatarBackgroundColor: backgroundColorList[
            Random().nextInt(backgroundColorList.length - 2)],
        backgroundColor: cardColorList[Random().nextInt(cardColorList.length)]);
  }

  Future<String> getAvatarDirPath() async {
    final String docPath = (await getApplicationDocumentsDirectory()).path;
    final String avatarPath = '$docPath/avatar';
    Directory(avatarPath).createSync(recursive: true);

    return avatarPath;
  }

  Future<void> pickAvatar() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    final String imageName = pickedImage.path.split('/').last;
    final String savePath = '${await getAvatarDirPath()}/$imageName';
    await pickedImage.saveTo(savePath);

    setTelephoneCard(_telephoneCard!.copyWith(avatar: savePath));
  }

  Future<void> pickContact() async {
    FullContact? contact;
    try {
      contact = await FlutterContactPicker.pickFullContact();
      // ignore: empty_catches
    } catch (e) {}

    if (contact == null) return;

    final String name = contact.name?.nickName ?? '';
    final List<PhoneNumber> phones = contact.phones;
    String numberStr = phones.isNotEmpty
        ? contact.phones.first.number!.replaceAll(RegExp(r'\D'), '')
        : '';
    final int? number = numberStr.isEmpty ? null : int.parse(numberStr);
    final Uint8List? avatar = contact.photo?.bytes;

    String savePath = '';
    if (avatar != null) {
      savePath = '${await getAvatarDirPath()}/${DateTime.now()}.png';
      await File(savePath).writeAsBytes(avatar);
    }

    setTelephoneCard(
        _telephoneCard!.copyWith(name: name, number: number, avatar: savePath));

    _nameController.text = _telephoneCard?.name ?? '';
    _telController.text = _telephoneCard?.number.toString() ?? '';
  }

  Future<void> save() async {
    if (_nameController.text.isEmpty) {
      setIsNameError(true);
    }
    if (_telController.text.isEmpty) {
      setIsTelError(true);
    }

    if (!_isNameError && !_isTelError) {
      if (_isEditing) {
        // TODO: update
      } else {
        // TODO: add
      }
    }
  }

  Future<void> delete() async {
    // delete
  }

  @override
  Widget build(BuildContext context) {
    final double basicFontSize =
        Theme.of(context).textTheme.bodyMedium!.fontSize!;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_box,
                      size: basicFontSize * 1.2,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 6),
                    Text('名称:', style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Stack(
                      children: [
                        TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: basicFontSize),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              errorText: _isNameError ? '' : null,
                              errorStyle: const TextStyle(height: 0)),
                          onTap: () => setIsNameError(false),
                          onChanged: (value) => setTemName(value),
                        ),
                        if (_isNameError)
                          Positioned(
                            top: 14,
                            right: 10,
                            child: Text('必填',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: basicFontSize * 0.5)),
                          )
                      ],
                    ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: basicFontSize * 1.2,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text('电话:', style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Stack(
                      children: [
                        TextField(
                          controller: _telController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: basicFontSize),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              errorText: _isTelError ? '' : null,
                              errorStyle: const TextStyle(height: 0)),
                          onTap: () => setIsTelError(false),
                        ),
                        if (_isTelError)
                          Positioned(
                            top: 14,
                            right: 10,
                            child: Text('必填',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: basicFontSize * 0.5)),
                          )
                      ],
                    ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () => pickContact(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            maximumSize: const Size.fromWidth(double.infinity),
                          ),
                          child: Text('从联系人中选择',
                              style: TextStyle(fontSize: basicFontSize))),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.mood,
                      size: basicFontSize * 1.2,
                      color: Colors.purple,
                    ),
                    const SizedBox(width: 6),
                    Text('头像:', style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () => pickAvatar(),
                      borderRadius: BorderRadius.circular(50),
                      child: Ink(
                        width: basicFontSize * 2.5,
                        height: basicFontSize * 2.5,
                        decoration: BoxDecoration(
                          color: _telephoneCard?.avatarBackgroundColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: _telephoneCard?.avatar == null
                            ? Center(
                                child: Text(
                                    _temName == ''
                                        ? ''
                                        : _temName.substring(
                                            _temName.length - 2,
                                            _temName.length),
                                    style: TextStyle(fontSize: basicFontSize)),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    FileImage(File(_telephoneCard!.avatar!))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text('(点击圆形头像可修改)',
                            style: TextStyle(
                                fontSize: basicFontSize * 0.8,
                                color: Colors.grey[500]))),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: BackgroundColor(
                      showIcon: true,
                      color: _telephoneCard!.backgroundColor,
                      onChanged: (Color value) => setTelephoneCard(
                          _telephoneCard!.copyWith(backgroundColor: value))),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          BottomActions(
            secondaryTitle: _isEditing ? '删除' : '取消',
            onPrimaryTaped: () => save(),
            onSecondaryTaped: () {
              if (_isEditing) {
                delete();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
