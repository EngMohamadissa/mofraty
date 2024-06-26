import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/funcations/validat_funcation.dart';
import '../../../../../core/widget/custom_text_field.dart';

import '../../manager/cubit/mydata_cubit_cubit.dart';
import '../../manager/cubit/mydata_cubit_state.dart';
import 'elevated_botton_data.dart';

class MyDataViewBody extends StatefulWidget {
  const MyDataViewBody({
    super.key,
  });

  @override
  State<MyDataViewBody> createState() => _MyDataViewBodyState();
}

class _MyDataViewBodyState extends State<MyDataViewBody> {
  bool _isEditable = false;
  String? selectedProduct;
  String buttonText = 'تعديل البيانيات';

  void _toggleState() {
    setState(() {
      if (buttonText == 'تعديل البيانيات') {
        // إذا كانت الحالة قابلة للتحرير، قم بتغيير النص إلى "حفظ البيانيات"
        buttonText = 'حفظ البيانيات';
      }
      _isEditable = !_isEditable;
    });
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final GlobalKey<FormState> formKeyname = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double horizontalPadding = screenSize.width * 0.05;

    final double textScaleFactor = screenSize.width < 600 ? 0.9 : 1.1;
    return BlocConsumer<MydataCubit, MydataState>(
      listener: (context, state) {
        if (state is UpdateNameSuccess) {
          BlocProvider.of<MydataCubit>(context).getMarket();
          setState(() {});
          showCustomSnackBar(context, state.message, color: Colors.green);
        }
      },
      builder: (context, state) {
        if (state is MydataLoaded) {
          return Form(
            key: formKeyname,
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                CustomTextfield(
                  readOnly: true,
                  hintText: state.market.phoneNumber,
                  hintStyle: const TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'الهاتف',
                  isDense: true,
                  label: const Text(
                    'رقم الهاتف',
                  ),
                  labelStyle: TextStyle(
                    color: Colors.blue[300],
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                CustomTextfield(
                  readOnly: !_isEditable,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: false,
                  label: const Text(' الاسم الاول'),
                  validator: checkValidate,
                  hintText: state.market.firstName,
                  labelStyle: TextStyle(
                    color: Colors.blue[300],
                  ),
                  controller: _firstNameController,
                  floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                CustomTextfield(
                  readOnly: !_isEditable,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: false,
                  validator: checkValidate,
                  label: const Text(' الاسم الوسط'),
                  hintText: state.market.middleName,
                  labelStyle: TextStyle(
                    color: Colors.blue[300],
                  ),
                  controller: _middleNameController,
                  floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                CustomTextfield(
                  readOnly: !_isEditable,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: false,
                  validator: checkValidate,
                  label: const Text(' الاسم الاخير'),
                  hintText: state.market.lastName,
                  labelStyle: TextStyle(
                    color: Colors.blue[300],
                  ),
                  controller: _lastNameController,
                  floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                CustomTextfield(
                  readOnly: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: true,
                  label: const Text('اسم المحل'),
                  hintText: state.market.storeName,
                  labelStyle: TextStyle(
                    color: Colors.blue[300],
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                CustomTextfield(
                  readOnly: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: true,
                  label: const Text('نوع المحل '),
                  hintText: state.market.categoryname,
                  labelStyle: TextStyle(
                    color: Colors.blue[300],
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                // CustomTextfield(
                //   readOnly: true,
                //   hintText: 'الاسكندرية',
                //   floatingLabelBehavior: FloatingLabelBehavior.always,
                //   isDense: true,
                //   label: const Text('المحافظة'),
                //   labelStyle: TextStyle(
                //     color: Colors.blue[300],
                //   ),
                //   floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                // ),
                CustomTextfield(
                  readOnly: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: true,
                  hintText: state.market.cityname,
                  label: const Text('المنطقة'),
                  labelStyle: TextStyle(
                    color: Colors.blue[300],
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 220, 213, 213),
                    ),
                    height: 50,
                    child: Center(
                      child: Text(
                        ' موقع المنشأة',
                        style: TextStyle(
                          fontSize: 20 * textScaleFactor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                CustomTextfield(
                  readOnly: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: true,
                  hintText: state.market.locationdetails,
                  label: const Text('العنوان'),
                  labelStyle: TextStyle(
                    color: Colors.blue[300],
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),
                CustomTextfield(
                  readOnly: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: true,
                  hintText: state.market.representatorCode,
                  label: const Text('الكود(اختياري)'),
                  labelStyle: TextStyle(
                    color: Colors.blue[300],
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.blue[300]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                ),

                ElevatedBottonData(
                  data: buttonText,
                  onLongPress: () {
                    // تحقق فقط عند الضغط لحفظ البيانات
                    if (buttonText == 'حفظ البيانيات') {
                      // تحقق من صحة النموذج
                      if (formKeyname.currentState!.validate()) {
                        // إذا كانت الحقول صالحة، تابع تحديث البيانات
                        BlocProvider.of<MydataCubit>(context).updateName(
                          _firstNameController.text,
                          _middleNameController.text,
                          _lastNameController.text,
                        );
                        // BlocProvider.of<MydataCubit>(context).getMarket();
                        // setState(() {});

                        // بعد حفظ البيانات، قم بتغيير النص إلى "تعديل البيانيات" وتعيين الحالة إلى غير قابلة للتحرير
                        setState(() {
                          buttonText = 'تعديل البيانيات';
                          _isEditable =
                              false; // تأكد من تعيين الحالة إلى غير قابلة للتحرير
                        });
                      } else {
                        // إذا كانت الحقول فارغة أو غير صالحة، عرض رسالة خطأ
                        showCustomSnackBar(
                            context, 'تأكد من ملأ جميع الحقول من فضلك',
                            color: Colors.red);
                      }
                    } else {
                      // إذا كان النص هو "تعديل البيانيات"، قم فقط بتغيير الحالة لتصبح قابلة للتحرير
                      _toggleState();
                    }
                  },
                  backgroundColor: Colors.green,
                ),

                ElevatedBottonData(
                  onLongPress: () {},
                  data: 'تغيير الرقم السري',
                  backgroundColor: Colors.yellow,
                ),
                ElevatedBottonData(
                    onLongPress: () {},
                    data: 'تسجيل الخروج',
                    backgroundColor: kPrimaryColorred)
              ],
            ),
          );
        } else if (state is MydataLoading) {
          return buildLoadingIndicator();
        } else if (state is MydataError) {
//               return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }

  void fromvv() {
    if (formKeyname.currentState!.validate()) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors in the form')),
      );
    }
  }
}

// void _toggleEdit() {
//   setState(() {
//     _isEditable = !_isEditable;
//   });
// }

// void _namebotton() {
//   print('121231232');
//   setState(() {
//     if (buttonText == 'تعديل البيانيات') {
//       buttonText = 'حفظ البيانيات';
//     } else {
//       buttonText = 'تعديل البيانيات';
//     }
//   });
// }

// void iconbotton() {
//   if (onChanged == null) {
//     onChanged = (String? newValue) {
//       setState(() {
//         selectedProduct = newValue;
//       });
//     };
//   } else {
//     onChanged = null;
//   }
// }
