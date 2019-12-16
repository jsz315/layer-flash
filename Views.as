import com.greensock.*;
import com.greensock.easing.*;
import flash.filters.GlowFilter;


class Views
{
	public var showPotArr:Array;
	public var hidePotArr:Array;
	public var mcArr:Array;
	public var filter:GlowFilter;
	
	public function Views()
	{
		trace("view init");
		var color:Number = 0x0;
		var alpha:Number = 0.8;
		var blurX:Number = 40;
		var blurY:Number = 40;
		var strength:Number = 2;
		var quality:Number = 3;
		var inner:Boolean = true;
		var knockout:Boolean = false;

		filter = new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
	}

	//显示登陆界面
	public function system_login()
	{
		_root.pannel_mc.attachMovie("sysLoginMC","sysLoginMC",1);
		//_root.pannel_mc.sysLoginMC._x = 1920 / 2;
		//_root.pannel_mc.sysLoginMC._y = 1080 / 2;
	}

	//请求楼层
	public function show_layer(n:String)
	{
		Datas.layer = n;
		trace("切换楼层：" + n);

		_root.callFuns.init_layer();
		/*
		var layerData:LayerData = Tool.getLayerData(Datas.layer);
		if (layerData.bmd == undefined) {
			Tool.load(layerData.url);
		}else {
			trace("使用内存数据");
			_root.map_mc.attachBitmap(layerData.bmd, 1);
			_root.delay_mc.gotoAndPlay("map");
		}
		*/
	}

	//显示楼层
	public function display_layer(){
		var layerData:LayerData = Tool.getLayerData(Datas.layer);
		if (layerData.bmd == undefined) {
			Tool.load(layerData.url);
		}else {
			trace("使用内存数据");
			_root.map_mc.attachBitmap(layerData.bmd, 1);
			_root.delay_mc.gotoAndPlay("map");
		}
	}

	//设置楼层面板
	public function menu_level()
	{
		_root.pannel_mc.attachMovie("setLevelMC","setLevelMC",1);
		set_center(_root.pannel_mc.setLevelMC);
	}

	//矩阵键盘
	public function menu_jzkeyBoard()
	{
		_root.pannel_mc.attachMovie("jzkeyBoardMC","jzkeyBoardMC",1);
		set_center(_root.pannel_mc.jzkeyBoardMC);
	}

	//查询界面
	public function menu_searchBoard()
	{
		_root.pannel_mc.attachMovie("searchBoardMC","searchBoardMC",1);
		set_center(_root.pannel_mc.searchBoardMC);
	}

	//布防密码框
	public function menu_defencePsw(str:String)
	{
		Datas.area = str;
		_root.pannel_mc.attachMovie("defencePswMC","defencePswMC",1);
		set_center(_root.pannel_mc.defencePswMC);
	}

	//显示布防界面
	public function show_Alarm()
	{
		if (Datas.area == "s")
		{
			_root.pannel_mc.attachMovie("areaAlarmMC","areaAlarmMC",1);
			set_center(_root.pannel_mc.areaAlarmMC);
		}
		else
		{
			_root.pannel_mc.attachMovie("sysAlarmMC","sysAlarmMC",1);
			set_center(_root.pannel_mc.sysAlarmMC);
		}
	}

	//显示开门信息
	public function door_listener(str:String)
	{
		_root.warn_mc.attachMovie("carDoorMC","carDoorMC",1);
		set_center(_root.warn_mc.carDoorMC);
		Datas.openDoorInfo = str;
	}

	//退出系统
	public function quit_system()
	{
		_root.warn_mc.attachMovie("logoutMC","logoutMC",1);
		set_center(_root.warn_mc.logoutMC);
	}

	//添加元件
	public function add_mc(str:String)
	{
		var n = _root.contain_mc.getNextHighestDepth();
		trace(str +"________" + n);
		var mc = _root.contain_mc.attachMovie(str + "_mc", str +"_" + n, n);
		
		Datas.mcAry.push(mc);
		
		return mc;
	}

	//删除元件
	public function remove_mc(all:Boolean)
	{
		for (var i = 0; i < Datas.mcAry.length; i++)
		{
			if (all)
			{
				Datas.mcAry[i].removeMovieClip();
			}
			else
			{
				if (Datas.mcAry[i] == Datas.mc)
				{
					Datas.mcAry.splice(i,1);
					Datas.mc.removeMovieClip();
					return;
				}
			}
		}
		if (all)
		{
			Datas.mcAry = [];
		}
	}

