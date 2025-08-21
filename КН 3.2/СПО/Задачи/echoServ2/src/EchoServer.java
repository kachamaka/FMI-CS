
import java.io.IOException;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;

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

				ClientRunnable r = new ClientRunnable(c);
				Thread ct = new Thread(r);
				ct.start();
				
			}
			
		} catch (IOException e) {
			
			e.printStackTrace();
			
		}
		
	}

}
