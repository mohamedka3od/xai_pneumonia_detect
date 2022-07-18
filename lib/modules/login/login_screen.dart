import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/patients.dart';
import 'package:xai_pneumonia_detect/modules/login/cubit/cubit.dart';
import 'package:xai_pneumonia_detect/modules/login/cubit/states.dart';
import '../../network/local/cache_helper.dart';
import '../../layout/background.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/google_button.dart';
import '../../shared/components/line.dart';
import '../app_screens/module/page/profile.dart';
import '../register/register_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
    create: (BuildContext context) => LoginCubit(),
    child: BlocConsumer<LoginCubit,LoginStates>(
      listener: (BuildContext context, state) {
        if(state is LoginErrorState ){
          showToast(
              text: state.error.toString().replaceRange(0, 14, '').split(']')[1],
              state: ToastStates.ERROR ,
          );
        }
        else if(state is GoogleLoginErrorState){
          showToast(
            text: state.error.toString().replaceRange(0, 14, '').split(']')[1],
            state: ToastStates.ERROR ,
          );
        }
        if (state is LoginSuccessState)
        {
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
            navigateAndFinish(context,  PatientPage());
            uId = CacheHelper.getData(key: 'uId');
          });
        }
        else if (state is GoogleLoginSuccessState)
        {
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value){

            navigateAndFinish(context,  PatientPage());
            uId = CacheHelper.getData(key: 'uId');
          });
        }
        },
      builder: (BuildContext context, Object? state)
      {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;
        return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                  onPressed:(){
                    Navigator.pop(context);
                  } ,
                ),

              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    backGround(
                    context,
                    widget: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height/14,
                          ),
                          Container(
                            width: width/4.5,
                            height: width/4.5,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/user_icon.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Welcome back!",
                            style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            "Login to your account",
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                          SizedBox(
                            height: (height)/14,
                          ),
                          defaultFormField(
                            controller: emailController,
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            type: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: (height)/45,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            prefix: Icons.lock_outline,
                            suffix: LoginCubit.get(context).suffix,
                            suffixPressed: () {
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            onSubmit: (value){
                              if (formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            isPassword: LoginCubit.get(context).isPassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: (height)/16,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                            builder: (BuildContext context) => defaultButton(
                              width: MediaQuery.of(context).size.width/2,
                              function: () {

                                if (formKey.currentState!.validate()){
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              text: 'Login',
                            ),

                          ),
                          SizedBox(
                            height: (height)/24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: hDivider(context)),
                              const Text(
                                'OR',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Expanded(child: hDivider(context)),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                    )
                  ),
                    SizedBox(
                      height: (height)/24,
                    ),
                    ConditionalBuilder(
                      condition: state is !GoogleLoginLoadingState,
                      fallback:(context)=> const Center(child: CircularProgressIndicator(),),
                      builder: (context)=>googleButton(
                          context,
                          text:'Sign in with Google',
                        onPressed: (){
                          LoginCubit.get(context).signInWithGoogle();
                        }
                      ),
                    ),
                    SizedBox(
                      height: (height)/40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        defaultTextButton(
                            function: () {
                              navigateTo(context,  RegisterScreen());
                            },
                            text: 'register'),
                      ],
                    ),
                  ]
                ),
              ),
            );
      },

    ),
      );
  }
}