	//元件点击处理
	public function clicks()
	{
		if (Datas.edit)
		{
			if (Datas.isDoubleClick)
			{
				show_rotation();
			}
			else
			{
				hide_rotation();
			}
		}
		else
		{
			if (Datas.isDoubleClick)
			{
				show_cameraConfig();
			}
			else
			{
				trace("直接切换监视器");
				hide_cameraConfig();
			}
		}
	}

	//设置角度
	public function set_rotation(n)
	{
		Datas.mc.gotoAndStop(n);
		hide_rotation();
	}

	//隐藏角度重置界面
	public function hide_rotation()
	{
		_root.rotation_mc._x = -400;
		_root.rotation_mc._y = -400;
	}

	//显示角度重置界面
	public function show_rotation()
	{
		_root.rotation_mc._x = Datas.mc._x + 30;
		_root.rotation_mc._y = Datas.mc._y - 60;
		
		if (_root.rotation_mc._x + _root.rotation_mc._width + 10 > 1920)
		{
			_root.rotation_mc._x -= 172;
		}
		
		if (_root.rotation_mc._y < 10) {
			_root.rotation_mc._y = 10;
		}else if (_root.rotation_mc._y + _root.rotation_mc._height + 10 > 1080) {
			_root.rotation_mc._y = 1070 - _root.rotation_mc._height;
		}
		
		set_cartoon(_root.rotation_mc);

	}

	//隐藏摄像头配置
	public function hide_cameraConfig()
	{
		_root.cameraConfig_mc._x = -1000;
		_root.cameraConfig_mc._y = -1000;
		_root.cameraConfig_mc.reset();
	}

	//显示摄像头配置
	public function show_cameraConfig()
	{
		_root.cameraConfig_mc._x = Datas.mc._x + 30;
		_root.cameraConfig_mc._y = Datas.mc._y - 200;
		
		if (_root.cameraConfig_mc._x + _root.cameraConfig_mc._width + 10 > 1920)
		{
			_root.cameraConfig_mc._x -= 666;
		}
		
		if (_root.cameraConfig_mc._y < 10) {
			_root.cameraConfig_mc._y = 10;
		}else if (_root.cameraConfig_mc._y + _root.cameraConfig_mc._height + 10 > 1080) {
			_root.cameraConfig_mc._y = 1070 - _root.cameraConfig_mc._height;
		}
		
		set_cartoon(_root.cameraConfig_mc);
	}
	
	//全区布防
	public function layer_warn():Void
	{
		Datas.isDefence = true;
		
		_root.bulidAlerm_mc.gotoAndStop(1);
		for (var i = 0; i < Datas.mcAry.length; i++)
		{
			var type:String = Datas.mcAry[i]._name.split("_")[0];
			
			if (type == "alarm")
			{
				Datas.mcAry[i].setWarn(1);
			}
			if (type == "homeAlarm")
			{
				Datas.mcAry[i].setWarn(1);
			}
		}
		
		for (var i = 0; i < Datas.layerDataAry.length; i++)
		{
			var layerData:LayerData = Datas.layerDataAry[i];
			for (var obj in layerData.alarmAry)
			{
				layerData.alarmAry[obj].status = 1;
			}
		}
	}
	
	//全区撤防
	public function clear_warn()
	{
		Datas.isDefence = false;
		
		_root.bulidAlerm_mc.gotoAndStop(1);
		for (var i = 0; i < Datas.mcAry.length; i++)
		{
			var type:String = Datas.mcAry[i]._name.split("_")[0];
			
			if (type == "alarm")
			{
				Datas.mcAry[i].setWarn(0);
			}
			if (type == "homeAlarm")
			{
				Datas.mcAry[i].setWarn(0);
			}
		}
		
		for (var i = 0; i < Datas.layerDataAry.length; i++)
		{
			var layerData:LayerData = Datas.layerDataAry[i];
			for (var obj in  layerData.alarmAry)
			{
				layerData.alarmAry[obj].status = 0;
			}
		}		
		
	}

	//居中显示
	public function set_center(mc:MovieClip)
	{
		mc._x = 1920 / 2;
		mc._y = 1080 / 2;
		set_cartoon(mc);
	}
	
	//设置动画
	public function set_cartoon(mc:MovieClip)
	{
		TweenLite.from(mc, 0.7, { _alpha:0, _y:mc._y + 70, ease:Back.easeInOut } );
	}
	
	//显示动画
	public function show_mc(mc:MovieClip, px:Number, py:Number)
	{
		mc._x = px;
		mc._y = py - 500;
		TweenLite.to(mc, 0.7, { _x:px, _y:py, ease:Back.easeInOut } );
	}
	
