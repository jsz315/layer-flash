import flash.external.ExternalInterface;

class CallFuns
{
	public var isDebug:Boolean;
	public var flashFuns:FlashFuns;
	public var serve:XMLSocket;
	

	public function CallFuns(_isDebug:Boolean, _flashFuns:FlashFuns)
	{
		isDebug = _isDebug;
		flashFuns = _flashFuns;
		trace("call fun init");
		
		serve = new XMLSocket();
		var $this = this;
		serve.onConnect = function()
		{
			trace("连接成功");
		};
		serve.onClose = function() {
			trace("连接断开");
		}
		serve.onData = function(data)
		{
			trace("接收数据 :");
			trace(data);

			var loadXML = new XML(data);
			loadXML.ignoreWhite = true;
			var key = loadXML.firstChild.attributes.key;
			trace(key + "===========");
			if (key == "check_login") {
				var value = loadXML.firstChild.attributes.value;
				_flashFuns.Fcheck_login(value);
			}
			else if(key == "layers_tiny"){
				_flashFuns.Finit_tiny(loadXML);
				// $this.init_layer();
			}
			else if(key == "layer_data"){
				_flashFuns.Finit_data(loadXML);
			}
		};
		
		serve.onXML = function(data) {
			trace("接收XML数据 :");
			trace(data);
			
		}
		
		serve.connect("119.3.52.193", 2255);
	}
	
	function sendWeb(template, args) {
		var str = repalce(template, args);
		trace("发送数据 :");
		trace(str);
		serve.send(str);
	}
	
	function repalce(str, args) {
		var ary = str.split("$");
		var aim = [];
		var n = 0;
		for(var i = 0; i < ary.length - 1; i++){
			aim.push(ary[i]);
			aim.push(args[n++]);
		}
		aim.push(ary[ary.length - 1]);

		return aim.join("");	
	}

	//请求楼层缩略图
	public function layers_tiny(){
		var template = '<xml><location ><item key="ProjectName" Value="Zhenshi_IBMS"/><item key="UserName" Value="$"/><item key="PassWord" Value="$"/><item key="CommandType" Value="1"/><itemkey="CommandVal" Value="20"/><itemkey="Content" Value="1"/></location><xml>';
		sendWeb(template, [_root.UserName, _root.PassWord]);
	}
	

	//登陆系统
	public function login_system(psw)
	{
		if (isDebug)
		{
			ExternalInterface.call("login_system","login#" + psw);
		}
		else
		{
			//fscommand("101", "login#" + psw);
			var template = '<xml><location ><item key="ProjectName" Value="Zhenshi_IBMS"/><item key="UserName" Value="$"/><item key="PassWord" Value="$"/><item key="CommandType" Value="1"/><item key="CommandVal" Value="19"/><item key="Content" Value="1"/></location><xml>';
			var ary = psw.split("#");
			_root.UserName = ary[1];
			_root.PassWord = ary[0];
			sendWeb(template, [_root.UserName, _root.PassWord]);
		}
	}

	//调试信息
	public function show_debug(str)
	{
		if (isDebug)
		{
			ExternalInterface.call("show_debug",str);
		}
	}

	//请求楼层数据
	public function init_layer(){
		var template = '<xml><location ><item key="ProjectName" Value="Zhenshi_IBMS"/><item key="UserName" Value="$"/><item key="PassWord" Value="$"/><item key="CommandType" Value="1"/><item key="CommandVal" Value="21"/><item key="Content" Value="$"/></location><xml>';
		sendWeb(template, [_root.UserName, _root.PassWord, Datas.layer]);
	}

	//请求初始化
	public function init_data()
	{
		if (isDebug)
		{
			ExternalInterface.call("init_data","enter");
		}
		else
		{
			//fscommand("100", "enter");
			layers_tiny();
		}
	}

	//监点切换
	public function switch_monitor(mon, cam)
	{
		if (isDebug)
		{
			ExternalInterface.call("switch_monitor",mon + "#" + cam);
		}
		else
		{
			fscommand("1", mon + "#" + cam);
		}
	}

	//终端控制
	public function terminal_control(cam, action, speed)
	{
		if (isDebug)
		{
			ExternalInterface.call("terminal_control",cam + "#" + action + "#" + speed);
		}
		else
		{
			if (action == "Stop") {
				trace("Stop");
			}
			fscommand("2", cam + "#" + action + "#" + speed);
		}
	}

	//查询
	public function search_info(str)
	{
		//flashFuns.Fsearch_info("1,博文,12,1,2010-12-01 14:36;2,山歌,1,9,2011-04-02 10:30;3,函数,3,5,2012-08-12 12:39;");
		if (isDebug)
		{
			ExternalInterface.call("search_info", str);			
		}
		else
		{
			fscommand("103", str);
		}
	}

	//开门
	public function openthedoor(str)
	{
		if (isDebug)
		{
			ExternalInterface.call("openthedoor",str);
		}
		else
		{
			fscommand("9", str);
		}
	}

	//关门
	public function closethedoor(str)
	{
		if (isDebug)
		{
			ExternalInterface.call("closethedoor",str);
		}
		else
		{
			fscommand("14", str);
		}
	}
	
	//开闸门
	public function openthebarrier(str)
	{
		if (isDebug)
		{
			ExternalInterface.call("openthebarrier",str);
		}
		else
		{
			fscommand("15", str);
		}
	}

	//关闸门
	public function closethebarrier(str)
	{
		if (isDebug)
		{
			ExternalInterface.call("closethebarrier",str);
		}
		else
		{
			fscommand("16", str);
		}
	}


	//检验布防密码
	public function check_defencePsw(str)
	{
		if (isDebug)
		{
			ExternalInterface.call("check_defencePsw",str);
		}
		else
		{
			fscommand("102", str);
		}
	}

	//布防修改
	public function modify_defence(action, type, layer, id)
	{
		if (isDebug)
		{
			ExternalInterface.call("modify_defence",action + "#" + type + "#" + layer + "#" + id);
		}
		else
		{
			fscommand("7", action + "#" + type + "#" + layer + "#" + id);
		}
	}

	//呼叫中心
	public function call_center()
	{
		if (isDebug)
		{
			ExternalInterface.call("alert('call center')");
		}
		else
		{
			fscommand("10", "enter");
		}
	}

	//保存数据
	public function save_layer(str)
	{
		if (isDebug)
		{
			ExternalInterface.call("save_layer", str);
		}
		else
		{
			fscommand("104", str);
		}
	}
	
	//打开视频
	public function open_video(str)
	{
		//trace(str);
		if (isDebug) {
			
		}else {
			fscommand("105", str);
		}
	}
		
	//退出系统
	public function quit_system()
	{
		if (isDebug)
		{
			ExternalInterface.call("alert('quit system')");
		}
		else
		{
			fscommand("13", "enter");
		}
	}
	
	//打开BA
	public function open_BA()
	{
		//trace(str);
		if (isDebug) {
			
		}else {
			fscommand("106", "ba");
		}
	}
	
	//切换楼层刷新命令
	public function change_map(num){
		fscommand("998", num);
	}
	
	//命令操作
	public function CMD(key, data){
		fscommand(key, data);
	}
}