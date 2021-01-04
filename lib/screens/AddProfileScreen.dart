import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/UploadDialog.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/PictureContainer.dart';
import '../services/UserInfoProvider.dart';

class AddProfileScreen extends StatefulWidget {
  @override
  _AddProfileScreenState createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final _nameController = TextEditingController();

  void _openUploadDialogModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) => uploadDialog(
        context: context,
        notifyChanges: () => {setState(() {})},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please add your Info',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 20),
            pictureContainer(
              context: context,
              imageUrl: UserInfoProvider.currentImageUrl,
              onPress: _openUploadDialogModal,
            ),
            SizedBox(height: 20),
            CustomTextField(
              icon: LineIcons.user,
              labelText: "Your Name",
              controller: _nameController,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 60,
                icon: Icon(
                  LineIcons.arrow_circle_o_right,
                ),
                onPressed: () => UserInfoProvider.uploadUserInfo(
                  context: context,
                  name: _nameController.text,
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