	//移动元件
	public function move_mc(mc:MovieClip, y:Number)
	{
		TweenLite.to(mc, 0.7, { _y:y, ease:Back.easeInOut } );
	}
	
	//移动元件
	public function levelMove_mc(mc:MovieClip, x:Number)
	{
		TweenLite.to(mc, 0.7, { _x:x, ease:Back.easeInOut } );
	}
	
	//初始化位置
	public function initConfigView()
	{
		mcArr = [];
		showPotArr = [];
		hidePotArr = [];
		
		mcArr.push(_root.camera0_mc);
		mcArr.push(_root.camera1_mc);
		mcArr.push(_root.camera2_mc);
		mcArr.push(_root.camera3_mc);
		mcArr.push(_root.camera4_mc);
		mcArr.push(_root.camera5_mc);
		mcArr.push(_root.camera6_mc);
		mcArr.push(_root.barrier_mc);
		mcArr.push(_root.door_mc);
		mcArr.push(_root.alarm_mc);
		mcArr.push(_root.homeAlarm_mc);
		mcArr.push(_root.config_btn);
		
		for (var i = 0; i < mcArr.length; i++)
		{
			showPotArr.push(mcArr[i]._x);
			hidePotArr.push(mcArr[i]._x - 700);			
		}		
	}
	
	//显示控制元件
	public function showConfigs(b:Boolean)
	{
		for (var i = 0; i < mcArr.length; i++)
		{
			if (b)
			{				
				levelMove_mc(mcArr[i], showPotArr[i]);
			}
			else
			{
				levelMove_mc(mcArr[i], hidePotArr[i]);
			}
		}
		
	}
	
	//伸缩面板
	public function displayPanel(mc, startpot, endpot){
		mc.show_btn.onPress = function()
		{
			if (mc._x != endpot)
			{
				_root.views.levelMove_mc(mc, endpot);
			}
			else
			{
				_root.views.levelMove_mc(mc, startpot);
			}
		};
	}
	
	//切换显示状态
	public function changeState(key, mc){
		if (Datas[key + "Ary"].length > 0)
		{
			mc.filters = [];
			mc.enabled = true;
		}
		else
		{
			mc.filters = [_root.filter];
			mc.enabled = false;
		}
	}
	
	//显示报警器状态
	public function showAlarm(mc, type)
	{
		mc.filters = [_root.filter];
		mc.enabled = false;
		for (var i = 0; i < Datas.alarmAry.length; i++)
		{
			if (Datas.alarmAry[i].term_type == type)
			{
				mc.filters = [];
				mc.enabled = true;
			}
		}
	}
	
	//显示添加面板
	public function showAddItem(){
		for (var i = 0; i < 7; i++){
			_root.views.changeState("camera" + i, _root.thing_mc["camera" + i + "_mc"]);
		}
		_root.views.changeState("barrier", _root.thing_mc.barrier_mc);
		_root.views.changeState("door", _root.thing_mc.door_mc);
		_root.views.showAlarm(_root.thing_mc.alarm_mc, 0);
		_root.views.showAlarm(_root.thing_mc.homeAlarm_mc, 1);
	}
	
	//显示切换
	public function filterObject(){
		var list = "xiaofang-tingche-paishui-huanjing-shebei-kongtiao-zhaoming-anfang".split("-");
		for (var i = 0; i < list.length; i++){
			_root.filter_mc.views[list[i]].gotoAndStop(1);
			_root.filter_mc.views[list[i]].onPress = function(){
				Datas.filter = this._name;
				_root.views.filterShow();
				for (var i = 0; i < list.length; i++){
					_root.filter_mc.views[list[i]].gotoAndStop(8);
				}
				this.gotoAndStop(1);
			}
		}
		
	}
	
	//显示开关状态自动
	public function showViewState(mc, a1, a2, a3){
		mc.auto_txt.text = a1 == 0 ? "正常" : "故障";
		mc.state_txt.text = a2 == 0 ? "手动" : "自动";
		if (a3 == 0){
			mc.togger_btn.gotoAndPlay("open");
		}
		else{
			mc.togger_btn.gotoAndPlay("close");
		}
	}
	
	//过滤显示
	public function filterShow(){
		trace("filterShow");
		var obj = {};
		obj.anfang = "camera0-camera1-camera2-camera3-camera4-camera5-camera6-alarm-homeAlarm-door-barrier";
		obj.huanjing = "co-co2-pm-wendu-shidu-kongqi-paifengji-songfengji";
		obj.kongtiao = "kongtiao-fenglengre-jizu-jiaohuan";
		obj.paishui = "yali-liuliang-shuixiang-paishui-shuibeng";
		obj.zhaoming = "zhaoming-guangzhao";
		obj.shebei = "dianti";
		var aim = obj[Datas.filter] || "";
		for (var i = 0; i < Datas.mcAry.length; i++)
		{
			var t = Datas.mcAry[i]._name.split("_")[0];
			trace(Datas.mcAry[i]._name + " - " + t);
			if (aim.indexOf(t) == -1){
				Datas.mcAry[i]._visible = false;
			}
			else{
				Datas.mcAry[i]._visible = true;
			}
		}
	}
	
