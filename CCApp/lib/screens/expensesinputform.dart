import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CCApp/providers/expenses.dart';
import 'package:CCApp/screens/homePage.dart';
import 'package:CCApp/providers/reg.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class ExpensesInputForm extends StatefulWidget {
  @override
  _ExpensesInputFormState createState() => _ExpensesInputFormState();
}

class _ExpensesInputFormState extends State<ExpensesInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String fileLoc = '';
  var filePath;
  String remarks;
  String amount;
  String filep = '';
  Map<String, String> _data = {};
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Expense>(context, listen: false)
          .expenseAdd(_data, Provider.of<Reg>(context, listen: false).token);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomePage(
            currentIndex: 2,
          ),
        ),
      );
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error'),
          content: Text('Expense Creation Failed'),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      width: MediaQuery.of(context).size.width * 90 / 100,
      height: (filep != '' && filep != null)
          ? MediaQuery.of(context).size.height * 58 / 100
          : MediaQuery.of(context).size.height * 50 / 100,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 7),
                child: Text(
                  'Add an Expense',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 5, right: 5),
                width: MediaQuery.of(context).size.width * 70 / 100,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == '') {
                      return 'This field is required.';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String text) {
                    remarks = text;
                  },
                  decoration: new InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    hintText: 'Reason for Expenditure',
                    hintStyle: TextStyle(
                      color: Color(0xFFC7C7C7),
                      fontSize: 18,
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(27.5)),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(27.5)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 5, right: 5),
                width: MediaQuery.of(context).size.width * 70 / 100,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == '') {
                      return 'This field is required.';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    amount = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    hintText: 'Amount',
                    hintStyle: TextStyle(
                      color: Color(0xFFC7C7C7),
                      fontSize: 18,
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(27.5)),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(27.5)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (filep != '' && filep != null)
                  ? Container(
                      margin:
                          EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 70 / 100,
                      child: FlatButton(
                        onPressed: () async {
                          (filep != '' && filep != null)
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      elevation: 12,
                                      child: Image.file(File(filep)),
                                    );
                                  })
                              : showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      elevation: 12,
                                      child: Container(
                                          height: 100,
                                          width: 120,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(width: 25),
                                              Icon(
                                                Icons.close,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'No image selected',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                30 /
                                                896),
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "View Selected Image",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontFamily: 'SF Pro Display',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 0),
                height: 50,
                width: 330,
                child: FlatButton(
                  onPressed: () async {
                    filePath = await FilePicker.getFilePath(
                      type: FileType.image,
                    );
                    setState(() {
                      filep = filePath;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF3BE0EB), Color(0xFF1D59A1)]),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              width: 300 / 4,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              child: Text(
                                "Select Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 5),
                height: 50,
                width: 330,
                child: FlatButton(
                  onPressed: () async {
                    await Provider.of<Expense>(context, listen: false)
                        .dataUpload(
                      filePath,
                      remarks,
                      amount,
                      Provider.of<Reg>(context, listen: false).token,
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => HomePage(
                          currentIndex: 2,
                        ),
                      ),
                    );
                    (remarks != null && amount != null)
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 12,
                                child: Container(
                                  height: 105,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Text(
                                          'Expense submitted for review',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: FlatButton(
                                          child: Text(
                                            "OK",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : print("hello");
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFF459AFF),
                        Color(0xFFFF6745),
                        Color(0xFFFF4572)
                      ]),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              width: 300 / 4,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              child: Text(
                                "Add Expense",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
