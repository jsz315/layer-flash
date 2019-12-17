import mx.data.types.Int;
class Tool
{
	//把layerData转为字符串
	public static function layerDataToString(layerData)
	{
		var str = "layer_start=" + layerData.num + ";";
		var i;

		for (i = 0; i < layerData.alarmAry.length; i++)
		{
			str += getAlarmString(layerData.alarmAry[i]);
		}

		for (i = 0; i < layerData.homeAlarmAry.length; i++)
		{
			str += getHomeAlarmString(layerData.homeAlarmAry[i]);
		}

		for (i = 0; i < layerData.cameraAry.length; i++)
		{
			str += getCameraString(layerData.cameraAry[i]);
		}
		
		for (i = 0; i < layerData.barrierAry.length; i++)
		{
			str += getBarrierString(layerData.barrierAry[i]);
		}
		
		for (i = 0; i < layerData.doorAry.length; i++)
		{
			str += getDoorString(layerData.doorAry[i]);
		}
		
		str += getCommonListString(layerData.wenduAry, "Temperature");
		str += getCommonListString(layerData.pmAry, "PM2.5");
		str += getCommonListString(layerData.coAry, "CO");
		str += getCommonListString(layerData.co2Ary, "CO2");
		str += getCommonListString(layerData.liuliangAry, "Flow");
		str += getCommonListString(layerData.shiduAry, "Humidity");
		str += getCommonListString(layerData.yaliAry, "Pressure");
		str += getCommonListString(layerData.kongqiAry, "Air_Quality");
		
		str += getCommonListString(layerData.diantiAry, "Elevator");
		str += getCommonListString(layerData.fenglengreAry, "Heat_Pump");
		str += getCommonListString(layerData.paifengjiAry, "Air_Exhaust");
		str += getCommonListString(layerData.songfengjiAry, "Fan");
		str += getCommonListString(layerData.jiaohuanAry, "Wind_Switch");
		str += getCommonListString(layerData.shuibengAry, "Water_Pump");
		str += getCommonListString(layerData.kongtiaoAry, "Temp_Ctrl");
		str += getCommonListString(layerData.shuixiangAry, "Water_Tank");
		str += getCommonListString(layerData.paishuiAry, "Drainage_Pump");
		str += getCommonListString(layerData.jizuAry, "Air_Conditioner");
		str += getCommonListString(layerData.zhaomingAry, "Lighting_Lamps");
		//str += getCommonListString(layerData.dengguanAry, "Lighting_Lamps");
		str += getCommonListString(layerData.guangzhaoAry, "Lighting_Ctrl");
		
		return str + "layer_end;";
	}
	/*
	wenduAry = [];//可添加的温度设备，xy为0
	pmAry = [];//可添加的pm2.5设备，xy为0
	coAry = [];//可添加的co设备，xy为0
	co2Ary = [];//可添加的co2设备，xy为0
	liuliangAry = [];//可添加的流量设备，xy为0
	shiduAry = [];//可添加的湿度设备，xy为0
	yaliAry = [];//可添加的压力设备，xy为0
	kongqiAry = [];//可添加的空气品质设备，xy为0
	
	diantiAry = [];//可添加的电梯设备，xy为0
	fenglengreAry = [];//可添加的风冷热设备，xy为0
	paifengjiAry = [];//可添加的排风机设备，xy为0
	jiaohuanAry = [];//可添加的全热新风交换机设备，xy为0
	shuibengAry = [];//可添加的水泵设备，xy为0
	kongtiaoAry = [];//可添加的空调设备，xy为0
	shuixiangAry = [];//可添加的水箱设备，xy为0
	paishuiAry = [];//可添加的排水设备，xy为0
	jizuAry = [];//可添加的空调机组设备，xy为0
	zhaomingAry = [];//可添加的照明设备（灯泡和灯管），xy为0
	dengpaoAry = [];//可添加的灯泡设备，xy为0
	dengguanAry = [];//可添加的灯管设备，xy为0
	guangzhaoAry = [];//可添加的光照控制设备，xy为0
	*/
	
	public static function getCommonListString(ary, key){
		var str = "";
		for (var i = 0; i < ary.length; i++){
			str += getCommonString(ary[i], key);
		}
		return str;
	}
	
	public static function getCommonString(mc, key){
		var ary:Array = [];
		ary.push(mc.id);
		ary.push(mc.xpos);
		ary.push(mc.ypos);
		ary.push(mc.physicalNum);
		ary.push(mc.ctype);
		trace(mc.ctype + " type ---");
		
		return key + "=" + ary.join(",") + ";";
	}

