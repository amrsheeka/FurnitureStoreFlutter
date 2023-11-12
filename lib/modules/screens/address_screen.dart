import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/components/default_button.dart';
import 'package:furniture_store/components/default_form_field.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/cubits/shop_cubit/states.dart';
import 'package:furniture_store/shared/constants.dart';
import '../../shared/icon_broken.dart';

class AddressScreen extends StatelessWidget {
  double totalPrice;
  AddressScreen({Key? key, required this.totalPrice}) : super(key: key);
  TextEditingController streetAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
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
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/location.png'))),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
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
                          defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.makeOrder(
                                      amount: cubit.totalPrice,
                                      city: cubit.selectedCity ?? '',
                                      street: streetAddress.text);
                                }
                              },
                              text: 'Next'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
