class Datas
{
	public static var edit:Boolean = true;//是否为编辑版
	public static var dubuyId:String = "1";//调试id
	public static var isDefence:Boolean = false;//是否布防
	
	public static var openDoorInfo:String;//非法或正常的开门信息
	public static var layer:String;//当前楼层
	public static var filter: String = "anfang";//过滤显示
	public static var area:String;//布防范围
	public static var mc:MovieClip;//当前编辑元件
	public static var mcAry:Array;//元件数组
	public static var layerDataAry:Array;//楼层数据
	public static var clickTime:Number = 0;//鼠标点击时间
	public static var isDoubleClick:Boolean = false;//是否为双击
	public static var curCamera:Number = 1;//当前摄像头
	public static var curMonitor:Number = 1;//当前监视器
	
	public static var imageWidth:Number = 0;//缩略图宽
	public static var imageHight:Number = 0;//缩略图高
	
	public static var camera0Ary:Array;//可添加的设备，xy为0
	public static var camera1Ary:Array;//可添加的设备，xy为0
	public static var camera2Ary:Array;//可添加的设备，xy为0
	public static var camera3Ary:Array;//可添加的设备，xy为0
	public static var camera4Ary:Array;//可添加的设备，xy为0
	public static var camera5Ary:Array;//可添加的设备，xy为0
	public static var camera6Ary:Array;//可添加的设备，xy为0
	
	public static var alarmAry:Array;//可添加的设备，xy为0
	public static var homeAlarmAry:Array;//可添加的设备，xy为0
	public static var doorAry:Array;//可添加的设备，xy为0
	public static var barrierAry:Array;//可添加的设备，xy为0
	
	public static var wenduAry:Array;//可添加的温度设备，xy为0
	public static var pmAry:Array;//可添加的pm2.5设备，xy为0
	public static var coAry:Array;//可添加的co设备，xy为0
	public static var co2Ary:Array;//可添加的co2设备，xy为0
	public static var liuliangAry:Array;//可添加的流量设备，xy为0
	public static var shiduAry:Array;//可添加的湿度设备，xy为0
	public static var yaliAry:Array;//可添加的压力设备，xy为0
	public static var kongqiAry:Array;//可添加的空气品质设备，xy为0
	
	public static var diantiAry:Array;//可添加的电梯设备，xy为0
	public static var fenglengreAry:Array;//可添加的风冷热设备，xy为0
	public static var paifengjiAry:Array;//可添加的排风机设备，xy为0
	public static var songfengjiAry:Array;//可添加的送风机设备，xy为0
	public static var jiaohuanAry:Array;//可添加的全热新风交换机设备，xy为0
	public static var shuibengAry:Array;//可添加的水泵设备，xy为0
	public static var kongtiaoAry:Array;//可添加的空调设备，xy为0
	public static var shuixiangAry:Array;//可添加的水箱设备，xy为0
	public static var paishuiAry:Array;//可添加的排水设备，xy为0
	public static var jizuAry:Array;//可添加的空调机组设备，xy为0
	public static var zhaomingAry:Array;//可添加的照明设备（灯泡和灯管），xy为0
	public static var dengpaoAry:Array;//可添加的灯泡设备，xy为0
	public static var dengguanAry:Array;//可添加的灯管设备，xy为0
	public static var guangzhaoAry:Array;//可添加的光照控制设备，xy为0
	
	public static var list:Number = 0;
	public static var listSpace:Number = 60;
	public static var listHeight:Number = 120;

	public function Datas()
	{
		trace("datas init");
	}
	
	public static function reset()
	{
		mcAry = [];
		
		camera0Ary = [];
		camera1Ary = [];
		camera2Ary = [];
		camera3Ary = [];
		camera4Ary = [];
		camera5Ary = [];
		camera6Ary = [];
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