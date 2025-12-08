import 'package:flutter/material.dart';

class TableArrangementWidget extends StatelessWidget {
  final String title;
  final int totalGuests;
  final TableArrangementStyle style;
  final List<TableInfo> tables;
  final ColorScheme? customColorScheme;

  const TableArrangementWidget({
    super.key,
    this.title = 'Расположение столов',
    this.totalGuests = 70,
    this.style = TableArrangementStyle.elegant,
    this.tables = _defaultTables,
    this.customColorScheme,
  });

  static const List<TableInfo> _defaultTables = [
    TableInfo(
      number: 1,
      name: 'Свадебный стол',
      capacity: 6,
      guests: [
        'Анна Смирнова',
        'Иван Петров',
        'Мария Иванова',
        'Сергей Сидоров',
        'Елена Кузнецова',
        'Дмитрий Волков',
      ],
      type: TableType.honor,
    ),
    TableInfo(
      number: 2,
      name: 'Друзья детства',
      capacity: 8,
      guests: [
        'Ольга Новикова',
        'Алексей Морозов',
        'Татьяна Захарова',
        'Павел Орлов',
        'Юлия Лебедева',
        'Максим Семенов',
      ],
    ),
    TableInfo(
      number: 3,
      name: 'Коллеги',
      capacity: 8,
      guests: [
        'Андрей Козлов',
        'Наталья Фомина',
        'Артем Никитин',
        'Виктория Макарова',
        'Георгий Павлов',
        'Светлана Виноградова',
      ],
    ),
    TableInfo(
      number: 4,
      name: 'Родственники',
      capacity: 10,
      guests: [
        'Александр Соколов',
        'Ирина Попова',
        'Василий Михайлов',
        'Людмила Федорова',
        'Константин Алексеев',
        'Екатерина Андреева',
      ],
    ),
    TableInfo(
      number: 5,
      name: 'Школьные друзья',
      capacity: 8,
      guests: [
        'Олег Тимофеев',
        'Алина Сергеева',
        'Роман Громов',
        'Дарья Ковалева',
        'Станислав Белов',
        'Валентина Комарова',
      ],
    ),
    TableInfo(
      number: 6,
      name: 'Университет',
      capacity: 8,
      guests: [
        'Никита Егоров',
        'Ангелина Медведева',
        'Владислав Соловьев',
        'Полина Петрова',
        'Тимур Васильев',
        'Кристина Зайцева',
      ],
    ),
    TableInfo(
      number: 7,
      name: 'Родные',
      capacity: 12,
      guests: [
        'Галина Морозова',
        'Борис Волков',
        'Лариса Семенова',
        'Федор Лебедев',
        'Зинаида Козлова',
        'Григорий Новиков',
      ],
      type: TableType.family,
    ),
    TableInfo(
      number: 8,
      name: 'Друзья семьи',
      capacity: 6,
      guests: [
        'Раиса Петрова',
        'Виталий Смирнов',
        'Нина Федорова',
        'Игорь Михайлов',
        'Римма Николаева',
        'Семен Кузнецов',
      ],
    ),
  ];

  ColorScheme _getColorScheme(BuildContext context) {
    return customColorScheme ?? Theme.of(context).colorScheme;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = _getColorScheme(context);

    switch (style) {
      case TableArrangementStyle.elegant:
        return _buildElegantStyle(context, colorScheme);
      case TableArrangementStyle.modern:
        return _buildModernStyle(context, colorScheme);
      case TableArrangementStyle.minimal:
        return _buildMinimalStyle(context, colorScheme);
      case TableArrangementStyle.interactive:
        return _buildInteractiveStyle(context, colorScheme);
      case TableArrangementStyle.grid:
        return _buildGridStyle(context, colorScheme);
    }
  }

