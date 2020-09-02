
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_it_app/view_models/budget/home_model.dart';
import 'package:overlay_container/overlay_container.dart';


class PickMonthOverlay extends StatelessWidget {
  final HomeModel model;
  final BuildContext context;
  final bool showOrHide;

  const PickMonthOverlay({Key key, this.model, this.context, this.showOrHide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlayContainer(

        show: showOrHide,

        position: OverlayContainerPosition(
          // Left position.
          3,
          // Bottom position.
          0,
        ),
        // The content inside the overlay.
        child: Container(

          height: 200,

          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width/1.2,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Colors.white,



            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                spreadRadius: 10,
              ),
            ],
          ),
          child: buildGridView(model),
        ));
  }

  Widget buildGridView(HomeModel model) {
    return GridView.count(
      crossAxisCount: 6,

      // Generate 100 widgets that display their index in the List.
      children: model.months.map((month) {
        return InkWell(
          onTap: () {
            model.monthClicked(month);
          },
          child: Center(
            child: Text(
              month,
              style: TextStyle(
                color: model.getColor(month),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
