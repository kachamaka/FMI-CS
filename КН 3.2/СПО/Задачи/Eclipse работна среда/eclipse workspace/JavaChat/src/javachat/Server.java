package javachat;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;



public class Server {
	
	public static void main(String[] args) {
		Alert.show("Server thread stared!");
		
		try 
		{	
			int serverPort = 4444, maxClients = 5;
			
			if (args.length == 2)
			{	
				serverPort = Integer.parseInt(args[0]);
				maxClients = Integer.parseInt(args[1]);
			}
		
			ServerStarterRunnable ssRunnable = new ServerStarterRunnable(serverPort, maxClients);
			Thread ssThread = new Thread(ssRunnable);
			ssThread.start();
			
			BufferedReader console = new BufferedReader(new InputStreamReader(System.in));
			
			Thread.sleep(100);
			
			while (true)
			{	
				System.out.println("<< Enter 'quit' to exit! >>");
				String cmd = console.readLine();
				
				if (cmd.startsWith("quit"))
				{
					if (ssThread.isAlive())
					{
						ssRunnable.stop();
						ssThread.join();
					}
					
					break;
				}
			}
		} 
		catch (IOException e) 
		{
			System.out.println("Connection problem!");
			//e.printStackTrace();
		} catch (InterruptedException e) {
			//e.printStackTrace();
		}
		
		Alert.show("Server thread stoped!");
	}
}
