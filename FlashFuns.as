import flash.external.ExternalInterface;

class FlashFuns
{

	public function FlashFuns()
	{
		trace("flash fun init");
		
		ExternalInterface.addCallback("check_login", this, Fcheck_login);
		ExternalInterface.addCallback("init_data", this, Finit_data);		
		ExternalInterface.addCallback("search_info", this, Fsearch_info);		
		ExternalInterface.addCallback("check_defencePsw", this, Fcheck_defencePsw);		
		ExternalInterface.addCallback("door_listener", this, Fdoor_listener);		
		ExternalInterface.addCallback("start_warn", this, Fstart_warn);
		ExternalInterface.addCallback("stop_warn", this, Fstop_warn);
		
		ExternalInterface.addCallback("openthedoor",this,Fopenthedoor);
		ExternalInterface.addCallback("closethedoor", this, Fclosethedoor);
		
		ExternalInterface.addCallback("openthebarrier",this,Fopenthebarrier);
		ExternalInterface.addCallback("closethebarrier", this, Fclosethebarrier);
		
		ExternalInterface.addCallback("collection_disply", this, Fcollection_disply);
		ExternalInterface.addCallback("Temp_Ctrl", this, FTemp_Ctrl);
		ExternalInterface.addCallback("Heat_Pump_State", this, FHeat_Pump_State);
		ExternalInterface.addCallback("Air_Conditioning_State", this, FAir_Conditioning_State);
		
		ExternalInterface.addCallback("Air_Exhaus_State", this, FAir_Exhaus_State);
		ExternalInterface.addCallback("Fan_State", this, FFan_State);
		ExternalInterface.addCallback("Drainage_Pump_State", this, FDrainage_Pump_State);
		ExternalInterface.addCallback("Wind_Switch_State", this, FWind_Switch_State);
		ExternalInterface.addCallback("Water_Pump_State", this, FWater_Pump_State);
		
		ExternalInterface.addCallback("Lighting_Lamps_State", this, FLighting_Lamps_State);
		ExternalInterface.addCallback("Elevator_State", this, FElevator_State);
		ExternalInterface.addCallback("Lighting_Ctrl_State", this, FLighting_Ctrl_State);
	}
	
