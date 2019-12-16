import flash.display.BitmapData;

class LayerData
{
	public var num:String;
	public var url:String;
	public var tiny:String;
	public var desc:String;
	
	public var bmd:BitmapData;

	public var cameraAry:Array;
	public var alarmAry:Array;
	public var homeAlarmAry:Array;
	public var doorAry:Array;
	public var barrierAry:Array;
	
	public var wenduAry:Array;//可添加的温度设备，xy为0
	public var pmAry:Array;//可添加的pm2.5设备，xy为0
	public var coAry:Array;//可添加的co设备，xy为0
	public var co2Ary:Array;//可添加的co2设备，xy为0
	public var liuliangAry:Array;//可添加的流量设备，xy为0
	public var shiduAry:Array;//可添加的湿度设备，xy为0
	public var yaliAry:Array;//可添加的压力设备，xy为0
	public var kongqiAry:Array;//可添加的空气品质设备，xy为0
	
	public var diantiAry:Array;//可添加的电梯设备，xy为0
	public var fenglengreAry:Array;//可添加的风冷热设备，xy为0
	public var paifengjiAry:Array;//可添加的排风机设备，xy为0
	public var songfengjiAry:Array;//可添加的送风机设备，xy为0
	public var jiaohuanAry:Array;//可添加的全热新风交换机设备，xy为0
	public var shuibengAry:Array;//可添加的水泵设备，xy为0
	public var kongtiaoAry:Array;//可添加的空调设备，xy为0
	public var shuixiangAry:Array;//可添加的水箱设备，xy为0
	public var paishuiAry:Array;//可添加的排水设备，xy为0
	public var jizuAry:Array;//可添加的空调机组设备，xy为0
	public var zhaomingAry:Array;//可添加的照明设备（灯泡和灯管），xy为0
	public var dengpaoAry:Array;//可添加的灯泡设备，xy为0
	public var dengguanAry:Array;//可添加的灯管设备，xy为0
	public var guangzhaoAry:Array;//可添加的光照控制设备，xy为0
	
	public var cameraMax;
	public var alarmMax;
	public var homeAlarmMax;
	public var barrierMax;
	public var doorMax;
	
	public var coMax;
	public var co2Max;
	public var pmMax;
	public var wenduMax;
	public var shiduMax;
	public var kongqiMax;
	public var yaliMax;
	public var liuliangMax;
	public var shuixiangMax;
	public var diantiMax;
	public var kongtiaoMax;
	public var fenglengreMax;
	public var jizuMax;
	public var paifengjiMax;
	public var songfengjiMax;
	public var paishuiMax;
	public var jiaohuanMax;
	public var shuibengMax;
	public var zhaomingMax;
	public var guangzhaoMax;
	
	public function LayerData(n)
	{
		trace("LayerData " + n + " init");
		num = n;
		cameraAry = [];
		alarmAry = [];
		homeAlarmAry = [];
		doorAry = [];
		barrierAry = [];
		
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
		songfengjiAry = [];//可添加的送风机设备，xy为0
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
	}
}