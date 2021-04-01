import 'package:flutter/material.dart';
import 'package:flutter_app_todo/blocs/todoBloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TagDelete extends StatefulWidget {
  _TagDelete createState() => _TagDelete();
}

class _TagDelete extends State<TagDelete> {
  TodoBloc _todoBloc;
  TextEditingController newTag = TextEditingController();

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoBloc = BlocProvider.of<TodoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener(
      bloc: _todoBloc,
      listener: (context, state) {},
      child: BlocBuilder(
        bloc: _todoBloc,
        builder: (context, TodoState state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1.3,
              title: Text('태그 설정'),
              actions: <Widget>[],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
//                  _todoBloc.add(TagPagePop());
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: state.tagList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: <Widget>[
                            _circleTag(
                                state,
                                Color.fromARGB(
                                  state.tagList[index].color[3],
                                  state.tagList[index].color[0],
                                  state.tagList[index].color[1],
                                  state.tagList[index].color[2],
                                ),
                                state.tagList[index].id),
                            Flexible(
                              child: Text(
                                state.tagList[index].tagName.toString(),
                                style: TextStyle(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              print(state.tagList[index].id);
                              confirmMessage(state, index);
                            }),
                        onTap: () {
                          _tagAddDialog(state, state.tagList[index].id, index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _circleTag(TodoState state, Color color, String id) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: InkResponse(
        onTap: () {
          _todoBloc.add(TodoIdChanged(id: id));
        },
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: state.id == id
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 35,
                )
              : null,
        ),
      ),
    );
  }

  void confirmMessage(TodoState state, int index) {
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text('태그를 삭제하시겠습니까?'),
          content: Text('태그를 삭제하시면 해당 태그와 관련된 데이터가 모두 지워집니다.'),
          actions: <Widget>[
            FlatButton(
              child: const Text(
                '취소하기',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text(
                '예',
              ),
              onPressed: () {
                _todoBloc.add(TagDeleted(id: state.tagList[index].id));
//                _todoBloc.add(TagDeleteDone());
                print("--------------------");
                print(state.selectedList);
                _todoBloc.add(TodoPageLoaded());
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  void _tagAddDialog(TodoState state, String id, int index) async {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('태그 수정'),
        content: Container(
          width: double.maxFinite,
          height: 380,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextField(
                      decoration: InputDecoration(hintText: '태그의 이름을 설정해주세요'),
                      controller: newTag,
                    ),
                  ),
                  SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: pickerColor,
                      onColorChanged: changeColor,
                      showLabel: false,
                      pickerAreaHeightPercent: 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              '취소하기',
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('완료'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              _todoBloc.add(TagEditComplete(
                id: id,
                color: [
                  pickerColor.red,
                  pickerColor.green,
                  pickerColor.blue,
                  pickerColor.alpha,
                ],
                tagName: newTag.text == "" ? "무제" : newTag.text,
                index: index,
              ));
              newTag = TextEditingController();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
