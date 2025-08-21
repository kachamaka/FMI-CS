package test1;

import java.net.UnknownHostException;

public class MyRunnable implements Runnable {

	private int n;
	
	public MyRunnable(int n) 
	{
		this.n = n;
	}
	public void changeNumber(int n)
	{
		this.n = n;
	}
	
	public void run() {
		for (int i=0; i < 10; i++)
		{
			System.out.println("my number is: " + n);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("End of thread!");
	}

}