	//照明控制面板
	public function FLighting_Ctrl_State(str:String)
	{
		//设备类型#设备号#1通道故障状态#1通道手自动状态#1通道运行状态#......4通道故障状态#4通道手自动状态#4通道运行状态#
		var ary = str.split("#");	
		var key = "guangzhao";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure_1 = ary[2];
		obj.auto_1 = ary[3];
		obj.run_1 = ary[4];
		
		obj.failure_2 = ary[5];
		obj.auto_2 = ary[6];
		obj.run_2 = ary[7];
		
		obj.failure_3 = ary[8];
		obj.auto_3 = ary[9];
		obj.run_3 = ary[10];
		
		obj.failure_4 = ary[11];
		obj.auto_4 = ary[12];
		obj.run_4 = ary[13];
		
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetGuangzhao(mc, obj);
			}
		}
	}
	
	//电梯
	public function FElevator_State(str:String)
	{
		//设备类型#设备号#故障状态#手自动状态#运行状态#楼层号#
		var ary = str.split("#");	
		var key = "dianti";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure = ary[2];
		obj.auto = ary[3];
		obj.run = ary[4];
		obj.floor_num = ary[5];
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetDianti(mc, obj);
				//return true;
			}
		}
	}
	
	//照明灯具
	public function FLighting_Lamps_State(str:String)
	{
		//设备类型#设备号#故障状态#手自动状态#运行状态#
		//1#8#1#1#1#
		var ary = str.split("#");	
		var key = "zhaoming";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure = ary[2];
		obj.auto = ary[3];
		obj.run = ary[4];
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetCommState(mc, obj);
				if (obj.run == 1){
					mc.light_mc.gotoAndStop(2);
				}
				else{
					mc.light_mc.gotoAndStop(1);
				}
				//return true;
			}
		}
	}
	
	//水泵
	public function FWater_Pump_State(str:String)
	{
		//设备类型#设备号#故障状态#手自动状态#运行状态#
		var ary = str.split("#");	
		var key = "shuibeng";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure = ary[2];
		obj.auto = ary[3];
		obj.run = ary[4];
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetCommState(mc, obj);
				//return true;
			}
		}
	}
	
	//全热新风交换机
	public function FWind_Switch_State(str:String)
	{
		//设备类型#设备号#故障状态#手自动状态#运行状态#
		var ary = str.split("#");	
		var key = "jiaohuan";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure = ary[2];
		obj.auto = ary[3];
		obj.run = ary[4];
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				//_root.views(mc, ary[2], ary[3], ary[4]);
				_root.game.resetCommState(mc, obj);
				//return true;
			}
		}
	}
	
	//排水泵
	public function FDrainage_Pump_State(str:String)
	{
		//FDrainage_Pump_State
		//0#5#1#1#1#1#0#0#0#
		//设备类型#设备号#水位报警#1通道故障状态#1通道手自动状态#1通道运行状态#2通道故障状态#2通道手自动状态#2通道运行状态#
		var ary = str.split("#");
		var key = "paishui";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.num = ary[2];
		obj.failure_1 = ary[3];
		obj.auto_1 = ary[4];
		obj.run_1 = ary[5];
		obj.failure_2 = ary[6];
		obj.auto_2 = ary[7];
		obj.run_2 = ary[8];
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetPaishui(mc, obj);
				//return true;
			}
		}
	}
	
	//排风机
	public function FAir_Exhaus_State(str:String)
	{
		//设备类型#设备号#故障状态#手自动状态#运行状态#
		var ary = str.split("#");
		var key = "paifengji";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure = ary[2];
		obj.auto = ary[3];
		obj.run = ary[4];
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetCommState(mc, obj);
				//return true;
			}
		}
	}
	
	//送风机
	public function FFan_State(str:String)
	{
		//设备类型#设备号#故障状态#手自动状态#运行状态#
		var ary = str.split("#");
		var key = "songfengji";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure = ary[2];
		obj.auto = ary[3];
		obj.run = ary[4];
		Tool.showObject(obj);
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetCommState(mc, obj);
				//return true;
			}
		}
	}
	
	//空调机组
	public function FAir_Conditioning_State(str:String)
	{
		//设备类型#设备号#故障状态#手自动状态#运行状态#
		var ary = str.split("#");	
		var key = "jizu";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure = ary[2];
		obj.auto = ary[3];
		obj.run = ary[4];
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetCommState(mc, obj);
				//return true;
			}
		}
	}
	
	//风冷热泵
	public function FHeat_Pump_State(str:String)
	{
		//设备类型#设备号#故障状态#手自动状态#运行状态#
		var ary = str.split("#");	
		var key = "fenglengre";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure = ary[2];
		obj.auto = ary[3];
		obj.run = ary[4];
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetCommState(mc, obj);
				//return true;
			}
		}
	}
	
	//温控面板
	public function FTemp_Ctrl(str:String)
	{
		//设备类型#设备号#故障状态#手自动状态#运行状态#模式#风速#设定温度#实际温度#
		var ary = str.split("#");	
		var key = "kongtiao";
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.failure = ary[2];
		obj.auto = ary[3];
		obj.run = ary[4];
		obj.mode = ary[5];
		obj.fan_speed = ary[6];
		obj.set_temp = ary[7];
		obj.room_temp = ary[8];
		if (obj.layer == Datas.layer){
			var mc = Tool.getMcById(ary[1], key);
			if (mc == null) {
				//return false;
			}else {
				_root.game.resetKongtiao(mc, obj);
				//return true;
			}
		}
	}
	
	//采集量显示部分
	public function Fcollection_disply(str:String)
	{
		//设备类型#设备号#采集量
		var ary = str.split("#");	
		var cmds = {
			k101: "co",
			k102: "pm",
			k103: "wendu",
			k104: "shidu",
			k105: "kongqi",
			k106: "co2",
			k107: "yali",
			k108: "liuliang",
			k109: "shuixiang"
		}
		trace("--Fcollection_disply--");
		trace(str);
		var key = cmds["k" + ary[0]];
		trace("key -> " + key);
		var obj = Tool.getDataOnlyById(ary[1], key);
		obj.status = 0;
		if (obj.layer == Datas.layer){
			trace("当前楼层");
			var mc = Tool.getMcById(ary[1], key);
			trace("找到设备");
			trace(mc);
			trace(mc.num_txt.text);
			if (mc == null) {
				//return false;
			}else {
				//return true;
				mc.num_txt.text = ary[2];
				if (key == "shuixiang"){
					mc.water_mc._height = 115 * Number(ary[2]);
				}
			}
		}
	}

	//登陆验证
	public function Fcheck_login(statusNum:String)
	{
		//0, 登陆失败；1, 登陆成功		
		//_root.pannel_mc.sysLoginMC.check_login(statusNum);
		
		_root.pannel_mc.sysLoginMC.check_login(statusNum);

		return true;
	}

	//初始化
	public function Finit_data(xml)
	{
		//初始化的xml字符串
		_root.game.init_data(xml);
		// trace(Datas.layerDataAry[0].num + "==");
		// _root.views.show_layer(Datas.layerDataAry[0].num);
		
		if (Datas.edit)
		{
			_root.showEdit(true);
		}else{
			_root.showEdit(false);
		}
		
		return true;
	}

	//缩略图
	public function Finit_tiny(xml){
		_root.game.init_tiny(xml);
	}

	//开门警报
	public function Fdoor_listener(str:String)
	{
		//DoorNum#CardId#OwnerName#CarNumber#DateTime#OperaCode#type(0为正常开门，1为非法开门)
		//_root.views.door_listener(str);
		return true;
	}

	//开门
	public function Fopenthedoor(str:String)
	{
		//楼层#id
		var ary = str.split("#");	
		if (Datas.layer == ary[0]) {
			var mc = Tool.getMcById(ary[1], "door");
			if (mc == null) {
				//return false;
			}else {
				mc.open();
				//return true;
			}
		}
		var obj = Tool.getDataOnlyById(ary[1], "door");	
		obj.status = 1;
	}

	//关门
	public function Fclosethedoor(str:String)
	{
		//楼层#id
		var ary = str.split("#");	
		if (Datas.layer == ary[0]) {
			var mc = Tool.getMcById(ary[1], "door");
			if (mc == null) {
				//return false;
			}else {
				mc.close();
				//return true;
			}
		}
		var obj = Tool.getDataOnlyById(ary[1], "door");	
		obj.status = 0;
	}
	
	//开闸门
	public function Fopenthebarrier(str:String)
	{
		trace("开闸门" + str);
		//楼层#id
		var ary = str.split("#");	
		if (Datas.layer == ary[0]) {
			var mc = Tool.getMcById(ary[1], "barrier");
			if (mc == null) {
				//return false;
			}else {
				mc.open();
				mc.status = 1
				//return true;
			}
		}
		
		var obj = Tool.getDataOnlyById(ary[1], "barrier");	
		obj.status = 1;
		Tool.showDebug("open");
	}

	//关闸门
	public function Fclosethebarrier(str:String)
	{
		trace("关闸门" + str);
		//楼层#id
		var ary = str.split("#");	
		if (Datas.layer == ary[0]) {
			var mc = Tool.getMcById(ary[1], "barrier");
			if (mc == null) {
				//return false;
			}else {
				mc.close();
				mc.status = 0;
				//return true;
			}
		}
		
		var obj = Tool.getDataOnlyById(ary[1], "barrier");	
		obj.status = 0;
		Tool.showDebug("close");
	}

	//查询
	public function Fsearch_info(requestObj:String)
	{
		//数据条目间用';'隔开，数据之间用','隔开
		//"1,博文,12,1,2010-12-01 14:36;2,山歌,1,9,2011-04-02 10:30;3,函数,3,5,2012-08-12 12:39;"
		_root.pannel_mc.searchBoardMC.setData(requestObj);
		var myLoader:LoadVars = new LoadVars();
		myLoader.onLoad = function(success:Boolean)
		{
			if (success)
			{
				trace(myLoader.datas);
				_root.pannel_mc.searchBoardMC.setData(myLoader.datas);
			}
			else
			{
				trace("加载文件失败");
			}
		}
		myLoader.load(requestObj);
		return true;
	}

	//布防密码验证
	public function Fcheck_defencePsw(str:String)
	{
		//验证类型（s为本层布防；a为全区布防）#验证结果（0为失败；1为成功）
		_root.pannel_mc.defencePswMC.check_defencePsw(str);
		return true;
	}
	
	//报警器报警
	public function Fstart_warn(str)
	{
		if (Datas.isDefence == false)
		{
			return;
		}
		
		//报警楼层#元件id#类型
		var ary:Array = str.split("#");
		_root.bulidAlerm_mc.gotoAndStop(2);
		//trace("当前楼层：" + Datas.layer);
		
		if (Datas.layer == ary[0]) {
			var mc;
			if (ary[2] == 0)
			{
				mc = Tool.getMcById(ary[1], "alarm");
				if (mc == null) {
					//return false;
				}else {
					mc.startWarn(2);
				}
			}
			else
			{
				mc = Tool.getMcById(ary[1], "alarm");
				if (mc == null) {
					//return false;
				}else {
					mc.startWarn(2);
				}
			}
			
		}
		
		var obj = Tool.getDataOnlyById(ary[1], "alarm");
		if (obj == null) {
			//return false;
		}else {		
			obj.status = 2;
			_root.views.show_layer(ary[0]);
			//return true;
		}
	}
	
	//报警器停止
	public function Fstop_warn(str)
	{
		if (Datas.isDefence == false)
		{
			return;
		}
		
		//元件id#类型
		var ary:Array = str.split("#");
		var mc;
		if (ary[1] == 0)
		{
			mc = Tool.getMcById(ary[0], "alarm");
		}
		else
		{
			mc = Tool.getMcById(ary[0], "alarm");
		}
		
		if (mc == null) {
			//return false;
		}else {
			mc.stopWarn();
			_root.bulidAlerm_mc.gotoAndStop(1);			
		}
		
		var obj = Tool.getDataOnlyById(ary[0], "alarm");
		obj.status = 0;		
	}

}