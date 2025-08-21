
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;

import java.io.PrintWriter;
import java.io.BufferedReader;

import java.net.Socket;

import java.io.IOException;
import java.net.UnknownHostException;

// http://java.sun.com/j2se/1.5.0/docs/api/

public class EchoClient {

	public static void main(String[] args) {
		
		try {
			
			Socket s = new Socket("127.0.0.1", 1234);
			
			OutputStream os = s.getOutputStream();
			InputStream is = s.getInputStream();
			
			PrintWriter out = new PrintWriter(new OutputStreamWriter(os));
			BufferedReader in = new BufferedReader(new InputStreamReader(is));
			
			String hello_msg = in.readLine();
			if (hello_msg != null) {
				System.out.println("server said: " + hello_msg);
			}

			String serv_msg;
			String our_msg;

			our_msg = "one...";
			out.println(our_msg);
			out.flush();
			serv_msg = in.readLine();
			System.out.println("server said: " + serv_msg);
			
			Thread.sleep(2000);
			
			our_msg = "two...";
			out.println(our_msg);
			out.flush();
			serv_msg = in.readLine();
			System.out.println("server said: " + serv_msg);
			
			Thread.sleep(2000);
			
			our_msg = "three...";
			out.println(our_msg);
			out.flush();
			serv_msg = in.readLine();
			System.out.println("server said: " + serv_msg);
			
			Thread.sleep(2000);
			
			our_msg = "bye";
			out.println(our_msg);
			out.flush();
			serv_msg = in.readLine();
			System.out.println("server said: " + serv_msg);
			
			Thread.sleep(2000);
			
			s.close();
			
		} catch (UnknownHostException e) {
			
			e.printStackTrace();
			
		} catch (IOException e) {
			
			e.printStackTrace();
			
		} catch (InterruptedException e) {
			e.printStackTrace();
		}


	}

}