	//获取alarm对象的属性字符串
	public static function getAlarmString(mc)
	{
		var ary:Array = [];
		ary.push(mc.id);
		ary.push(mc.x1);
		ary.push(mc.y1);
		ary.push(mc.x2);
		ary.push(mc.y2);
		ary.push(mc.x3);
		ary.push(mc.y3);
		ary.push(mc.status);
		ary.push(mc.physicalNum);
		ary.push(mc.term_type);
		
		return "alarm=" + ary.join(",") + ";";
	}
	
	//获取homeAlarm对象的属性字符串
	public static function getHomeAlarmString(mc)
	{
		var ary:Array = [];
		ary.push(mc.id);
		ary.push(mc.xpos);
		ary.push(mc.ypos);
		ary.push(mc.status);
		ary.push(mc.physicalNum);
		ary.push(mc.houseType);
		ary.push(mc.housex);
		ary.push(mc.housey);
		
		return "homealarm=" + ary.join(",") + ";";
	}

	//获取camera对象的属性字符串
	public static function getCameraString(mc)
	{
		var ary:Array = [];
		ary.push(mc.id);
		ary.push(mc.xpos);
		ary.push(mc.ypos);
		ary.push(mc.faceto);
		ary.push(mc.cycle);
		ary.push(mc.monitorNum);
		ary.push(mc.physicalNum);
		ary.push(mc.cameraType);
		
		return "camera=" + ary.join(",") + ";";
	}
	
	//获取barrier对象的属性字符串
	public static function getBarrierString(mc)
	{
		var ary:Array = [];
		ary.push(mc.id);
		ary.push(mc.xpos);
		ary.push(mc.ypos);
		ary.push(mc.faceto);
		ary.push(mc.status);
		ary.push(mc.physicalNum);
		return "barrier=" + ary.join(",") + ";";
	}

	//获取door对象的属性字符串
	public static function getDoorString(mc)
	{
		var ary:Array = [];
		ary.push(mc.id);
		ary.push(mc.xpos);
		ary.push(mc.ypos);
		ary.push(mc.faceto);
		ary.push(mc.status);
		ary.push(mc.physicalNum);
		return "door=" + ary.join(",") + ";";
	}
	
	//根据楼层获取layerData对象
	public static function getLayerData(num)
	{
		for (var i = 0; i < Datas.layerDataAry.length; i++)
		{
			if (Datas.layerDataAry[i].num == num)
			{
				return Datas.layerDataAry[i];
			}
		}
		trace("layerData " + num + " is null");
		return null;
	}
	
	//根据mc的属性获取普通显示数据对象
	public static function initCommView(mc)
	{
		var obj:Object = {};
		obj.id = mc.id;
		obj.xpos = mc._x;
		obj.ypos = mc._y;
		obj.status = mc.num_txt.text;
		obj.physicalNum = mc.id_txt.text;
		obj.ctype = mc.ctype;
		
		return obj;
	}

	//根据mc的属性获取camera数据对象
	public static function getCameraObject(mc)
	{
		var obj:Object = {};
		obj.id = mc.id;
		obj.xpos = mc._x;
		obj.ypos = mc._y;
		obj.faceto = mc._currentframe - 1;
		obj.cycle = mc.cycle;
		obj.monitorNum = mc.monitorNum;
		obj.physicalNum = mc.id_txt.text;
		obj.cameraType = mc._name.substr(6, 1);
		
		return obj;
	}

	//根据mc的属性获取alarm数据对象
	public static function getAlarmObject(mc)
	{
		var obj:Object = {};
		obj.id = mc.id;
		obj.x1 = mc._x;
		obj.y1 = mc._y;
		obj.x2 = mc.m1._x;
		obj.y2 = mc.m1._y;
		obj.x3 = mc.m2._x;
		obj.y3 = mc.m2._y;
		obj.status = mc.status;
		obj.physicalNum = mc.physicalNum;
		obj.term_type = mc.term_type;

		return obj;
	}

	//根据mc的属性获取homeAlarm数据对象
	public static function getHomeAlarmObject(mc)
	{
		var obj:Object = {};
		obj.id = mc.id;
		obj.xpos = mc._x;
		obj.ypos = mc._y;
		obj.status = mc.tmpstatus;
		obj.physicalNum = mc.physicalNum;
		obj.houseType = mc.houseType;
		obj.housex = mc.housex;
		obj.housey = mc.housey;
		
		return obj;
	}
	
	//根据mc属性获取barrier数据对象
	public static function getBarrierObject(mc)
	{
		var obj:Object = {};
		obj.id = mc.id;
		obj.xpos = mc._x;
		obj.ypos = mc._y;
		obj.faceto = mc._currentframe - 1;
		obj.status = mc.status;
		obj.physicalNum = mc.physicalNum;
		return obj;
	}
	
