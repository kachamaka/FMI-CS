import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.UnknownHostException;
import java.rmi.Naming;
import java.rmi.RMISecurityManager;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class FruitServer extends UnicastRemoteObject implements Fruit {

	private static final long serialVersionUID = -6413340058761978866L;

	private String fruit_db[] = {"apple", "orange", "mango", "plum"};
	private int i;
	
	public FruitServer() throws RemoteException {
		
		super();
		i = 3;
		
	}


	public void getNextCalc(Notify n) throws RemoteException {

		FruitServerRunnable fsr = new FruitServerRunnable(this, n);
		Thread st = new Thread(fsr);
		st.start();
	
	}
	
	public String getFruit() throws RemoteException {
		
		return fruit_db[i];
		
	}

	public void getNextIndex() {
		i++;
		if (i == 4) i = 0;
	}
	
	public static void main(String argc[]) {

        System.setProperty("java.security.policy", "src/security.policy");
        System.setSecurityManager(new RMISecurityManager());
		
		try {
			
			FruitServer fruitserv = new FruitServer();
			Naming.rebind("fs2", fruitserv);
			
			String host_addrress = InetAddress.getLocalHost().getHostAddress();
			System.out.println("'fs2' server bound @ " + host_addrress + ":1099");
			
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		
	}
	
}
