class InvoicePaginationService {
  List<List<T>> splitItems<T>(List<T> items, int perPage) {
    final pages = <List<T>>[];

    for (int i = 0; i < items.length; i += perPage) {
      pages.add(
        items.sublist(
          i,
          i + perPage > items.length ? items.length : i + perPage,
        ),
      );
    }

    return pages;
  }
}