	//根据mc属性获取door数据对象
	public static function getDoorObject(mc)
	{
		var obj:Object = {};
		obj.id = mc.id;
		obj.xpos = mc._x;
		obj.ypos = mc._y;
		obj.faceto = mc._currentframe - 1;		
		obj.status = mc.status;
		obj.physicalNum = mc.physicalNum;
		return obj;
	}
	
	//把对象转为xml格式
	public static function objectToXml(obj)
	{
		var xml = '<item ';
		for (var attr in obj)
		{
			xml += attr + '="' + obj[attr] + '" ';
		}
		xml += '/>';
		return xml;
	}
	
	//打印对象属性
	public static function showObject(obj)
	{
		trace("[start]");
		for (var attr in obj)
		{
			trace(attr + "=" + obj[attr]);
		}
		trace("[end]");
	}
	
	//获取打印数据对象
	public static function getShowObject(obj)
	{
		var str = "";
		
		str = str + "[start]";
		for (var attr in obj)
		{
			str = str + "\n" + attr + "=" + obj[attr];			
		}
		str = str + "\n" + "[end]";
		return str;		
	}
	
	//加载图片
	public static function load(url:String)
	{
		trace("开始加载图片:" + url);
		
		var mcListener:Object = new Object();
		var mcLoader = new MovieClipLoader();

		mcLoader.addListener(mcListener);
		mcLoader.loadClip(url, _root.map_mc);
		
		mcListener.onLoadComplete = function(movieScreen_mc)
		{
			_root.delay_mc.gotoAndPlay("map");
			trace("完成加载图片:" + url);
		};
	}
	
	//根据id取得对应的元件
	public static function getMcById(id:String, type:String)	
	{
		for (var i = 0; i < Datas.mcAry.length; i++)
		{
			var t = Datas.mcAry[i]._name.split("_")[0];
			if (Datas.mcAry[i].id == id)
			{
				trace(t);
				if (type == t) {
					return Datas.mcAry[i];
				}
				//return Datas.mcAry[i];
				
			}
		}
		return null;
	}
	
	//获取楼层元件类型id对应的数据
	public static function getDataById(num:String, id:String, type:String)
	{
		var layerData:LayerData = getLayerData(num);
		var ary:Array = layerData[type + "Ary"];
		for (var i = 0; i < ary.length; i++ ) {
			/*if (ary[i].id == id) {
				return ary[i];
			}*/
			return ary[i];
		}
		return null;
	}
	
	//根据id获取对应数据
	public static function getDataOnlyById(id:String, type:String)
	{
		trace("type: -- > " + type);
		if(!type){
			return null;
		}
		for (var i = 0; i < Datas.layerDataAry.length; i++)
		{
			var layerData:LayerData = Datas.layerDataAry[i];
			
			var ary = layerData[type + "Ary"];
			trace("getDataOnlyById = " + id);
			trace(ary);
			for (var obj in  ary)
			{
				if (ary[obj].id == id)
				{
					return ary[obj];
				}
			}
			
			/*
			if (type == "camera")
			{
				for (var obj in  layerData.cameraAry)
				{				
					if (layerData.cameraAry[obj].id == id)
					{
						return layerData.cameraAry[obj];
					}
				}
			}
			else if (type == "alarm")
			{
				for (var obj in  layerData.alarmAry)
				{
					if (layerData.alarmAry[obj].id == id)
					{
						return layerData.alarmAry[obj];
					}
				}
			}
			else if (type == "door")
			{
				for (var obj in  layerData.doorAry)
				{
					if (layerData.doorAry[obj].id == id)
					{
						return layerData.doorAry[obj];
					}
				}
			}
			else if (type == "barrier")
			{
				return Tool.getDataByIdFromList(id, layerData.barrierAry);
			}
			else
			{
				trace("type: " + type);
				var ary = layerData[type + "Ary"];
				for (var obj in  ary)
				{
					if (ary[obj].id == id)
					{
						return ary[obj];
					}
				}
				//return Tool.getDataByIdFromList(id, type);
			}
			*/
		}
		return null;
	}
	
	//根据id从对应列表获取数据
	public static function getDataByIdFromList(id, type){
		var layerData:LayerData = Tool.getLayerData(Datas.layer);
		var ary = layerData[type + "Ary"];
		trace("ary:" + id);
		for (var i in ary)
		{
			if (ary[i].id == id)
			{
				trace(ary[i]);
				return ary[i];
			}
		}
		return null;
	}
	
	//显示调试数据
	public static function showDebug(str)
	{
		_root.debug_mc.tip_txt.text = str;
		trace(str);
	}
	
	//根据ID显示调试对象数据
	public static function showDedubDataById(id)
	{
		var temp = Tool.getDataOnlyById(id);
		Tool.showDebug(Tool.getShowObject(temp));
	}
	
}