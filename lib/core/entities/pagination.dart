import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int? page;
  final int? itemsPerPage;
  final String? query;
  const Pagination({
    this.page,
    this.itemsPerPage = 10,
    this.query,
  });
  @override
  List<Object?> get props => [
        page,
        itemsPerPage,
        query,
      ];
}
