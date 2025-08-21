
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;

//http://java.sun.com/j2se/1.5.0/docs/api/

public class EchoServer {

	public static void main(String[] args) {

		ServerSocket s;
		Socket c;
		
		try {
			
			s = new ServerSocket(1234);
			
			s.getInetAddress();
			
			String lha = InetAddress.getLocalHost().getHostAddress();
			System.out.println("ordinary Echo server started at " + lha + ":1234");
			
			while (true) {
				
				c = s.accept();
				
				InputStream c_in = c.getInputStream();
				OutputStream c_out = c.getOutputStream();
				
				Scanner in = new Scanner(c_in);
				PrintWriter out = new PrintWriter(c_out);
				
				out.println("ordinary Echo server welcomes you...");
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
				
			}
			
		} catch (IOException e) {
			
			e.printStackTrace();
			
		}
		
	}

}
