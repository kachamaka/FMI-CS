import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class ClientRunnable implements Runnable {

	private Socket c;
	
	public ClientRunnable(Socket c) {
		
		
		this.c = c;
	}
	
	public void run() {
		
		System.out.println("system: " + Thread.currentThread().getName() + " is going up!");
		
		try {
			
			InputStream c_in = c.getInputStream();
			OutputStream c_out = c.getOutputStream();
			
			Scanner in = new Scanner(c_in);
			PrintWriter out = new PrintWriter(c_out);
			
			out.println("Ordinary Echo2 Server Says Hello!");
			out.flush();
			
			while (in.hasNextLine()) {
				
				String line = in.nextLine();
				System.out.println("client said: " + line);
				
				if (line.startsWith("bye")) {
					
					out.println("bye bye...");
					out.flush();
					c.close();
					
					break;
					
				} else if (line.startsWith("quit")) {
					
					out.println("aborting server...");
					out.flush();
					c.close();
					System.exit(0);
					
				}
				
				out.println(line);
				out.flush();
				
			}
			
		} catch (IOException e) {
			
		}

		System.out.println("system: " + Thread.currentThread().getName() + " is going down!");
		
	}

}
