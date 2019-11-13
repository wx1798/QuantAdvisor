import 'package:flutter/material.dart';
import 'package:uitest2/entityclass.dart';
import 'package:uitest2/sharedata.dart';

import 'StrategyBasic.dart';
import 'FactorList.dart';
import 'FactorFilterList.dart';
import 'sharedata.dart';
import 'sharedata.dart';
import 'webapihelper.dart';



///通过TabController 定义TabBar

class newStrategyPage extends StatefulWidget {

  newStrategyPage(){
    
    //清空新模型成员变量值
    SharedData.instance.ClearModelInfoEx4New(SharedData.instance.m_ModelInfoEx4New);

    SharedData.instance.ClearNewFactorData();
  }

  @override
  _newStrategyPageState createState() => _newStrategyPageState();
}

class _newStrategyPageState extends State<newStrategyPage> with SingleTickerProviderStateMixin{

  TabController m_tabController;

  @override
  void initState() {
    //print('初始化 数据...');
    m_tabController = new TabController(
        vsync: this,//固定写法
        length: 3   //指定tab长度
    );
    //添加监听
    m_tabController.addListener((){
      var index = m_tabController.index;
      var previousIndex = m_tabController.previousIndex;
      print("index: $index");
      print('previousIndex: $previousIndex');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('新建策略'),
            bottom: TabBar(
              controller: m_tabController,
              isScrollable: true,
              labelStyle: TextStyle(fontSize: 16.0,),
              tabs: <Widget>[
                Tab(text: '基本设置',),
                Tab(text: '打分设置',),
                Tab(text: '筛选设置',),
              ],
            ),
          ),

        body: new TabBarView_StrategyBasic(m_tabController),

        bottomNavigationBar: BottomNavigationBar( // 底部导航
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.save), title: Text('保存并退出')),
              BottomNavigationBarItem(icon: Icon(Icons.cancel), title: Text('放弃新建')),
              
            ],

            onTap:  (index) {
              //保存新模型
              WebAPIHelper.instance.SaveModelInfo(SharedData.instance.m_ModelInfoEx4New);

              //返回到调用页面
              Navigator.pop(context,true);
            }

          ),
        ),
      );
  }
}

class TabBarView_StrategyBasic extends StatelessWidget
{
  TabController m_tabController;
  ModelInfoEx m_ModelInfo = new ModelInfoEx();

  TabBarView_StrategyBasic(TabController tabControl)
  {
    m_tabController = tabControl;
  }

  @override
  Widget build(BuildContext context)
  {
    return new TabBarView(
            controller: m_tabController,
            children: <Widget>[
              Container(
                color: Color(0xffffffff),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(8),
                child: new StrategyBasic(m_ModelInfo,true),
              ),
              Container(
                color: Color(0xffffffff),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(8),
                child: new FactorList(this.m_ModelInfo,true),
              ),
              Container(
                color: Color(0xffffffff),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(8),
                child: new FactorFilterList(m_ModelInfo,true),
              ),
              
            ],
          );
  }
}

