import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/Featuer/Auth/regiseter/presentaiton/manager/cubit/data_cubit.dart';
import 'package:eghyptproject/Featuer/Auth/regiseter/presentaiton/manager/cubit/data_state.dart';
import 'package:eghyptproject/Featuer/Auth/regiseter/presentaiton/view/widget/drowdown_city.dart';
import 'package:eghyptproject/core/utils/app_router.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/utils/funcations/validat_funcation.dart';
import 'package:eghyptproject/core/widget/custom_botton.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/styles.dart';
import '../../../../../../core/utils/funcations/build_linear_greadient.dart';
import '../../../../../../core/widget/custom_text_field.dart';
import 'container_rigester.dart';

class RigesterViewBody extends StatefulWidget {
  const RigesterViewBody({super.key});

  @override
  State<RigesterViewBody> createState() => _RigesterViewBodyState();
}

class _RigesterViewBodyState extends State<RigesterViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedProduct;
  String? idmarket;
  // City? cityID;
  // DropdownPage? d;
  String? selectedAreaId;
  // final TextEditingController idmarket = TextEditingController();

  // void onChanged(String? newValue) {
  //   setState(
  //     () {
  //       selectedProduct = newValue!;
  //     },
  //   );
  // }

  // final List<String> products = [
  //   'product1',
  //   'product 4',
  //   'product 3',
  //   'product 2',
  // ];
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double horizontalPadding = screenSize.width * 0.05;
    final double textScaleFactor = screenSize.width < 600 ? 0.9 : 1.1;
    double imageSize = screenWidth < 600 ? screenWidth * 0.5 : 200;
    double spaceHeight = screenHeight < 600 ? 10 : 20;
    double spaceHeights = screenHeight < 600 ? 10 : 20;

    final regesterCubit = BlocProvider.of<UserCubitCubit>(context);

    String? checkValidatelocation(String? value) {
      if (value == null || value.isEmpty) {
        // إذا كان الحقل فارغًا، قم بتعيين قيمة افتراضية
        regesterCubit.signUpmidllename.text = 'لا يوجد تفاصيل';
      }
      return null;
    }

    String? checkValidatecode(String? value) {
      if (value == null || value.isEmpty) {
        // إذا كان الحقل فارغًا، قم بتعيين قيمة افتراضية

        regesterCubit.signUprepresentatorcode.text = '';
      }
      return null;
    }

    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: buildLinearGradient(),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height < 600 ? 32 : 40,
            ),
            Text(
              "حساب  جديد",
              textAlign: TextAlign.center,
              style: Styles.textStyleRL(context),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
            ),

            Divider(
              thickness: 0.8,
              indent: MediaQuery.of(context).size.width * 0.1,
              endIndent: MediaQuery.of(context).size.width * 0.1,
              color: Colors.black,
            ),
            Image.asset(
                width: imageSize,
                height: imageSize,
                'assets/images/IMG_20240520_225153_669.png'),
            SizedBox(
              height: spaceHeights,
            ),

            // SizedBox(
            //   height: MediaQuery.of(context).size.height < 600 ? 150 : 200,
            // ),
            CustomTextfield(
              controller: regesterCubit.signUpfirstname,
              validator: checkValidate,
              prefixIcon: const Icon(Icons.person),
              label: const Text(
                'ادخل الأسم الاول',
              ),
              hintText: 'الأسم الثلاثي',
              floatingLabelStyle: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height < 600 ? 20 : 30,
            ),
            CustomTextfield(
              controller: regesterCubit.signUpmidllename,
              validator: checkValidate,
              prefixIcon: const Icon(Icons.person),
              label: const Text(
                'ادخل الأسم الوسط',
              ),
              hintText: 'الأسم الثلاثي',
              floatingLabelStyle: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height < 600 ? 20 : 30,
            ),
            CustomTextfield(
              controller: regesterCubit.signUplastname,
              validator: checkValidate,
              prefixIcon: const Icon(Icons.person),
              label: const Text(
                'ادخل الأسم الاخير',
              ),
              hintText: 'الأسم الثلاثي',
              floatingLabelStyle: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height < 600 ? 20 : 30,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomTextfield(
                onChanged: (value) {
                  // التأكد من أن رمز الدولة موجود دائماً
                  if (!value.startsWith('+20')) {
                    regesterCubit.signUpphonenumber.text = '+20';
                    regesterCubit.signUpphonenumber.selection =
                        TextSelection.fromPosition(
                      TextPosition(
                          offset: regesterCubit.signUpphonenumber.text.length),
                    );
                  }
                },
                controller: regesterCubit.signUpphonenumber,
                validator: checkValidate,
                prefixIcon: const Icon(Icons.phone),
                label: const Text(
                  'ادخل الرقم',
                ),
                floatingLabelStyle: const TextStyle(color: Colors.black),
                hintText: '....20+',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height < 600 ? 20 : 30,
            ),
            CustomTextfield(
              controller: regesterCubit.signUppassword,
              validator: checkValidate,
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
              hintText: '*******',
              label: const Text(
                'ادخل كلمة السر',
              ),
              floatingLabelStyle: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height < 600 ? 20 : 30,
            ),
            CustomTextfield(
              controller: regesterCubit.signUppasswordconfirmation,
              validator: checkValidate,
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
              hintText: '*******',
              label: const Text(
                'تاكيد كلمة السر',
              ),
              floatingLabelStyle: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height < 600 ? 20 : 30,
            ),
            CustomTextfield(
              controller: regesterCubit.signUpstorename,
              validator: checkValidate,
              isDense: true,
              prefixIcon: const Icon(Icons.store),
              label: const Text('اسم المحل'),
              floatingLabelStyle: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
            ),
            dropDownListRegister(context),
            SizedBox(
              height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
            ),
            DropdownPage(onAreaChanged: (String? areaId) {
              setState(() {
                selectedAreaId = areaId;
              });
              //   print('Selected Area ID: $selectedAreaId');
            }),
            SizedBox(
              height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
            ),
            ContainerRigester(
                horizontalPadding: horizontalPadding,
                textScaleFactor: textScaleFactor),
            SizedBox(
              height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
            ),
            CustomTextfield(
              controller: regesterCubit.signUpAria,
              //  validator: checkValidate,
              isDense: true,
              label: const Text('العنوان'),
              floatingLabelStyle: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height < 600 ? 32 : 40,
            ),
            CustomTextfield(
              controller: regesterCubit.signUprepresentatorcode,
              // validator: checkValidate,
              isDense: true,
              label: const Text('الكود(اختياري)'),
              floatingLabelStyle: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height < 600 ? 32 : 40,
            ),
            BlocConsumer<UserCubitCubit, UserCubitState>(
              listener: (context, state) {
                if (state is SignUpFailure) {
                  showCustomSnackBar(context, state.errorMessage,
                      color: Colors.red);
                } else if (state is SignUpSuccess) {
                  showCustomSnackBar(context, state.message,
                      color: Colors.green);
                  GoRouter.of(context).push(AppRouter.kloginView);
                }
              },
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return buildLoadingIndicator();
                }
                return CustomButton(
                  onTap: () async {
                    if (idmarket == null || selectedAreaId == null) {
                      final prefs = await SharedPreferences.getInstance();

                      final idstor = prefs.getString('storeid');
                      idmarket = idstor;

                      final idcity = prefs.getString('codid');
                      selectedAreaId = idcity;

                      print('ssss$idmarket');
                      print('ssss$selectedAreaId');
                    } else {
                      idmarket = idmarket;
                      selectedAreaId = selectedAreaId;

                      print('sssssssaas$idmarket');
                      print('ssaaaaass$selectedAreaId');
                    }

                    validateMethod(regesterCubit);
                  },
                  text: 'تسجيل',
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
            ),
          ],
        ),
      ),
    );
  }

  Form dropDownListRegister(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double horizontalPadding = screenWidth * 0.07;
    double verticalPadding = screenHeight * 0.01;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: BlocBuilder<DataCubit, MarketState>(
            builder: (context, state) {
              if (state is MarketLoadSuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'نوع المحل ',
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffE32020), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffE32020), width: 1.0),
                        ),
                      ),
                      value: state.selectedCategory,
                      hint: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('نوع المحل '),
                      ),

                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            selectedProduct = newValue!;
                          },
                        );
                      },
                      items: state.marketCategories
                          .map<DropdownMenuItem<String>>((dynamic category) {
                        return DropdownMenuItem<String>(
                          value: category['id'].toString(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(category['name']),
                          ),
                          onTap: () {
                            idmarket = category['id'].toString();
                            // print(idmarket);
                            // print(category['id'].toString());
                          },
                        );
                      }).toList(),
                      // validator: checkValidateDrowp,
                    ),
                  ],
                );
              } else if (state is MarketLoadInProgress) {
                return buildLoadingIndicator();
              } else if (state is MarketLoadFailure) {
                //   return Text('Error: ${state.error}');
                return buildLoadingIndicator();
              } else {
                return const Text(
                    'Please wait while categories are loading...');
              }
            },
          ),
        ),
      ),
    );
  }

  // void fromvv(UserCubitCubit userCubit) {
  //   if (_formKey.currentState!.validate()) {
  //     userCubit.signUp();

  //     GoRouter.of(context).push(AppRouter.kLoginView);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please correct the errors in the form')),
  //     );
  //   }
  // }
  void validateMethod(UserCubitCubit userCubit) {
    userCubit.signUp(selectedAreaId!, idmarket!);
    if (formKey.currentState!.validate()) {
    } else {
      {
        autovalidateMode = AutovalidateMode.always;
        setState(() {});
      }
    }
  }
}
