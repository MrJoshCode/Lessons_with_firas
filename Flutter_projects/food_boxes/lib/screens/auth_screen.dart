import 'package:flutter/material.dart';
import 'package:food_boxes/screens/home_screen.dart';
import 'package:food_boxes/screens/reg_screen.dart';
import 'package:food_boxes/screens/reset_pw_screen.dart';
import 'package:food_boxes/utility/size_config.dart';
import 'package:food_boxes/widgets/custom_txt_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = "auth";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    if (!SizeConfig.initialized) SizeConfig().int(context);
    super.didChangeDependencies();
  }

  void _submitFormData() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        width: SizeConfig.safeWidth,
        height: SizeConfig.safeHeight,
        padding: EdgeInsets.only(
          top: SizeConfig.safeHeight * 0.1,
          left: SizeConfig.safeWidth * 0.1,
          right: SizeConfig.safeWidth * 0.1,
          bottom: SizeConfig.safeHeight * 0.01,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Please sign in to proceed",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: SizeConfig.safeHeight * 0.05,
              ),
              CustomTxtFormField(
                validator: (value) {
                  final email = _emailController.text;
                  if (email.isEmpty) return "Please enter your email.";
                  return null;
                },
                prefixIconWidget: Icon(Icons.email),
                controller: _emailController,
                label: "Email",
              ),
              SizedBox(
                height: SizeConfig.safeHeight * 0.01,
              ),
              CustomTxtFormField(
                validator: (value) {
                  final password = _passwordController.text;
                  if (password.isEmpty) return "Please enter your password.";
                  return null;
                },
                prefixIconWidget: Icon(Icons.lock),
                controller: _passwordController,
                obscureText: true,
                label: "Password",
              ),
              Container(
                padding: EdgeInsets.only(top: SizeConfig.scaledHeight(1)),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _submitFormData,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Login"),
                      Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ResetPwScreen.routeName);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: SizeConfig.safeWidth,
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New here?",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegScreen.routeName);
                    },
                    child: Text("Create an Account"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
