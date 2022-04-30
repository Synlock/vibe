import 'package:flutter/material.dart';
import 'package:vibe/misc/commonCalls.dart';
import 'package:vibe/misc/tags.dart';
import 'package:vibe/styles/appBar.dart';
import 'package:vibe/styles/styles.dart';
import 'package:vibe/view/newCategoryPopupView.dart';
import 'package:vibe/viewmodel/savedAlertsViewModel.dart';

class SavedAlerts extends StatefulWidget {
  final int initialIndex;
  const SavedAlerts({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<SavedAlerts> createState() => _SavedAlertsState();
}

class _SavedAlertsState extends State<SavedAlerts>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 1;

  List<Widget> alertBtns = <Widget>[];
  List<Widget> categoryBtns = <Widget>[];
  @override
  void initState() {
    super.initState();
    //init tab controller to get access to page index
    _controller = TabController(
        initialIndex: widget.initialIndex, length: 2, vsync: this);
    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
    //make sure that floating button works properly on each page
    _controller!.index == 0 ? _selectedIndex = 0 : _selectedIndex = 1;

    //remove and add the buttons to properly show the updated buttons from the content
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final json = await getDecodedJson(ALERTS_JSON_FILE_NAME);
      print("${json.length} alerts in list");
      removeButtonsFromPage(alertBtns, setState(() {}));
      addAlertsToPage(alertBtns, setState(() {}));

      removeButtonsFromPage(categoryBtns, setState(() {}));
      addCategoriesToPage(categoryBtns, setState(() {}));
    });
  }

  void showAddCategoryBox() async {
    var navigationResult = await showDialog(
        context: context,
        builder: (context) {
          return const AddCategoryBox();
        });
    if (navigationResult == null) {
      setState(() {
        removeButtonsFromPage(categoryBtns, setState(() {}));
        addCategoriesToPage(categoryBtns, setState(() {}));
      });
    }
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
          SAVED_ALERTS,
          upperTab(
            _controller!,
            CATEGORIES_UI,
          )),
      body: upperTabViews(_controller!, categoryBtns, alertBtns),
      floatingActionButton: Transform.scale(
        scale: 1.15,
        child: FloatingActionButton(
          onPressed: _selectedIndex == 1
              ?
              //if on "All" tab, move to add new alert
              () {
                  Navigator.popAndPushNamed(context, NEW_ALERT_ROUTE);
                }
              :
              //if on "Categories" tab, move to add new category
              () {
                  showAddCategoryBox();
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
