import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/aura_data.dart';
import '../utils/responsive_helper.dart';

class AuraRadarChart extends StatelessWidget {
  final List<double> values;
  final List<String> titles = AuraTraits.traitNames;

  const AuraRadarChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: RadarChart(
        RadarChartData(
          dataSets: [
          RadarDataSet(
            dataEntries: values.map((v) => RadarEntry(value: v * 10)).toList(),
            borderColor: Theme.of(context).colorScheme.primary,
            fillColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
            borderWidth: 2,
          ),
          ],
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          radarBorderData: const BorderSide(color: Colors.transparent),
          tickCount: 5,
          ticksTextStyle: const TextStyle(color: Colors.transparent),
          tickBorderData: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          gridBorderData: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          getTitle: (index, angle) {
            return RadarChartTitle(
              text: titles[index],
              angle: angle,
              positionPercentageOffset: 0.2,
            );
          },
        ),
      ),
    );
  }
}

class AuraTraitCard extends StatelessWidget {
  final String title;
  final String description;
  final double value;
  final Color color;

  const AuraTraitCard({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value * 100).round();
    
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuraTraitGrid extends StatelessWidget {
  final List<double> values;

  const AuraTraitGrid({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.purple,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
    ];

    return ResponsiveLayout(
      mobile: _buildMobileGrid(context, colors),
      tablet: _buildTabletGrid(context, colors),
      desktop: _buildDesktopGrid(context, colors),
    );
  }

  Widget _buildMobileGrid(BuildContext context, List<Color> colors) {
    return Column(
      children: _buildTraitCards(context, colors),
    );
  }

  Widget _buildTabletGrid(BuildContext context, List<Color> colors) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: AuraTraits.traitNames.length,
      itemBuilder: (context, index) => _buildTraitCard(
        context,
        AuraTraits.traitNames[index],
        AuraTraits.traitDescriptions[index],
        values[index],
        colors[index],
      ),
    );
  }

  Widget _buildDesktopGrid(BuildContext context, List<Color> colors) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: AuraTraits.traitNames.length,
      itemBuilder: (context, index) => _buildTraitCard(
        context,
        AuraTraits.traitNames[index],
        AuraTraits.traitDescriptions[index],
        values[index],
        colors[index],
      ),
    );
  }

  List<Widget> _buildTraitCards(BuildContext context, List<Color> colors) {
    return List.generate(
      AuraTraits.traitNames.length,
      (index) => _buildTraitCard(
        context,
        AuraTraits.traitNames[index],
        AuraTraits.traitDescriptions[index],
        values[index],
        colors[index],
      ),
    );
  }

  Widget _buildTraitCard(
    BuildContext context,
    String title,
    String description,
    double value,
    Color color,
  ) {
    return AuraTraitCard(
      title: title,
      description: description,
      value: value,
      color: color,
    );
  }
}
