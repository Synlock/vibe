import 'package:flutter/material.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/model/savedAlertsModel.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class SavedAlertsByCategory extends StatefulWidget {
  final CategoryData categoryData;
  const SavedAlertsByCategory({Key? key, required this.categoryData})
      : super(key: key);

  @override
  State<SavedAlertsByCategory> createState() => _SavedAlertsByCategoryState();
}

class _SavedAlertsByCategoryState extends State<SavedAlertsByCategory>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;

  List<Widget> allAlertBtns = <Widget>[];
  List<Widget> categoryAlertBtns = <Widget>[];
  @override
  void initState() {
    super.initState();

    _controller = TabController(initialIndex: 0, length: 2, vsync: this);
    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      try {
        final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
        print(json);
      } catch (e) {
        print(e);
      }
      removeButtonsFromPage(allAlertBtns, setState(() {}));
      addAlertsToPage(allAlertBtns, setState(() {}));

      findCategoryAlerts(categoryAlertBtns, widget.categoryData.categoryName);
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: savedAlertsAppBar(
          context,
          SAVED_ALERTS_BY_CATEGORY,
          upperTab(
            _controller!,
            widget.categoryData.categoryName + " " + CATEGORY,
          )),
      body: upperTabViews(_controller!, categoryAlertBtns, allAlertBtns),
      floatingActionButton: Transform.scale(
        scale: 1.15,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, NEW_ALERT_ROUTE);
          },
          backgroundColor: yellowColor,
          isExtended: true,
          child: Icon(
            Icons.add,
            color: indigoColor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
