import 'package:flutter/material.dart';
import 'package:flutter_app_todo/blocs/todoBloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TagAddPage extends StatefulWidget {
  _TagAddPage createState() => _TagAddPage();
}

class _TagAddPage extends State<TagAddPage> {
  TodoBloc _todoBloc;
  TextEditingController tagNameController;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoBloc = BlocProvider.of<TodoBloc>(context);
    tagNameController = TextEditingController();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Tag"),
      ),
      body: BlocListener(
        bloc: _todoBloc,
        listener: (BuildContext context, TodoState state) {},
        child: BlocBuilder(
          bloc: _todoBloc,
          builder: (BuildContext context, TodoState state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
              child: Column(
                children: <Widget>[
                  Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '태그',
                        style: Theme.of(context).textTheme.display1,
                      )),
                  TextField(
                    decoration: InputDecoration(hintText: '태그의 이름을 입력해 주세요'),
                    controller: tagNameController,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '색깔',
                        style: Theme.of(context).textTheme.display1,
                      )),
                  ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: changeColor,
                    showLabel: true,
                    pickerAreaHeightPercent: 0.8,
                  ),
                  Container(
                    height: 55,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.tagList.length,
                      itemBuilder: (context, index) {
                        return _circleTag(
                            state,
                            Color.fromARGB(
                              state.tagList[index].color[3],
                              state.tagList[index].color[0],
                              state.tagList[index].color[1],
                              state.tagList[index].color[2],
                            ),
                            state.tagList[index].id);
                      },
                    ),
                  ),
                  OutlineButton(
                    onPressed: () {
                      _todoBloc.add(TagColorCompleted(
                        id: "",
                        color: [
                          pickerColor.red,
                          pickerColor.green,
                          pickerColor.blue,
                          pickerColor.alpha,
                        ],
                        tagName: tagNameController.text,
                      ));
//                      Navigator.pop(context);
                    },
                    borderSide: BorderSide(color: Colors.white),
                    child: Text('Complete'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget colorPicker() {
    return SingleChildScrollView(
      child: ColorPicker(
        pickerColor: pickerColor,
        onColorChanged: changeColor,
        showLabel: true,
        pickerAreaHeightPercent: 0.8,
      ),
    );
  }

  void showColorPicker() async {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _circleTag(TodoState state, Color color, String id) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