  Widget _buildElegantStyle(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Заголовок с украшением
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.table_restaurant_outlined,
                        color: colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Статистика
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    context,
                    '${tables.length}',
                    'Столов',
                    Icons.table_bar,
                    colorScheme.primary,
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: colorScheme.outline.withOpacity(0.2),
                  ),
                  _buildStatItem(
                    context,
                    '$totalGuests',
                    'Гостей',
                    Icons.group,
                    colorScheme.secondary,
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: colorScheme.outline.withOpacity(0.2),
                  ),
                  _buildStatItem(
                    context,
                    '${tables.fold(0, (sum, table) => sum + table.capacity)}',
                    'Мест',
                    Icons.chair,
                    colorScheme.tertiary,
                  ),
                ],
              ),
            ),

            // Схема столов
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Первый ряд столов
                    Row(
                      children: [
                        _buildTableItem(
                          context,
                          tables[0],
                          colorScheme,
                          isHighlighted: true,
                        ),
                        const SizedBox(width: 40),
                        _buildTableItem(context, tables[1], colorScheme),
                        const SizedBox(width: 40),
                        _buildTableItem(context, tables[2], colorScheme),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Второй ряд столов
                    Row(
                      children: [
                        _buildTableItem(context, tables[3], colorScheme),
                        const SizedBox(width: 40),
                        _buildTableItem(context, tables[4], colorScheme),
                        const SizedBox(width: 40),
                        _buildTableItem(context, tables[5], colorScheme),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Третий ряд столов
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTableItem(
                          context,
                          tables[6],
                          colorScheme,
                          isWide: true,
                        ),
                        const SizedBox(width: 40),
                        _buildTableItem(context, tables[7], colorScheme),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Легенда
            Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Обозначения:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _buildLegendItem(
                        'Свадебный стол',
                        colorScheme.primary,
                        Icons.favorite_border,
                      ),
                      _buildLegendItem(
                        'Семейный стол',
                        colorScheme.secondary,
                        Icons.family_restroom,
                      ),
                      _buildLegendItem(
                        'Обычный стол',
                        colorScheme.outline,
                        Icons.table_restaurant,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableItem(
    BuildContext context,
    TableInfo table,
    ColorScheme colorScheme, {
    bool isHighlighted = false,
    bool isWide = false,
  }) {
    return Column(
      children: [
        // Номер стола
        Container(
          width: isWide ? 160 : 120,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isHighlighted
                ? colorScheme.primary
                : colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Стол ${table.number}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isHighlighted
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                table.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isHighlighted
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.group,
                    size: 12,
                    color: isHighlighted
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${table.guests.length}/${table.capacity}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isHighlighted
                          ? colorScheme.onPrimary
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Линия к столу
        Container(
          width: 2,
          height: 20,
          color: colorScheme.primary.withOpacity(0.3),
        ),

        // Иконка стола
        Container(
          width: isWide ? 140 : 100,
          height: 60,
          decoration: BoxDecoration(
            color: _getTableColor(table.type, colorScheme),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHighlighted
                  ? colorScheme.primary
                  : colorScheme.outline.withOpacity(0.3),
              width: isHighlighted ? 2 : 1,
            ),
          ),
          child: Center(
            child: Icon(
              _getTableIcon(table.type),
              color: _getTableIconColor(table.type, colorScheme),
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernStyle(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Заголовок
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [colorScheme.primary, colorScheme.secondary],
                ).createShader(bounds);
              },
              child: Column(
                children: [
                  Icon(Icons.table_chart, size: 32, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Карточки столов
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: tables.map((table) {
                return _buildModernTableCard(context, table, colorScheme);
              }).toList(),
            ),

            // Статистика внизу
            Container(
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colorScheme.surface, colorScheme.surfaceVariant],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Общая информация',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${tables.length}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.primary,
                            ),
                          ),
                          Text(
                            'столов',
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '$totalGuests',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.secondary,
                            ),
                          ),
                          Text(
                            'гостей',
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '70',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            'мест всего',
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTableCard(
    BuildContext context,
    TableInfo table,
    ColorScheme colorScheme,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _getTableColor(table.type, colorScheme).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _getTableColor(table.type, colorScheme).withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Заголовок стола
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: _getTableColor(table.type, colorScheme),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Стол ${table.number}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _getTableTextColor(table.type, colorScheme),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Название стола
              Text(
                table.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),

              // Иконка и вместимость
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.group,
                    size: 16,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${table.guests.length}/${table.capacity}',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Список гостей
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: table.guests.take(3).map((guest) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      '• ${_getShortName(guest)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  );
                }).toList(),
              ),

              if (table.guests.length > 3)
                Text(
                  '+${table.guests.length - 3} гостей',
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurface.withOpacity(0.5),
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimalStyle(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 24),

            // Список столов
            ...tables.map((table) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colorScheme.outline.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    // Номер стола
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getTableColor(
                          table.type,
                          colorScheme,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _getTableColor(table.type, colorScheme),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${table.number}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _getTableColor(table.type, colorScheme),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Информация
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            table.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${table.guests.length} гостей из ${table.capacity} мест',
                            style: TextStyle(
                              fontSize: 13,
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Иконка
                    Icon(
                      _getTableIcon(table.type),
                      color: _getTableColor(table.type, colorScheme),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Итого
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.primary.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Всего гостей:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '$totalGuests человек',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveStyle(BuildContext context, ColorScheme colorScheme) {
    // Для краткости покажу структуру, реализация будет аналогична
    return _buildModernStyle(context, colorScheme);
  }

  Widget _buildGridStyle(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Схема зала',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Сетка столов
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: tables.map((table) {
                return _buildGridTableItem(table, colorScheme);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTableItem(TableInfo table, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: _getTableColor(table.type, colorScheme).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getTableColor(table.type, colorScheme).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${table.number}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: _getTableColor(table.type, colorScheme),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            table.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${table.guests.length}/${table.capacity}',
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: color.withOpacity(0.7)),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }

  Color _getTableColor(TableType type, ColorScheme colorScheme) {
    switch (type) {
      case TableType.honor:
        return colorScheme.primary;
      case TableType.family:
        return colorScheme.secondary;
      case TableType.vip:
        return colorScheme.tertiary;
      default:
        return colorScheme.outline.withOpacity(0.5);
    }
  }

  Color _getTableIconColor(TableType type, ColorScheme colorScheme) {
    switch (type) {
      case TableType.honor:
      case TableType.family:
      case TableType.vip:
        return colorScheme.onPrimary;
      default:
        return colorScheme.outline;
    }
  }

  Color _getTableTextColor(TableType type, ColorScheme colorScheme) {
    switch (type) {
      case TableType.honor:
      case TableType.family:
      case TableType.vip:
        return colorScheme.onPrimary;
      default:
        return colorScheme.onSurface;
    }
  }

  IconData _getTableIcon(TableType type) {
    switch (type) {
      case TableType.honor:
        return Icons.favorite;
      case TableType.family:
        return Icons.family_restroom;
      case TableType.vip:
        return Icons.star;
      default:
        return Icons.table_restaurant;
    }
  }

  String _getShortName(String fullName) {
    final parts = fullName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0]} ${parts[1].substring(0, 1)}.';
    }
    return fullName;
  }
}

// Модель для стола
class TableInfo {
  final int number;
  final String name;
  final int capacity;
  final List<String> guests;
  final TableType type;

  const TableInfo({
    required this.number,
    required this.name,
    required this.capacity,
    required this.guests,
    this.type = TableType.standard,
  });
}

// Тип стола
enum TableType {
  honor, // Свадебный/почетный стол
  family, // Семейный стол
  vip, // VIP стол
  standard, // Обычный стол
}

// Стили виджета
enum TableArrangementStyle {
  elegant, // Элегантный с визуальной схемой
  modern, // Современный с карточками
  minimal, // Минималистичный список
  interactive, // Интерактивный (можно добавить тапы)
  grid, // Сетка
}
