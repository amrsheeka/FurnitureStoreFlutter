import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/components/default_button.dart';
import 'package:furniture_store/components/default_form_field.dart';
import 'package:furniture_store/components/line.dart';
import 'package:furniture_store/components/show_toast.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/cubits/shop_cubit/states.dart';
import 'package:furniture_store/shared/constants.dart';
import '../../shared/icon_broken.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController streetAddress = TextEditingController();
    return BlocConsumer<ShopCubit, ShopState>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.black,
              ),
            ),
            title: const Text('Insert your address'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/location.png'))),
                    ),
                    DropdownButtonFormField<String>(
                        hint: const Center(
                            child: Text(
                          'Select your city',
                          //style: TextStyle(color: Colors.white),
                        )),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color:
                              Colors.white
                              ),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            fillColor: Colors.blueGrey[50],
                            filled: true
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Choose your current city';
                          }
                          return null;
                        },

                        dropdownColor: Colors.blueGrey[50],
                        isDense: true,
                        isExpanded: true,
                        icon: const Icon(IconBroken.Arrow___Down_2),
                        items: cubit.cities.map<DropdownMenuItem<String>>(
                            (dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                                child: Text(
                              value,
                              style: const TextStyle(color: mainColor),
                            )),
                          );
                        }).toList(),
                        value: cubit.selectedCity,
                        onChanged: (value) {
                          if (value != null) {
                            cubit.changeCity(city: value.toString());
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                        label: 'Street full address',
                        controller: streetAddress,
                        prefixIcon: const Icon(IconBroken.Paper),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter The street address';
                          } else if (value.length < 6) {
                            return 'Enter a detailed street address for more than 6 characters';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                        condition: state is !AddAddressLoadingState,
                        builder: (context) => defaultButton(
                            icon: const Icon(IconBroken.Plus,color: Colors.white,),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.addAddress(address: streetAddress.text);
                              }
                            },
                            text: 'add'
                        ),
                        fallback:(context) => const CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 30,),
                    line(icon: const Icon(
                      IconBroken.Location,
                      color: Colors.blueGrey,
                    )
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Dismissible(
                          key: Key('$index'),
                          onDismissed: (value){
                            cubit.deleteAddress(index: index);
                          },
                          child: Row(
                            children: [
                              Expanded(child: Text('${cubit.user?.addresses[index]}')),
                              IconButton(
                                  onPressed: (){
                                    cubit.deleteAddress(index: index);
                                  },
                                  icon: const Icon(IconBroken.Delete,color: Colors.red,)
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => line(inlineText: '.'),
                        itemCount: cubit.user!.addresses.length
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if(state is AddAddressSuccessState){
          showToast(message: 'Address added successfully', type: ToastType.SUCCESS);
        }else if(state is AddAddressErrorState){
          showToast(message: 'Something went wrong', type: ToastType.ERROR);
        }
        if(state is DeleteAddressSuccessState){
          showToast(message: 'Address deleted successfully', type: ToastType.SUCCESS);
        }else if(state is DeleteAddressErrorState){
          showToast(message: 'Something went wrong', type: ToastType.ERROR);
        }
      },
    );
  }
}
