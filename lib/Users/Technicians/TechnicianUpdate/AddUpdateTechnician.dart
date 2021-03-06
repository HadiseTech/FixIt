import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_project/Features/User/Bloc/User_bloc.dart';
import 'package:flutter_group_project/Features/User/Bloc/User_event.dart';
import 'package:flutter_group_project/Features/User/Model/User.dart';
import 'package:flutter_group_project/Users/Admin/UserManagement/User_main_screen.dart';
import 'package:flutter_group_project/Users/Common/ScreenRoute.dart';

import '../../../ScreenRoute.dart';
class AddUpdateTechnician extends StatefulWidget {//Update Page for the Technician, only updates
  static const routeName = 'technicianAddUpdate';
  final UserArgument args;

  AddUpdateTechnician({this.args});
  @override
  _AddUpdateTechnicianState createState() => _AddUpdateTechnicianState();
}

class _AddUpdateTechnicianState extends State<AddUpdateTechnician> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _user = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('${widget.args.edit ? "Edit Profile" : "Add New Course"}'),
        title: Text("Edit profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  initialValue: widget.args.edit ? widget.args.user.Email : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },

                  decoration: InputDecoration(labelText: 'email'),
                  onSaved: (value) {
                    setState(() {
                      this._user["email"] = value;
                    });
                  }),
              TextFormField(
                  initialValue:
                  widget.args.edit ? widget.args.user.FullName : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'fName'),
                  onSaved: (value) {
                    this._user["fName"] = value;
                  }),
              TextFormField(
                  initialValue: widget.args.edit
                      ? widget.args.user.Phone
                      : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Phone'),
                  onSaved: (value) {
                    setState(() {
                      this._user["phone"] = value;
                    });
                  }),
              TextFormField(
                  initialValue: widget.args.edit
                      ? widget.args.user.Password
                      : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'password'),
                  onSaved: (value) {
                    setState(() {
                      this._user["password"] = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final UserEvent event =
                      UserUpdate(

                        User(
                          Email: this._user["email"],
                          FullName: this._user["fName"],
                          Phone: this._user["phone"],
                          Password: this._user["password"],
                          Picture: 'Assets/assets/fixit.png',
                          Role: this._user["role"],
                        ),
                      );

                      BlocProvider.of<UserBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          CategoryMainScreen.routeName, (route) => false);
                    }
                  },
                  label: Text('SAVE'),
                  icon: Icon(Icons.save),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
