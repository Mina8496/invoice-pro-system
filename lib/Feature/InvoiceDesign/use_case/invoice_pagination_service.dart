class InvoicePaginationService {
  List<List<T>> splitItems<T>(List<T>? items, int perPage) {
    final safeItems = items ?? [];

    final pages = <List<T>>[];

    for (int i = 0; i < safeItems.length; i += perPage) {
      pages.add(
        safeItems.sublist(
          i,
          (i + perPage > safeItems.length) ? safeItems.length : i + perPage,
        ),
      );
    }

    return pages;
  }
}
