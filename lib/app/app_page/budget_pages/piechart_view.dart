import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:list_it_app/common_widget/page_avatar.dart';
import 'package:list_it_app/services/budget/budget_base_page.dart';
import 'package:list_it_app/services/budget/enums/budget_page_state.dart';
import 'package:list_it_app/view_models/budget/piechart_model.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({Key key}) : super(key: key);

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
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xFFA30003),
                ),
              ),
              width: double.infinity,
              height: double.infinity,
              child: model.state == BudgetPageState.Busy
                  ? CircularProgressIndicator()
                  : SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(height: 40),
                          Text(
                            'Chart',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 30),
                          ),
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
                                : PieChart(dataMap: model.dataMap),
                          ),
                        ],
                      ),
                    ),
            ),
           PageAvatar(),
          ],
        ),
      ),
    );
  }
}