	//初始化面板
	public function initPanels(){
		displayPanel(_root.mens_mc, -84, -540);
		displayPanel(_root.filter_mc, 1760, 1876);
		displayPanel(_root.thing_mc, 3, -718);
		displayPanel(_root.bm_mc, 3, -658);
		displayPanel(_root.machine_mc, 3, -1077);
		
		filterObject();
		
		for (var i = 0; i < 7; i++){
			_root.thing_mc["camera" + i + "_mc"].onPress = function()
			{
				var num = this._name.split("_")[0].substr( -1);
				if (Datas["camera" + num + "Ary"].length > 0)
				{
					var mc = Datas["camera" + num + "Ary"].shift();
					_root.views.show_mc(mc, _root["camera" + num + "_pot"]._x, _root["camera" + num + "_pot"]._y);
				}
				_root.views.changeState("camera" + num, this);
			};
		}
		
		_root.thing_mc.barrier_mc.onPress = function()
		{
			if (Datas.barrierAry.length > 0)
			{		
				_root.views.show_mc(Datas.barrierAry.shift(),_root.barrier_pot._x,_root.barrier_pot._y);
			}
			_root.views.changeState("barrier", this);
		};
		
		_root.thing_mc.door_mc.onPress = function()
		{
			if (Datas.doorAry.length > 0)
			{
				_root.views.show_mc(Datas.doorAry.shift(),_root.door_pot._x,_root.door_pot._y);
			}
			_root.views.changeState("door", this);
		};
		
		_root.thing_mc.alarm_mc.onPress = function()
		{
			for (var i = 0; i < Datas.alarmAry.length; i++)
			{
				if (Datas.alarmAry[i].term_type == 0)
				{
					//var mc = Datas.alarmAry[i];									
					var mc = Datas.alarmAry.splice(i, 1);
					_root.views.show_mc(mc,_root.alarm_pot._x,_root.alarm_pot._y);
					break;
				}
			}
			_root.views.showAlarm(this, 0);
		};
		
		_root.thing_mc.homeAlarm_mc.onPress = function()
		{
			for (var i = 0; i < Datas.alarmAry.length; i++)
			{
				if (Datas.alarmAry[i].term_type == 1)
				{
					//var mc = Datas.alarmAry[i];									
					var mc = Datas.alarmAry.splice(i, 1);
					_root.views.show_mc(mc,_root.homeAlarm_pot._x,_root.homeAlarm_pot._y);						
					break;
				}
			}
			_root.views.showAlarm(this, 1);
		};
		
		var bmAry = "wendu-pm-co-co2-liuliang-shidu-yali-kongqi".split("-");
		for (var i = 0; i < bmAry.length; i++)
		{
			_root.bm_mc[bmAry[i] + "_mc"].onPress = function(){
				var key = this._name.split("_")[0];
				trace(key);
				var list = Datas[key + "Ary"];
				if (list.length > 0)
				{
					trace(this);
					trace(this._x + "," + this._y);
					var mc = list.shift();
					trace(mc);
					trace(mc._width);
					_root.views.show_mc(mc,this._x + this._width / 2 - mc._width / 2,this._y + 270);
				}
				_root.views.changeState(key, this);
			}
		}
		
		var machineAry = "dianti-fenglengre-paifengji-songfengji-jiaohuan-shuibeng-kongtiao-shuixiang-paishui-jizu-zhaoming-dengguan-guangzhao".split("-");
		for (var i = 0; i < machineAry.length; i++)
		{
			_root.machine_mc[machineAry[i] + "_mc"].onPress = function(){
				var key = this._name.split("_")[0];
				trace(key);
				var list = Datas[key + "Ary"];
				if (list.length > 0)
				{
					var mc = list.shift();
					_root.views.show_mc(mc,this._x + this._width / 2 - mc._width / 2,this._y + 540);
				}
				_root.views.changeState(key, this);
			}
			
			if (_root.machine_mc[machineAry[i] + "_mc"].mc.minView){
				_root.machine_mc[machineAry[i] + "_mc"].mc.minView(false);
			}
		}
		
		if (Datas.edit) {
			_root.views.showAddItem();
		}
	}
}