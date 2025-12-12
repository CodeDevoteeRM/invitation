// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationWidget extends StatelessWidget {
  final String title;
  final String mainAddress;
  final String fullAddress;
  final String mapUrl;
  final LocationStyle style;

  const LocationWidget({
    super.key,
    this.title = 'Локация',
    this.mainAddress = 'Банкетный зал "Метрополь Холл"',
    this.fullAddress =
        'Московская область, Ленинский городской округ, '
        'Видное, Каширское шоссе, 27-й километр, 20/1с1',
    this.mapUrl = 'https://yandex.ru/maps/?text="Метрополь Холл"',
    this.style = LocationStyle.elegant,
  });

  Future<void> _openMap(BuildContext context) async {
    final Uri uri = Uri.parse(mapUrl);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception('Не удалось открыть карту');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Не удалось открыть карту'),
          backgroundColor: Theme.of(context).colorScheme.error,
          action: SnackBarAction(
            label: 'Попробовать ещё раз',
            onPressed: () => _openMap(context),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case LocationStyle.elegant:
        return _buildElegantStyle(context);
      case LocationStyle.modern:
        return _buildModernStyle(context);
      case LocationStyle.minimal:
        return _buildMinimalStyle(context);
      case LocationStyle.card:
        return _buildCardStyle(context);
    }
  }

  Widget _buildElegantStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 2,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    colorScheme.primary.withOpacity(0.5), // #4C6444
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: colorScheme.primary, // #4C6444
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary, // #4C6444
                    letterSpacing: 0.5,
                    fontFamily: 'Gnocchi',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Будем рады видеть вас!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: colorScheme.primary.withOpacity(0.7), // #4C6444
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.1), // #4C6444
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.1), // #4C6444
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.05), // #4C6444
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(0.1), // #4C6444
                      ),
                    ),
                    child: Text(
                      mainAddress,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary, // #4C6444
                        fontFamily: 'Gnocchi',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      fullAddress,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: colorScheme.primary.withOpacity(0.8), // #4C6444
                        height: 1.4,
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          colorScheme.secondary.withOpacity(0.2), // #765B50
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _openMap(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.secondary, // #765B50
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        shadowColor: colorScheme.secondary.withOpacity(
                          0.3,
                        ), // #765B50
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map_outlined, size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'Открыть карту',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildMapServiceButton(
    BuildContext context,
    String title,
    String url,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _openMap(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.2), // #4C6444
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: colorScheme.primary, // #4C6444
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.primary, // #4C6444
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.tertiary.withOpacity(0.1), // #BA9B8E
              colorScheme.surface,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.1), // #4C6444
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [
                    colorScheme.primary, // #4C6444
                    colorScheme.secondary, // #765B50
                  ],
                ).createShader(bounds);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'Gnocchi',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Банкетный зал "Метрополь Холл"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colorScheme.primary, // #4C6444
                fontFamily: 'Gnocchi',
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.1), // #4C6444
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.pin_drop,
                    size: 32,
                    color: colorScheme.secondary, // #765B50
                  ),
                  const SizedBox(height: 12),
                  Text(
                    fullAddress,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.primary.withOpacity(0.8), // #4C6444
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _openMap(context),
                    icon: Icon(Icons.map_outlined),
                    label: const Text('Открыть карту'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary, // #4C6444
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () => _openMap(context),
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.secondary.withOpacity(
                      0.1,
                    ), // #765B50
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    Icons.navigation,
                    color: colorScheme.secondary, // #765B50
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimalStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: colorScheme.primary, // #4C6444
                fontFamily: 'Gnocchi',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              mainAddress,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: colorScheme.primary, // #4C6444
              ),
            ),
            const SizedBox(height: 8),
            Text(
              fullAddress,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.primary.withOpacity(0.7), // #4C6444
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => _openMap(context),
              icon: Icon(
                Icons.map,
                color: colorScheme.secondary, // #765B50
              ),
              label: Text(
                'Открыть карту',
                style: TextStyle(
                  color: colorScheme.secondary, // #765B50
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: colorScheme.secondary, // #765B50
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450),
        margin: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1), // #4C6444
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on,
                        size: 20,
                        color: colorScheme.primary, // #4C6444
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary, // #4C6444
                        fontFamily: 'Gnocchi',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary.withOpacity(0.05), // #BA9B8E
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.tertiary.withOpacity(0.1), // #BA9B8E
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        mainAddress,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.primary, // #4C6444
                        ),
                      ),
                      const SizedBox(height: 8),
                      Divider(
                        height: 1,
                        color: colorScheme.primary.withOpacity(0.1), // #4C6444
                      ),
                      const SizedBox(height: 8),
                      Text(
                        fullAddress,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.primary.withOpacity(
                            0.7,
                          ), // #4C6444
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => _openMap(context),
                  icon: Icon(Icons.open_in_new, color: Colors.white),
                  label: const Text(
                    'Открыть в картах',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.secondary, // #765B50
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum LocationStyle { elegant, modern, minimal, card }
