import flash.display.BitmapData;

class Game
{
	public function Game()
	{
		trace("game init");
	}

	//缩略图初始化
	public function init_tiny(loadXML){
		var levelLen = loadXML.firstChild.childNodes.length;
		trace("缩略图楼层数：" + levelLen);
		Datas.layerDataAry = [];

		for (var i = 0; i < levelLen; i++)
		{
			var lnum = loadXML.firstChild.childNodes[i].attributes.num;
			var layerData:LayerData = new LayerData(lnum);
			layerData.tiny = loadXML.firstChild.childNodes[i].attributes.url;
			layerData.desc = loadXML.firstChild.childNodes[i].attributes.layerdesc;
			trace(layerData.tiny);
			Datas.layerDataAry.push(layerData);
		}
		_root.views.show_layer(Datas.layerDataAry[0].num);
	}

	//数据初始化
	public function init_data(loadXML)
	{		
		// var loadXML = new XML(str);
		// Tool.showDebug(loadXML);
		// loadXML.ignoreWhite = true;
		var levelLen = loadXML.firstChild.childNodes.length;
		trace("总楼层数：" + levelLen);
		
		// Datas.layerDataAry = [];
		
		for (var i = 0; i < levelLen; i++)
		{
			var lnum = loadXML.firstChild.childNodes[i].attributes.num;
			
			// var layerData:LayerData = new LayerData(lnum);
			var layerData:LayerData = Tool.getLayerData(Datas.layer);	
			
			// layerData.desc = loadXML.firstChild.childNodes[i].attributes.layerdesc;
			layerData.url = loadXML.firstChild.childNodes[i].attributes.url;
			
			//layerData.tiny = loadXML.firstChild.childNodes[i].attributes.tiny;
			
			// layerData.tiny = layerData.url.split(".jpg")[0] + "s.jpg";
			
			
			for (var j = 0; j < loadXML.firstChild.childNodes[i].childNodes.length; j++)
			{
				var DeviceName = loadXML.firstChild.childNodes[i].childNodes[j].attributes.name;
				var max = loadXML.firstChild.childNodes[i].childNodes[j].attributes.maxNum;
				
				if (DeviceName == "Camera")
				{
					for (var k = 0; k < loadXML.firstChild.childNodes[i].childNodes[j].childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.id;
						obj.xpos = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.xpos;
						obj.ypos = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.ypos;
						obj.faceto = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.faceto;
						obj.cycle = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.cycle;
						obj.monitorNum = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.monitorNum;
						obj.physicalNum = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.physicalNum;
						obj.cameraType = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.cameraType;
						
						if (obj.cameraType > 6 || obj.cameraType < 0) {
							obj.cameraType = 0;
						}
						
						obj.layer = lnum;
						layerData.cameraAry.push(obj);
						layerData.cameraMax = max;
						trace(layerData.desc + " add Camera");
					}
				}
				else if (DeviceName == "Alarm")
				{
					for (var k = 0; k < loadXML.firstChild.childNodes[i].childNodes[j].childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.id;
						obj.x1 = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.x1;
						obj.y1 = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.y1;
						obj.x2 = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.x2;
						obj.y2 = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.y2;
						obj.x3 = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.x3;
						obj.y3 = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.y3;
						obj.status = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.status;
						if (obj.status == undefined)
						{
							obj.status = 0;
						}
						obj.physicalNum = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.physicalNum;
						obj.term_type = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.term_type;
						
						obj.layer = lnum;
						layerData.alarmAry.push(obj);
						layerData.alarmMax = max;
						trace(layerData.desc + " add Alarm = " + obj.status);
					}
				}
				else if (DeviceName == "HomeAlarm")
				{
					var tmpArr = new Array();
					for (var k = 0; k < loadXML.firstChild.childNodes[i].childNodes[j].childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.id;
						obj.xpos = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.xpos;
						obj.ypos = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.ypos;
						obj.status = 0;
						obj.physicalNum = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.physicalNum;
						obj.houseType = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.houseType;
						obj.housex = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.housex;
						obj.housey = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.housey;						
						obj.layer = lnum;
						layerData.homeAlarmAry.push(obj);
						layerData.homeAlarmMax = max;
						trace(layerData.desc + " add HomeAlarm");
					}
				}
				else if (DeviceName == "Barrier")
				{
					var tmpArr = new Array();
					for (var k = 0; k < loadXML.firstChild.childNodes[i].childNodes[j].childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.id;
						obj.xpos = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.xpos;
						obj.ypos = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.ypos;
						obj.faceto = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.faceto;
						
						obj.status = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.status;
						if (obj.status == undefined)
						{
							obj.status = 0;
						}
						
						obj.physicalNum = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.physicalNum;
						
						obj.layer = lnum;
						layerData.barrierAry.push(obj);
						layerData.barrierMax = max;
						trace(layerData.desc + " add Barrier");
					}
				}
				else if (DeviceName == "Door")
				{
					var tmpArr = new Array();
					for (var k = 0; k < loadXML.firstChild.childNodes[i].childNodes[j].childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.id;
						obj.xpos = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.xpos;
						obj.ypos = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.ypos;
						obj.doorType = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.doorType;
						obj.faceto = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.faceto;
						obj.status = 0;
						obj.physicalNum = loadXML.firstChild.childNodes[i].childNodes[j].childNodes[k].attributes.physicalNum;
						
						obj.layer = lnum;
						layerData.doorAry.push(obj);
						layerData.doorMax = max;
						trace(layerData.desc + " add Door");
					}
				}
				
				else if (DeviceName == "CO")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						obj.status = pnode.childNodes[k].attributes.status;
						
						obj.layer = lnum;
						layerData.coAry.push(obj);
						layerData.coMax = max;
						trace(layerData.desc + " add CO");
						
						trace(pnode.childNodes[k].attributes.type + "-----" + obj.ctype);
					}
				}
				
				else if (DeviceName == "PM2.5")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						obj.status = pnode.childNodes[k].attributes.status;
						
						obj.layer = lnum;
						layerData.pmAry.push(obj);
						layerData.pmMax = max;
						trace(layerData.desc + " add PM2.5");
					}
				}
				
				else if (DeviceName == "Temperature")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						obj.status = pnode.childNodes[k].attributes.status;
						
						obj.layer = lnum;
						layerData.wenduAry.push(obj);
						layerData.wenduMax = max;
						trace(layerData.desc + " add Temperature");
					}
				}
				
				else if (DeviceName == "Humidity")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						obj.status = pnode.childNodes[k].attributes.status;
						
						obj.layer = lnum;
						layerData.shiduAry.push(obj);
						layerData.shiduMax = max;
						trace(layerData.desc + " add Humidity");
					}
				}
				
				else if (DeviceName == "Air_Quality")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						obj.status = pnode.childNodes[k].attributes.status;
						
						obj.layer = lnum;
						layerData.kongqiAry.push(obj);
						layerData.kongqiMax = max;
						trace(layerData.desc + " add Air_Quality");
					}
				}
				
				else if (DeviceName == "CO2")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						obj.status = pnode.childNodes[k].attributes.status;
						
						obj.layer = lnum;
						layerData.co2Ary.push(obj);
						layerData.co2Max = max;
						trace(layerData.desc + " add CO2");
					}
				}
				
				else if (DeviceName == "Pressure")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						obj.status = pnode.childNodes[k].attributes.status;
						
						obj.layer = lnum;
						layerData.yaliAry.push(obj);
						layerData.yaliMax = max;
						trace(layerData.desc + " add Pressure");
					}
				}
				
				else if (DeviceName == "Flow")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						obj.status = pnode.childNodes[k].attributes.status;
						
						obj.layer = lnum;
						layerData.liuliangAry.push(obj);
						layerData.liuliangMax = max;
						trace(layerData.desc + " add Flow");
					}
				}
				
				else if (DeviceName == "Water_Tank")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						obj.status = pnode.childNodes[k].attributes.status;
						
						obj.layer = lnum;
						layerData.shuixiangAry.push(obj);
						layerData.shuixiangMax = max;
						trace(layerData.desc + " add Water_Tank");
					}
				}
				
				else if (DeviceName == "Elevator")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.failure = pnode.childNodes[k].attributes.failure;
						obj.run = pnode.childNodes[k].attributes.run;
						obj.floor_num = pnode.childNodes[k].attributes.floor_num;
						
						
						obj.layer = lnum;
						layerData.diantiAry.push(obj);
						layerData.diantiMax = max;
						trace(layerData.desc + " add Elevator");
					}
				}
				
				else if (DeviceName == "Temp_Ctrl")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.failure = pnode.childNodes[k].attributes.failure;
						obj.run = pnode.childNodes[k].attributes.run;
						obj.fan_speed = pnode.childNodes[k].attributes.fan_speed;
						obj.set_temp = pnode.childNodes[k].attributes.set_temp;
						obj.room_temp = pnode.childNodes[k].attributes.room_temp;
						obj.auto = pnode.childNodes[k].attributes.auto;
						obj.mode = pnode.childNodes[k].attributes.mode;
						obj.fan_speed = pnode.childNodes[k].attributes.fan_speed;
						
						obj.layer = lnum;
						layerData.kongtiaoAry.push(obj);
						layerData.kongtiaoMax = max;
						trace(layerData.desc + " add Temp_Ctrl");
					}
				}
				
				else if (DeviceName == "Heat_Pump")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.auto = pnode.childNodes[k].attributes.auto;
						obj.failure = pnode.childNodes[k].attributes.failure;
						obj.run = pnode.childNodes[k].attributes.run;
						
						obj.layer = lnum;
						layerData.fenglengreAry.push(obj);
						layerData.fenglengreMax = max;
						trace(layerData.desc + " add Heat_Pump");
					}
				}
				
				else if (DeviceName == "Air_Conditioner")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.auto = pnode.childNodes[k].attributes.auto;
						obj.failure = pnode.childNodes[k].attributes.failure;
						obj.run = pnode.childNodes[k].attributes.run;
						
						obj.layer = lnum;
						layerData.jizuAry.push(obj);
						layerData.jizuMax = max;
						trace(layerData.desc + " add Air_Conditioner");
					}
				}
				
				else if (DeviceName == "Air_Exhaust")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.auto = pnode.childNodes[k].attributes.auto;
						obj.failure = pnode.childNodes[k].attributes.failure;
						obj.run = pnode.childNodes[k].attributes.run;
						
						obj.layer = lnum;
						layerData.paifengjiAry.push(obj);
						layerData.paifengjiMax = max;
						trace(layerData.desc + " add Air_Exhaust");
					}
				}
				
				//送风机----------------------------------------
				else if (DeviceName == "Fan")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.auto = pnode.childNodes[k].attributes.auto;
						obj.failure = pnode.childNodes[k].attributes.failure;
						obj.run = pnode.childNodes[k].attributes.run;
						
						obj.layer = lnum;
						layerData.songfengjiAry.push(obj);
						layerData.songfengjiMax = max;
						trace(layerData.desc + " add Fan");
					}
				}
				
				else if (DeviceName == "Drainage_Pump")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.auto_1 = pnode.childNodes[k].attributes.auto_1;
						obj.failure_1 = pnode.childNodes[k].attributes.failure_1;
						obj.run_1 = pnode.childNodes[k].attributes.run_1;
						obj.auto_2 = pnode.childNodes[k].attributes.auto_2;
						obj.failure_2 = pnode.childNodes[k].attributes.failure_2;
						obj.run_2 = pnode.childNodes[k].attributes.run_2;
						obj.num = pnode.childNodes[k].attributes.num;
						
						obj.layer = lnum;
						layerData.paishuiAry.push(obj);
						layerData.paishuiMax = max;
						trace(layerData.desc + " add Drainage_Pump");
					}
				}
				
				else if (DeviceName == "Wind_Switch")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.auto = pnode.childNodes[k].attributes.auto;
						obj.failure = pnode.childNodes[k].attributes.failure;
						obj.run = pnode.childNodes[k].attributes.run;
						
						obj.layer = lnum;
						layerData.jiaohuanAry.push(obj);
						layerData.jiaohuanMax = max;
						trace(layerData.desc + " add Wind_Switch");
					}
				}
				
				else if (DeviceName == "Water_Pump")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.auto = pnode.childNodes[k].attributes.auto;
						obj.failure = pnode.childNodes[k].attributes.failure;
						obj.run = pnode.childNodes[k].attributes.run;
						
						obj.layer = lnum;
						layerData.shuibengAry.push(obj);
						layerData.shuibengMax = max;
						trace(layerData.desc + " add Water_Pump");
					}
				}
				
				//照明设备----------------------------------------
				else if (DeviceName == "Lighting_Lamps")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.auto = pnode.childNodes[k].attributes.auto;
						obj.failure = pnode.childNodes[k].attributes.failure;
						obj.run = pnode.childNodes[k].attributes.run;
						
						obj.layer = lnum;
						layerData.zhaomingAry.push(obj);
						layerData.zhaomingMax = max;
						trace(layerData.desc + " add Lighting_Lamps");
					}
				}
				
				else if (DeviceName == "Lighting_Ctrl")
				{
					var tmpArr = new Array();
					var pnode = loadXML.firstChild.childNodes[i].childNodes[j];
					for (var k = 0; k < pnode.childNodes.length; k++)
					{
						var obj = new Object();
						obj.id = pnode.childNodes[k].attributes.id;
						obj.xpos = pnode.childNodes[k].attributes.xpos;
						obj.ypos = pnode.childNodes[k].attributes.ypos;
						obj.ctype = pnode.childNodes[k].attributes.type;
						obj.physicalNum = pnode.childNodes[k].attributes.physicalNum;
						
						obj.auto_1 = pnode.childNodes[k].attributes.auto_1;
						obj.failure_1 = pnode.childNodes[k].attributes.failure_1;
						obj.run_1 = pnode.childNodes[k].attributes.run_1;
						obj.auto_2 = pnode.childNodes[k].attributes.auto_2;
						obj.failure_2 = pnode.childNodes[k].attributes.failure_2;
						obj.run_2 = pnode.childNodes[k].attributes.run_2;
						
						obj.auto_3 = pnode.childNodes[k].attributes.auto_3;
						obj.failure_3 = pnode.childNodes[k].attributes.failure_3;
						obj.run_3 = pnode.childNodes[k].attributes.run_3;
						obj.auto_4 = pnode.childNodes[k].attributes.auto_4;
						obj.failure_4 = pnode.childNodes[k].attributes.failure_4;
						obj.run_4 = pnode.childNodes[k].attributes.run_4;
						
						obj.layer = lnum;
						layerData.guangzhaoAry.push(obj);
						layerData.guangzhaoMax = max;
						trace(layerData.desc + " add Lighting_Ctrl");
					}
				}
			}
			
			trace("push " + layerData.desc);
			// Datas.layerDataAry.push(layerData);

			_root.views.display_layer();
		}
	}

	//初始化楼层图上的元件
	public function setMap()
	{
		_root.views.remove_mc(true);
		_root.views.hide_rotation();
		
		var layerData:LayerData = Tool.getLayerData(Datas.layer);		
		if (layerData == null)
		{
			return;
		}
		
		if (layerData.bmd == undefined) {
			layerData.bmd = new BitmapData(1920, 1080, false, 0x008000);
			layerData.bmd.draw(_root.map_mc);
			trace("-----保存图片" + Datas.layer + "-----");
		}
		
		Datas.reset();
		
		initCamera(layerData.cameraAry);
		initHomeAlarm(layerData.homeAlarmAry);
		initAlarm(layerData.alarmAry);
		initBarrier(layerData.barrierAry);
		initDoor(layerData.doorAry);
		
		
		initCommView(layerData.coAry, "co");
		initCommView(layerData.pmAry, "pm");
		initCommView(layerData.wenduAry, "wendu");
		initCommView(layerData.shiduAry, "shidu");
		initCommView(layerData.kongqiAry, "kongqi");
		initCommView(layerData.co2Ary, "co2");
		initCommView(layerData.yaliAry, "yali");
		initCommView(layerData.liuliangAry, "liuliang");
		initShuixiang(layerData.shuixiangAry);
		initDianti(layerData.diantiAry);
		initKongtiao(layerData.kongtiaoAry);
		initFenglengre(layerData.fenglengreAry);
		initJizu(layerData.jizuAry);
		initPaifengji(layerData.paifengjiAry);
		initSongfengji(layerData.songfengjiAry);
		initPaishui(layerData.paishuiAry);
		initJiaohuan(layerData.jiaohuanAry);
		initShuibeng(layerData.shuibengAry);
		initGuangzhao(layerData.guangzhaoAry);
		initZhaoming(layerData.zhaomingAry);
		//initShuibeng();//------------------------------水泵
		
		_root.callFuns.change_map(Datas.layer);
		trace("change_map -");
		_root.views.filterShow();
		trace("filterShow -");
	}
	
	public function resetCommState(mc, data){
		trace("run: " + data.run + "  auto: " + data.auto);
		trace("_currentFrame=" + mc.state_mc.togger_btn._currentframe);
		if (data.run == 1){
			mc.state_mc.togger_btn.gotoAndStop(1);
			mc.rotate_mc.play();
			mc.rotate1_mc.play();
			mc.rotate2_mc.play();
		}
		else{
			data.run = 0;
			mc.state_mc.togger_btn.gotoAndStop(7);
			mc.rotate_mc.stop();
			mc.rotate1_mc.stop();
			mc.rotate2_mc.stop();
		}
		
		mc.state_mc.state_txt.text = data.failure == 1 ? "故障" : "正常";
		if (data.auto == 1){
			mc.state_mc.auto_mc.gotoAndStop(2);
		}
		else{
			data.auto = 0;
			mc.state_mc.auto_mc.gotoAndStop(1);
		}
	
	}
	
	public function resetCommItemState(mc, data, id){
		if (data["run_" + id] == 1){
			mc["state" + id + "_mc"].togger1_btn.gotoAndStop(1);
			mc["state" + id + "_mc"].run_mc.gotoAndStop(2);
		}
		else{
			mc["state" + id + "_mc"].togger1_btn.gotoAndStop(7);
			mc["state" + id + "_mc"].run_mc.gotoAndStop(1);
		}
		
		if (data["auto_" + id] == 1){
			mc["state" + id + "_mc"].togger2_btn.gotoAndStop(1);
			mc["state" + id + "_mc"].auto_mc.gotoAndStop(2);
		}
		else{
			mc["state" + id + "_mc"].togger2_btn.gotoAndStop(7);
			mc["state" + id + "_mc"].auto_mc.gotoAndStop(1);
		}
		
		if (data["failure_" + id] == 1){
			mc["state" + id + "_mc"].state_mc.gotoAndStop(2);
		}
		else{
			mc["state" + id + "_mc"].state_mc.gotoAndStop(1);
		}
	}
	
	public function initJiaohuan(list:Array){
		var mcAry = initCommView(list, "jiaohuan");
		for (var i = 0; i < mcAry.length; i++){
			//mcAry[i].water_mc.height = 116 * 0.5;
			resetCommState(mcAry[i], list[i]);
		}
	}
	
	public function initZhaoming(list:Array){
		var mcAry = initCommView(list, "zhaoming");
		for (var i = 0; i < mcAry.length; i++){
			resetCommState(mcAry[i], list[i]);
			if (list[i].run == 1){
				mcAry[i].light_mc.gotoAndStop(2);
			}
			else{
				mcAry[i].light_mc.gotoAndStop(1);
			}
		}
	}
	
	public function initGuangzhao(list:Array){
		var mcAry = initCommView(list, "guangzhao");
		for (var i = 0; i < mcAry.length; i++){
			//mcAry[i].water_mc.height = 116 * 0.5;
			resetGuangzhao(mcAry[i], list[i]);
		}
	}
	public function resetGuangzhao(mc, data){
		resetCommItemState(mc, data, 1);
		resetCommItemState(mc, data, 2);
		resetCommItemState(mc, data, 3);
		resetCommItemState(mc, data, 4);
	}
	
	public function initShuibeng(list:Array){
		var mcAry = initCommView(list, "shuibeng");
		for (var i = 0; i < mcAry.length; i++){
			resetCommState(mcAry[i], list[i]);
		}
	}
	
	public function initPaishui(list:Array){
		var mcAry = initCommView(list, "paishui");
		for (var i = 0; i < mcAry.length; i++){
			//mcAry[i].water_mc.height = 116 * 0.5;
			resetPaishui(mcAry[i], list[i]);
		}
	}
	
	public function resetPaishui(mc, data){
		if (data.run_1 == 1){
			mc.state1_mc.togger_btn.gotoAndStop(1);
			mc.rotate1_mc.play();
		}
		else{
			data.run_1 = 0;
			mc.state1_mc.togger_btn.gotoAndStop(7);
			mc.rotate1_mc.stop();
		}
		mc.state1_mc.state_txt.text = data.failure_1 == 1 ? "故障" : "正常";
		
		if (data.auto_1 == 1){
			mc.state1_mc.auto_mc.gotoAndStop(2);
		}
		else{
			mc.state1_mc.auto_mc.gotoAndStop(1);
		}
		
		if (data.run_2 == 1){
			mc.state2_mc.togger_btn.gotoAndStop(1);
			mc.rotate2_mc.play();
		}
		else{
			data.run_2 = 0;
			mc.state2_mc.togger_btn.gotoAndStop(7);
			mc.rotate2_mc.stop();
		}
		mc.state2_mc.state_txt.text = data.failure_2 == 1 ? "故障" : "正常";
		
		if (data.auto_2 == 1){
			mc.state2_mc.auto_mc.gotoAndStop(2);
		}
		else{
			mc.state2_mc.auto_mc.gotoAndStop(1);
		}
		
		mc.water1_mc._visible = data.num == 1;
		mc.water2_mc._visible = data.num == 2;
		mc.water3_mc._visible = data.num == 3;
	}
	
	
	public function initPaifengji(list:Array){
		var mcAry = initCommView(list, "paifengji");
		for (var i = 0; i < mcAry.length; i++){
			trace("paifengji--1");
			resetCommState(mcAry[i], list[i]);
			trace("paifengji----2");
		}
	}
	
	
	
	public function initSongfengji(list:Array){
		var mcAry = initCommView(list, "songfengji");
		for (var i = 0; i < mcAry.length; i++){
			resetCommState(mcAry[i], list[i]);
		}
	}
	
	public function initJizu(list:Array){
		var mcAry = initCommView(list, "jizu");
		for (var i = 0; i < mcAry.length; i++){
			resetCommState(mcAry[i], list[i]);
		}
	}
	
	public function initFenglengre(list:Array){
		var mcAry = initCommView(list, "fenglengre");
		for (var i = 0; i < mcAry.length; i++){
			//mcAry[i].water_mc.height = 116 * 0.5;
		}
	}
	
	public function initKongtiao(list:Array){
		var mcAry = initCommView(list, "kongtiao");
		for (var i = 0; i < mcAry.length; i++){
			resetKongtiao(mcAry[i], list[i]);
		}
	}
	
	public function resetKongtiao(mc, data){
		mc.sheding_txt.text = data.set_temp; 
		mc.shinei_txt.text = data.room_temp; 
		mc.zhuangtai_txt.text = data.failure == 0 ? "正常" : "故障";
		if (data.mode == 1){
			mc.mode_txt.text = "冷风";
		}
		else if (data.mode == 2){
			mc.mode_txt.text = "热风";
		}
		else if (data.mode == 3){
			mc.mode_txt.text = "自动";
		}
		mc.speed_txt.text = data.fan_speed;
		if (data.run == 1){
			mc.open_mc.gotoAndStop(1);
		}
		else{
			mc.open_mc.gotoAndStop(2);
		}
	}
	
	public function initDianti(list:Array){
		var mcAry = initCommView(list, "dianti");
		for (var i = 0; i < mcAry.length; i++){
			resetDianti(mcAry[i], list[i]);
		}
	}
	
	public function resetDianti(mc, data){
		resetCommState(mc, data);
		mc.num_txt.text = data.floor_num;
	}
	
	public function initShuixiang(list:Array){
		var mcAry = initCommView(list, "shuixiang");
		trace("shuixiang total : " + mcAry.length);
		for (var i = 0; i < mcAry.length; i++){
			trace("shuixiang: " + mcAry[i].water_mc._height);
			mcAry[i].water_mc._height = 116 * 0.5;
		}
	}
	
	public function initCommView(list:Array, key:String):Array{
		var mcAry = [];
		for (var i = 0; i < list.length; i++)
		{
			var mc = _root.views.add_mc(key);
			mc.id = list[i].id;
			
			if (Number(list[i].xpos) == 0 && Number(list[i].ypos) == 0) {
				
				Datas[key + "Ary"].push(mc);
				
			}else {
				mc._x = list[i].xpos;
				mc._y = list[i].ypos;
			}
			
			mc.id_txt.text = list[i].physicalNum;
			mc.physicalNum = list[i].physicalNum;
			mc.ctype = list[i].ctype;
			mc.layer = list[i].layer;
			mc.num_txt.text = list[i].status ? list[i].status : 0;
			mcAry.push(mc);
		}
		return mcAry;
	}

	//初始化camera
	public function initCamera(cameraAry:Array)
	{
		for (var i = 0; i < cameraAry.length; i++)
		{
			var mc = _root.views.add_mc("camera" + cameraAry[i].cameraType);
			mc.id = cameraAry[i].id;
			
			if (Number(cameraAry[i].xpos) == 0 && Number(cameraAry[i].ypos) == 0) {
				
				Datas["camera" + cameraAry[i].cameraType + "Ary"].push(mc);
				
				if (cameraAry[i].cameraType == "0") {
					
				}else if (cameraAry[i].cameraType == "1") {
					
				}else if (cameraAry[i].cameraType == "2") {
					
				}else {
					
				}
				
				
			}else {
				mc._x = cameraAry[i].xpos;
				mc._y = cameraAry[i].ypos;
			}
			
			mc.faceto = cameraAry[i].faceto;
			mc.cycle = cameraAry[i].cycle;
			mc.monitorNum = cameraAry[i].monitorNum;
			mc.id_txt.text = cameraAry[i].physicalNum;
			mc.physicalNum = cameraAry[i].physicalNum;
			mc.cameraType = cameraAry[i].cameraType;
			mc.layer = cameraAry[i].layer;
			mc.gotoAndStop(Number(cameraAry[i].faceto) + 1);
		}

	}
	
	//初始化alarm
	public function initAlarm(alarmAry:Array)
	{
		for (var i = 0; i < alarmAry.length; i++)
		{
			var mc;
			if (alarmAry[i].term_type == 1)
			{
				mc = _root.views.add_mc("homeAlarm");
			}
			else
			{
				mc = _root.views.add_mc("alarm");
			}
			
			mc.id = alarmAry[i].id;
			mc._x = alarmAry[i].x1;
			mc._y = alarmAry[i].y1;
				
			if (Number(alarmAry[i].x1) == 0 && Number(alarmAry[i].y1) == 0) {
				Datas.alarmAry.push(mc);
			}
			
			mc.logicNum = alarmAry[i].logicNum;
			mc.physicalNum = alarmAry[i].physicalNum;
			mc.buildNum = alarmAry[i].buildNum;
			mc.status = alarmAry[i].status;
			mc.term_type = alarmAry[i].term_type;
			mc.layer = alarmAry[i].layer;			
			
			if (alarmAry[i].term_type == 1)
			{				
				mc.id_txt.text = alarmAry[i].physicalNum;			
			}
			else
			{
				mc.m1._x = alarmAry[i].x2;
				mc.m1._y = alarmAry[i].y2;
				mc.m2._x = alarmAry[i].x3;
				mc.m2._y = alarmAry[i].y3;
				mc.m1.id_txt.text = alarmAry[i].physicalNum;
				mc.m2.id_txt.text = alarmAry[i].physicalNum;	
			}
		}
		
	}
	
	//初始化homeAlarm
	public function initHomeAlarm(alarmAry:Array)
	{
		for (var i = 0; i < alarmAry.length; i++)
		{
			var mc = _root.views.add_mc("homeAlarm");
			mc.id = alarmAry[i].id;
			
			if (Number(alarmAry[i].xpos) == 0 && Number(alarmAry[i].ypos) == 0) {
				Datas.homeAlarmAry.push(mc);
				
			}else {
				mc._x = alarmAry[i].xpos;
				mc._y = alarmAry[i].ypos;
			}
			
			var mstatus = alarmAry[i].status;
			mc.tmpstatus = mstatus;
			
			mc.physicalNum = alarmAry[i].physicalNum;
			mc.houseType = alarmAry[i].houseType;
			mc.housex = alarmAry[i].housex;
			mc.housey = alarmAry[i].housey;
			mc.layer = alarmAry[i].layer;
			mc.id_txt.text = alarmAry[i].physicalNum;
			if (mstatus == 0)
			{
				mc.gotoAndStop(1);
			}else if (mstatus == 1) {				
				mc.gotoAndStop(2);
			}else if (mstatus == 2) {
				mc.gotoAndStop(3);
			}
		}
	}
	
	//初始化barrier
	public function initBarrier(barrierAry:Array)
	{
		for (var i = 0; i < barrierAry.length; i++)
		{
			var mc = _root.views.add_mc("barrier");
			mc.id = barrierAry[i].id;
			
			if (Number(barrierAry[i].xpos) == 0 && Number(barrierAry[i].ypos) == 0) {
				Datas.barrierAry.push(mc);
				
			}else {
				mc._x = barrierAry[i].xpos;
				mc._y = barrierAry[i].ypos;
			}
			mc.id_txt.text = barrierAry[i].physicalNum;
			mc.faceto = barrierAry[i].faceto;
			mc.status = barrierAry[i].status;
			mc.layer = barrierAry[i].layer;
			mc.gotoAndStop(Number(barrierAry[i].faceto) + 1);
			if (mc.status == 1)
			{
				mc.opening = true;
				mc.mc.gotoAndStop(mc.mc._totalframes);
			}
			else
			{
				mc.opening = false;
				mc.mc.gotoAndStop(1);
			}	
		}
	}
	
	//初始化door
	public function initDoor(doorAry:Array)
	{
		for (var i = 0; i < doorAry.length; i++)
		{
			var mc = _root.views.add_mc("door");
			mc.id = doorAry[i].id;
			
			if (Number(doorAry[i].xpos) == 0 && Number(doorAry[i].ypos) == 0) {
				Datas.doorAry.push(mc);
				
			}else {
				mc._x = doorAry[i].xpos;
				mc._y = doorAry[i].ypos;
			}
			mc.id_txt.text = doorAry[i].physicalNum;
			mc.faceto = doorAry[i].faceto;
			mc.status = doorAry[i].status;
			mc.layer = doorAry[i].layer;
			mc.gotoAndStop(Number(doorAry[i].faceto) + 1);
			if (mc.status == 0)
			{
				mc.mc.gotoAndStop(1);
			}
			else
			{
				mc.mc.gotoAndStop(2);
			}
		}
	}

	//保存并发送楼层图数据到服务器
	public function saveMap()
	{
		var cameraAry:Array = [];
		var alarmAry:Array = [];
		var homeAlarmAry:Array = [];
		var barrierAry:Array = [];
		var doorAry:Array = [];
		
		var wenduAry = [];//可添加的温度设备，xy为0
		var pmAry = [];//可添加的pm2.5设备，xy为0
		var coAry = [];//可添加的co设备，xy为0
		var co2Ary = [];//可添加的co2设备，xy为0
		var liuliangAry = [];//可添加的流量设备，xy为0
		var shiduAry = [];//可添加的湿度设备，xy为0
		var yaliAry = [];//可添加的压力设备，xy为0
		var kongqiAry = [];//可添加的空气品质设备，xy为0
		
		var diantiAry = [];//可添加的电梯设备，xy为0
		var fenglengreAry = [];//可添加的风冷热设备，xy为0
		var paifengjiAry = [];//可添加的排风机设备，xy为0
		var songfengjiAry = [];//可添加的送风机设备，xy为0
		var jiaohuanAry = [];//可添加的全热新风交换机设备，xy为0
		var shuibengAry = [];//可添加的水泵设备，xy为0
		var kongtiaoAry = [];//可添加的空调设备，xy为0
		var shuixiangAry = [];//可添加的水箱设备，xy为0
		var paishuiAry = [];//可添加的排水设备，xy为0
		var jizuAry = [];//可添加的空调机组设备，xy为0
		var zhaomingAry = [];//可添加的照明设备（灯泡和灯管），xy为0
		var dengpaoAry = [];//可添加的灯泡设备，xy为0
		var dengguanAry = [];//可添加的灯管设备，xy为0
		var guangzhaoAry = [];//可添加的光照控制设备，xy为0

		for (var i = 0; i < Datas.mcAry.length; i++)
		{
			var type:String = Datas.mcAry[i]._name.split("_")[0];
			trace("type------------> " + type);
			
			if (type == "alarm" || type == "homeAlarm")
			{
				alarmAry.push(Tool.getAlarmObject(Datas.mcAry[i]));
			}
			else if (type == "camera0" || type == "camera1" || type == "camera2" || type == "camera3" || type == "camera4" || type == "camera5" || type == "camera6")
			{
				cameraAry.push(Tool.getCameraObject(Datas.mcAry[i]));
			}
			else if (type == "homeAlarm")
			{
				//homeAlarmAry.push(Tool.getHomeAlarmObject(Datas.mcAry[i]));
			}
			else if (type == "barrier")
			{
				barrierAry.push(Tool.getBarrierObject(Datas.mcAry[i]));
			}
			else if (type == "door")
			{
				doorAry.push(Tool.getDoorObject(Datas.mcAry[i]));
			}
			
			else if (type == "wendu")
			{
				wenduAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			
			else if (type == "pm")
			{
				pmAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			
			else if (type == "co")
			{
				coAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "co2")
			{
				co2Ary.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "liuliang")
			{
				liuliangAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "shidu")
			{
				shiduAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "yali")
			{
				yaliAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "kongqi")
			{
				kongqiAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			
			else if (type == "dianti")
			{
				diantiAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "fenglengre")
			{
				fenglengreAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "paifengji")
			{
				paifengjiAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "songfengji")
			{
				songfengjiAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "jiaohuan")
			{
				jiaohuanAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			
			else if (type == "shuibeng")
			{
				shuibengAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			
			else if (type == "kongtiao")
			{
				kongtiaoAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			
			else if (type == "shuixiang")
			{
				shuixiangAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "paishui")
			{
				paishuiAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "jizu")
			{
				jizuAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "zhaoming")
			{
				zhaomingAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
			else if (type == "guangzhao")
			{
				guangzhaoAry.push(Tool.initCommView(Datas.mcAry[i]));
			}
		}

		var layerData:LayerData = Tool.getLayerData(Datas.layer);
		
		if (layerData == null)
		{
			return;
		}
		
		layerData.cameraAry = cameraAry;
		layerData.alarmAry = alarmAry;
		layerData.homeAlarmAry = homeAlarmAry;
		layerData.barrierAry = barrierAry;
		layerData.doorAry = doorAry;
		
		layerData.wenduAry = wenduAry;//可添加的温度设备，xy为0
		layerData.pmAry = pmAry;//可添加的pm2.5设备，xy为0
		layerData.coAry = coAry;//可添加的co设备，xy为0
		layerData.co2Ary = co2Ary;//可添加的co2设备，xy为0
		layerData.liuliangAry = liuliangAry;//可添加的流量设备，xy为0
		layerData.shiduAry = shiduAry;//可添加的湿度设备，xy为0
		layerData.yaliAry = yaliAry;//可添加的压力设备，xy为0
		layerData.kongqiAry = kongqiAry;//可添加的空气品质设备，xy为0
		
		layerData.diantiAry = diantiAry;//可添加的电梯设备，xy为0
		layerData.fenglengreAry = fenglengreAry;//可添加的风冷热设备，xy为0
		layerData.paifengjiAry = paifengjiAry;//可添加的排风机设备，xy为0
		layerData.songfengjiAry = songfengjiAry;//可添加的送风机设备，xy为0
		layerData.jiaohuanAry = jiaohuanAry;//可添加的全热新风交换机设备，xy为0
		layerData.shuibengAry = shuibengAry;//可添加的水泵设备，xy为0
		layerData.kongtiaoAry = kongtiaoAry;//可添加的空调设备，xy为0
		layerData.shuixiangAry = shuixiangAry;//可添加的水箱设备，xy为0
		layerData.paishuiAry = paishuiAry;//可添加的排水设备，xy为0
		layerData.jizuAry = jizuAry;//可添加的空调机组设备，xy为0
		layerData.zhaomingAry = zhaomingAry;//可添加的照明设备（灯泡和灯管），xy为0
		layerData.dengpaoAry = dengpaoAry;//可添加的灯泡设备，xy为0
		layerData.dengguanAry = dengguanAry;//可添加的灯管设备，xy为0
		layerData.guangzhaoAry = guangzhaoAry;//可添加的光照控制设备，xy为0
		
		trace(Tool.layerDataToString(layerData));

		_root.callFuns.save_layer(Tool.layerDataToString(layerData));
		
	}

}