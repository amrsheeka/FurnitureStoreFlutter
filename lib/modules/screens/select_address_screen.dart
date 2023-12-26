import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/components/default_button.dart';
import 'package:furniture_store/components/default_form_field.dart';
import 'package:furniture_store/components/navigation.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/cubits/shop_cubit/states.dart';
import 'package:furniture_store/modules/screens/orders_screen.dart';
import 'package:furniture_store/shared/constants.dart';
import '../../components/line.dart';
import '../../components/show_toast.dart';
import '../../layouts/shopLayout.dart';
import '../../shared/icon_broken.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({Key? key}) : super(key: key);

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  int selectedAddress = -1;
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [

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
                                    setState(() {
                                      selectedAddress =-1;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(child: Text('${cubit.user?.addresses[index]}')),
                                      IconButton(
                                          onPressed: (){
                                            cubit.deleteAddress(index: index);
                                            setState(() {
                                              selectedAddress =-1;
                                            });
                                          },
                                          icon: const Icon(IconBroken.Delete,color: Colors.red,)
                                      ),
                                      IconButton(
                                          onPressed: (){
                                            setState(() {
                                              selectedAddress = index;
                                            });
                                          },
                                          icon: Icon(
                                              selectedAddress==index?
                                              Icons.radio_button_checked :Icons.radio_button_unchecked,
                                            color: mainColor,
                                          )
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
                  Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 20,
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('Total Price',style: TextStyle(
                                    color: Colors.blueGrey,
                                  ),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${cubit.totalPrice}',style: const TextStyle(
                                        fontSize: 20,
                                      ),),
                                      const Text(' \$',style: TextStyle(fontSize: 20,color: Colors.green),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            defaultButton(
                                onPressed: (){
                                  if(selectedAddress!=-1){
                                    cubit.makeOrder(amount: cubit.totalPrice, address: cubit.user?.addresses[selectedAddress])
                                        .then((value) {
                                          cubit.changeIndex(2);
                                          navigateTo(context: context, page: const ShopLayout());
                                    });
                                  }else{
                                    showToast(message: 'Select your address', type: ToastType.WARNING);
                                  }
                                },
                                text: 'Pay',
                                icon: const Icon(IconBroken.Buy,color: Colors.white,)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
