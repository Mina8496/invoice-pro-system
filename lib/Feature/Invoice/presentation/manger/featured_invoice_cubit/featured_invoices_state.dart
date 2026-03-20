part of 'featured_invoices_cubit.dart';

sealed class FeaturedInvoicesState {}

final class FeaturedInvoicesInitial extends FeaturedInvoicesState {}

class InvoiceUpdated extends FeaturedInvoicesState {
  final List<InvoiceItemEntity>? items;
  final double? total;

  InvoiceUpdated(this.items, this.total);
}

class InvoiceLoading extends FeaturedInvoicesState {}

class InvoiceSuccess extends FeaturedInvoicesState {}

class InvoiceError extends FeaturedInvoicesState {
  final String message;

  InvoiceError(this.message);
}
