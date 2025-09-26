import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RevenueChart extends StatelessWidget {
  final List<double> filingFee;
  final List<double> serviceFee;
  final List<String> labels;
  final double maxY;
  final double height;
  final Color filingColor;
  final Color serviceColor;
  final Color tooltipBorderColor;
  final Color tooltipBgColor;

  const RevenueChart({
    super.key,
    required this.filingFee,
    required this.serviceFee,
    required this.labels,
    required this.maxY,
    required this.height,
    this.filingColor = Colors.amber,
    this.serviceColor = const Color(0xFF333333),
    this.tooltipBorderColor = Colors.blue,
    this.tooltipBgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  final validValues = List.generate(
                    (maxY ~/ 10) + 1,
                        (i) => i * 10,
                  );
                  if (validValues.contains(value.toInt())) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < labels.length) {
                    return Text(
                      labels[index],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          barGroups: List.generate(filingFee.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: filingFee[index],
                  color: filingColor,
                  width: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                BarChartRodData(
                  toY: serviceFee[index],
                  color: serviceColor,
                  width: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
              barsSpace: 6,
            );
          }),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              tooltipMargin: 8,
              tooltipRoundedRadius: 12,
              tooltipBorder: BorderSide(
                color: tooltipBorderColor,
                width: 1,
              ),
              getTooltipColor: (BarChartGroupData group) => tooltipBgColor,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '\$${rod.toY.toStringAsFixed(0)}',
                  TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
