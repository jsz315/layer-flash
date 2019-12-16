/**
 * ...
 * @author ...
 */
class Post
{
	public var serve:XMLSocket;
	
	public function Post() 
	{
		trace("初始化");
		serve = new XMLSocket();
		serve.onConnect = function() {
			_root.receive_txt.text = "连接成功";
		}
		serve.onData = function(data) {
			_root.receive_txt.text = data;
		}
		
		_root.login_btn.onRelease = function(){
			var list = _root.address_txt.text.split(":");
			trace("连接服务器" + list[0] + "端口" + list[1]);
			serve.connect(list[0], Number(list[1]));
		}

		_root.send_btn.onRelease = function(){
			serve.send(_root.send_txt.text);
		}

		_root.sendClear_btn.onRelease = function(){
			_root.send_txt.text = "";
		}

		_root.receiveClear_btn.onRelease = function(){
			_root.receive_txt.text = "";
		}
	}
	
}