package javachat;

public class Alert {
	static public boolean visible = true;
	
	static public void show(String msg)
	{
		if (visible)
		{
			System.out.println(msg);
			System.out.flush();
		}
	}
}
