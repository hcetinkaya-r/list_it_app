import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:list_it_app/services/budget/budget_base_page.dart';
import 'package:list_it_app/services/budget/enums/budget_page_state.dart';
import 'package:list_it_app/view_models/budget/piechart_model.dart';
import 'package:pie_chart/pie_chart.dart';


class ChartDialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BudgetBasePage<PieChartModel>(
      onModelReady: (model) => model.init(true),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFFA30003)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: model.state == BudgetPageState.Busy
            ? CircularProgressIndicator()
            : SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'Budget Chart',
                      style: TextStyle(color: Colors.black54, fontSize: 30),
                    ),
                    SizedBox(height: 20),

                    ChipsChoice<int>.single(
                      itemConfig: ChipsChoiceItemConfig(
                          elevation: 3, selectedColor: Color(0xFFA30003)),
                      value: model.selectedMonthIndex,
                      isWrapped: true,
                      options: ChipsChoiceOption.listFrom<int, String>(
                        source: model.months,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                      onChanged: (val) => model.changeSelectedMonth(val),
                    ),
                    ChipsChoice<int>.single(
                      itemConfig: ChipsChoiceItemConfig(
                          elevation: 1, selectedColor: Color(0xFFA30003)),
                      value: model.type == 'income' ? 0 : 1,
                      isWrapped: true,
                      options: ChipsChoiceOption.listFrom<int, String>(
                        source: model.types,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                      onChanged: (val) => model.changeType(val),
                    ),
                    Container(
                      child: model.dataMap.length == 0
                          ? Text('No Data for this month')
                          : PieChart(dataMap: model.dataMap, chartLegendSpacing: 35),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
