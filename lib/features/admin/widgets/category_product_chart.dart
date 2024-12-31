import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_amazon_clone/constants/color_extensions.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/admin/models/sales.dart';

class CategoryProductChart extends StatefulWidget {
  final List<Sales>? earnings;
  CategoryProductChart({super.key, required this.earnings});

  List<Color> get availableColors => const <Color>[
        GlobalVariables.contentColorPurple,
        GlobalVariables.contentColorYellow,
        GlobalVariables.contentColorBlue,
        GlobalVariables.contentColorOrange,
        GlobalVariables.contentColorPink,
        GlobalVariables.contentColorRed,
      ];

  final Color barBackgroundColor =
      GlobalVariables.contentColorWhite.darken().withValues(alpha: 0.3);
  final Color barColor = GlobalVariables.contentColorWhite;
  final Color touchedBarColor = GlobalVariables.contentColorYellow;

  @override
  State<StatefulWidget> createState() => CategoryProductChartState();
}

class CategoryProductChartState extends State<CategoryProductChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Earnings',
                  style: TextStyle(
                    color: GlobalVariables.contentColorGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Total Wise Earnings',
                  style: TextStyle(
                    color: GlobalVariables.contentColorGreen.darken(),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      mainBarData(),
                      duration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.darken(80))
              : const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(5, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, widget.earnings![0].amount.toDouble(), isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, widget.earnings![1].amount.toDouble(), isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, widget.earnings![2].amount.toDouble(), isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, widget.earnings![3].amount.toDouble(), isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, widget.earnings![4].amount.toDouble(), isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String category;
            switch (group.x) {
              case 0:
                category = widget.earnings![0].label;
                break;
              case 1:
                category = widget.earnings![1].label;
                break;
              case 2:
                category = widget.earnings![2].label;
                break;
              case 3:
                category = widget.earnings![3].label;
                break;
              case 4:
                category = widget.earnings![4].label;
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$category\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.white, //widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitlesLeft,
            reservedSize: 38,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 66, 26, 175),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('E', style: style);
        break;
      case 2:
        text = const Text('A', style: style);
        break;
      case 3:
        text = const Text('B', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget getTitlesLeft(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 66, 26, 175),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    if (value % 5 == 0) {
      text = Text(value.toInt().toString(), style: style);
    } else {
      text = const Text('', style: style);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: text,
    );
  }


  
}