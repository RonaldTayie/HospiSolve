import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospisolve/providers/PetientProvider.dart';
import 'package:intl/intl.dart';
import '../providers/AuthServiceProvider.dart';
import '../widgets/AuthViewTextField.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _authProvider = AuthServiceProvider();
  final _patientProvider = PatientProvider();

  // Check if passwords Match
  bool passwordMatch = false;

  // Form Password
  String _password = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/undraw_books_re_8gea.svg',
                  semanticsLabel: "",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AuthViewTextField(
                      label: "First name",
                      icon: const Icon(Icons.account_circle_outlined),
                      change: (e) => {_patientProvider.setFirstName(e)},
                      type: TextInputType.text,
                    ),
                    AuthViewTextField(
                      label: "Last name",
                      icon: const Icon(Icons.group),
                      change: (e) => {_patientProvider.setLastName(e)},
                      type: TextInputType.text,
                    ),
                    AuthViewTextField(
                      label: "Email address",
                      icon: const Icon(Icons.email_outlined),
                      change: (e) => {_patientProvider.setEmail(e)},
                      type: TextInputType.text,
                    ),
                    AuthViewTextField(
                      label: "Phone number",
                      icon: const Icon(Icons.dialpad_outlined),
                      change: (e) => {_patientProvider.setContactNumber(e)},
                      type: TextInputType.phone,
                    ),
                    AuthViewTextField(
                      label: "ID number",
                      icon: const Icon(Icons.badge_outlined),
                      change: (e) => {_patientProvider.setPatientId(e)},
                      type: TextInputType.number,
                    ),
                    Container(
                      width: double.infinity,
                      height: 90,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width : MediaQuery.of(context).size.width * 0.75,
                            height: 90,
                            child: AuthViewTextField(
                              label: _patientProvider.dateOfBirth.isAtSameMomentAs(DateTime.now())?"Date Of Birth": DateFormat('yyyy-MM-dd').format(_patientProvider.dateOfBirth),
                              icon: const Icon(Icons.calendar_month_outlined),
                              change: (e) => {_patientProvider.setDateOfBirth(e)},
                              type: TextInputType.datetime,
                              isEnabled: false,
                            ),
                          ),
                          IconButton(
                            color: const Color.fromRGBO(217, 217, 217, 0.5),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => DatePickerDialog(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                  confirmText: "Confirm",
                                  keyboardType: TextInputType.datetime,
                                ),
                              ).then((value) => {
                                if(value!=null) {
                                  _patientProvider.setDateOfBirth(DateTime.parse(value))
                                }
                              }
                              );
                            },
                            icon:const Icon(Icons.edit_calendar,size: 35,color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    AuthViewTextField(
                      label: "Address",
                      icon: const Icon(Icons.map_outlined),
                      change: (e) =>
                          {_patientProvider.setResidentialAddress(e)},
                      type: TextInputType.text,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.white70,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    AuthViewTextField(
                      label: "Password",
                      icon: const Icon(Icons.lock),
                      change: (e) {
                        setState(() {
                          _password = e;
                        });
                      },
                      type: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    AuthViewTextField(
                      label: "Confirm Password",
                      icon: const Icon(Icons.lock_clock_outlined),
                      change: (e) => {_authProvider.setPassword(e)},
                      type: TextInputType.text,
                      isPassword: true,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: MaterialButton(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 25, color: Theme.of(context).primaryColor),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                onPressed: () {
                  _authProvider.Signup(
                          Password: _password,
                          patient: _patientProvider.getPatient())
                      .then((value) {
                    print(value);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
