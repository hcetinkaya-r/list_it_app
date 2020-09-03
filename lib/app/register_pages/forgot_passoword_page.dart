import 'package:flutter/material.dart';
import 'package:list_it_app/common_widget/app_button.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/common_widget/page_title.dart';
import 'package:list_it_app/view_models/user_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ForgotPasswordPage extends StatelessWidget {
  String _email;
  final _formKey = GlobalKey<FormState>();

  void _formSubmit(BuildContext context) async {
    _formKey.currentState.save();
    debugPrint("email: " + _email);
    final _userModel = Provider.of<UserModel>(context, listen: false);
    await _userModel.sendForgotPassword(_email);
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: MediaQuery.of(context).size.height / 2.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PageTitle(
                      title: "Forgot Password",
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                      Text(
                        "Enter your address below and we'll send you a new secure link to reset your password:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height:10),

                      Form(
                        key: _formKey,
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorText: _userModel.emailErrorMessage != null
                                  ? _userModel.emailErrorMessage
                                  : null,
                              hintText: "e-mail",
                              labelText: "E-mail",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onSaved: (String enteredEmail) {
                              _email = enteredEmail;
                            }),
                      ),
                    ],)
                  ],
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                child: PageAvatar(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppButton(
              buttonText: "Send",
              textColor: Colors.white,
              buttonColor: Theme.of(context).primaryColor,
              onPressed: () => _formSubmit(context),
            ),
          ),
        ],
      ),
    );
  }
}
