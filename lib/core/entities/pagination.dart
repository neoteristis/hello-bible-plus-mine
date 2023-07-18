import 'package:equatable/equatable.dart';

import '../constants/pagination_const.dart';

class Pagination extends Equatable {
  final int? page;
  final int? itemsPerPage;
  final String? query;
  const Pagination({
    this.page,
    this.itemsPerPage = itemNumber,
    this.query,
  });
  @override
  List<Object?> get props => [
        page,
        itemsPerPage,
        query,
      ];
}
