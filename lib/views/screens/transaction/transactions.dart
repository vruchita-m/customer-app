import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/dropdowncubit/transaction_cubit.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/views/widegts/custom_appbar.dart';
import 'package:service_mitra/views/widegts/custom_dropdown.dart';

import '../../widegts/custom_elevated_button2.dart';
import '../../widegts/custom_textformfield3.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textformfieldcol,
      appBar: CustomAppBar(title: "Transactions"),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 15),
          child: Column(
            children: [
              Container(
                width: width,
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 300),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: AppColors.whitecol),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: BlocBuilder<TransactionCubitDropdown, String?>(
                          builder: (context, selectedMonths) {
                            return CustomDropDown(
                              text: "Select Months",
                              items: ["January", "February", "March"],
                              selectedItem: selectedMonths,
                              onItemSelected: (value) {
                                context
                                    .read<TransactionCubitDropdown>()
                                    .selecMonths(value);
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: CustomTextFormField3(
                            countertext: "",
                            readonly: false,
                            hintText: "Enter Email",
                            keyboardType: TextInputType.emailAddress),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colElevatedButton,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: AppColors.primarycol))),
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Text(
                  textAlign: TextAlign.center,
                  "Download",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w500,
                      color: AppColors.primarycol),
                ),
              ),
            ),
            CustomElevatedButton2(
              text: 'Send Mail',
              color: AppColors.primarycol,
            )
          ],
        ),
      ),
    );
  }
}
