import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoicepro/Feature/Invoice/domin/entity/invoice_entity.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/featured_invoice_cubit/featured_invoices_cubit.dart';

class CustomerDataFormSection extends StatefulWidget {
  const CustomerDataFormSection({super.key});

  @override
  State<CustomerDataFormSection> createState() =>
      _CustomerDataFormSectionState();
}

class _CustomerDataFormSectionState extends State<CustomerDataFormSection> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final carModelController = TextEditingController();
  final carBrandController = TextEditingController();
  final plateController = TextEditingController();
  final notesController = TextEditingController();

  void saveCustomer() {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<FeaturedInvoicesCubit>();

      final customer = InvoiceEntity(
        invoiceNumber: cubit.state.invoiceNumber.toString(),
        date: DateTime.now(),
        customerName: nameController.text,
        phone: phoneController.text,
        carModel: carModelController.text,
        carBrand: carBrandController.text,
        plateNumber: plateController.text,
        notes: notesController.text,
        items: [],
      );

      cubit.setCustomer(customer);

      if (_formKey.currentState!.validate()) {
        final customer = InvoiceEntity(
          invoiceNumber: "",
          date: DateTime.now(),
          customerName: nameController.text,
          phone: phoneController.text,
          carModel: carModelController.text,
          carBrand: carBrandController.text,
          plateNumber: plateController.text,
          notes: notesController.text,
          items: [],
        );

        context.read<FeaturedInvoicesCubit>().setCustomer(customer);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("تم حفظ بيانات العميل")));
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    carModelController.dispose();
    carBrandController.dispose();
    plateController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// اسم + تليفون
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "اسم العميل",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? "مطلوب" : null,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "التليفون",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? "مطلوب" : null,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.h),

              /// موديل + ماركة
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: carModelController,
                      decoration: const InputDecoration(
                        labelText: "الموديل",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: TextFormField(
                      controller: carBrandController,
                      decoration: const InputDecoration(
                        labelText: "الماركة",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              /// رقم اللوحة
              TextFormField(
                controller: plateController,
                decoration: const InputDecoration(
                  labelText: "رقم اللوحة",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 5.h),

              /// ملاحظة
              TextFormField(
                controller: notesController,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: "ملاحظة",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 5.h),

              /// زر حفظ
              GestureDetector(
                onTap: saveCustomer,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "حفظ البيانات",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
