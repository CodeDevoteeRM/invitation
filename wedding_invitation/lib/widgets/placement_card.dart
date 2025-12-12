import 'package:flutter/material.dart';
import 'package:wedding_invitation/widgets/table_card.dart';
import 'table_types.dart';

class TablesGridWidget extends StatelessWidget {
  final List<TableInfo> tables;
  final String searchQuery;
  final ColorScheme colorScheme;
  final TableArrangementStyle style;

  const TablesGridWidget({
    super.key,
    required this.tables,
    required this.searchQuery,
    required this.colorScheme,
    this.style = TableArrangementStyle.elegant,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        int crossAxisCount;
        double childAspectRatio;
        double spacing;

        if (screenWidth > 900) {
          crossAxisCount = 3;
          childAspectRatio = 1.2;
          spacing = 20;
        } else if (screenWidth > 600) {
          crossAxisCount = 2;
          childAspectRatio = 1.3;
          spacing = 16;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 1.6;
          spacing = 12;
        }

        return GridView.builder(
          shrinkWrap: true, 
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
          ),
          padding: EdgeInsets.all(spacing),
          itemCount: tables.length,
          itemBuilder: (context, index) {
            final table = tables[index];
            final isHighlighted = searchQuery.isNotEmpty &&
                (table.number.toString().contains(searchQuery) ||
                    table.guests.any((guest) =>
                        guest.toLowerCase().contains(searchQuery.toLowerCase())));

            return TableCardWidget(
              table: table,
              searchQuery: searchQuery,
              isHighlighted: isHighlighted,
              colorScheme: colorScheme,
              style: style,
            );
          },
        );
      },
    );
  }
}