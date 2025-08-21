package javachat;

public class Message {
	public String receiver, text, sender;
	
	public Message(String msg, String sender)
	{
		if (msg.startsWith("msg_to"))
		{
			this.receiver = msg.split(" ")[1];
			this.text = msg.substring(msg.indexOf(' ', 7));
		}
		else
		{
			this.receiver = "*";
			this.text = msg.substring(msg.indexOf(' '));
		}
		
		this.sender = sender;
	}
}
