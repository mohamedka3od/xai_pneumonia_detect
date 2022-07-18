import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xai_pneumonia_detect/modules/register/cubit/states.dart';
import '../../network/local/cache_helper.dart';
import '../../layout/background.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/google_button.dart';
import '../../shared/components/line.dart';
import '../app_screens/module/page/profile.dart';
import '../register/cubit/cubit.dart';
class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener:(context ,state) {
          if(state is RegisterErrorState ){
            showToast(
              text: state.error.toString().replaceRange(0, 14, '').split(']')[1],
              state: ToastStates.ERROR ,
            );
          }
          else if(state is GoogleRegisterErrorState){
            showToast(
              text: state.error.toString().replaceRange(0, 14, '').split(']')[1],
              state: ToastStates.ERROR ,
            );
          }
          if(state is CreateUserSuccessState)
          {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              navigateAndFinish(context,  MainScreen());
              uId = CacheHelper.getData(key: 'uId');
            });
          }
          else if (state is GoogleRegisterSuccessState)
          {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              navigateAndFinish(context,  MainScreen());
              uId = CacheHelper.getData(key: 'uId');
            });
          }

        }  ,
        builder: (context, state) {
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
                children: [
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
                            SizedBox(
                              height: height/20,
                            ),
                            defaultFormField(
                              controller: nameController,
                              prefix: Icons.person,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your name';
                                }
                              },
                              label: 'User Name',
                              type: TextInputType.name,
                            ),
                            SizedBox(
                              height: (height)/38,
                            ),
                            defaultFormField(
                              controller: emailController,
                              prefix: Icons.email_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your email address';
                                }
                              },
                              label: 'Email Address',
                              type: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: (height)/38,
                            ),
                            defaultFormField(
                              controller: passwordController,
                              prefix: Icons.lock_outline,
                              suffix: RegisterCubit.get(context).suffix,
                              suffixPressed: () {
                                RegisterCubit.get(context).changePasswordVisibility();
                              },
                              onSubmit: (value){
                              },
                              isPassword: RegisterCubit.get(context).isPassword,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'password is too short';
                                }
                              },
                              label: 'Password',
                              type: TextInputType.visiblePassword,
                            ),
                            SizedBox(
                              height: (height)/38,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              prefix: Icons.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your phone number';
                                }
                              },
                              label: 'phone',
                              type: TextInputType.phone,
                            ),
                            SizedBox(
                              height: (height)/16,
                            ),
                            ConditionalBuilder(
                              condition: state is! RegisterLoadingState ,
                              fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                              builder: (BuildContext context) => defaultButton(
                                width: MediaQuery.of(context).size.width/2,
                                function: () {

                                  if (formKey.currentState!.validate()){
                                    RegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );

                                  }
                                },
                                text: 'Register',
                              ),

                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: hDivider(context)),
                      const Text(
                        'OR',
                        style: TextStyle(
                            color: Colors.black45
                        ),
                      ),
                      Expanded(child: hDivider(context)),
                    ],
                  ),
                   SizedBox(
                    height: (height)/80,
                  ),
                  ConditionalBuilder(
                    condition: state is !GoogleRegisterLoadingState,
                    fallback: (context)=>const Center(child:  CircularProgressIndicator(),),
                    builder:(context)=> googleButton(
                        context,
                        text:'Sign up with Google',
                      onPressed: (){
                        RegisterCubit.get(context).signInWithGoogle();
                      }
                    ),
                  ),
                   SizedBox(
                    height: (height)/80,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text("Already have an account?"),
                  //     defaultTextButton(
                  //         function: () {
                  //           navigateTo(context,  LoginScreen());
                  //         },
                  //         text: 'Login'),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        } ,

      ),
    );
  }
}