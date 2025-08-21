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
	private boolean done;
	
	public FruitServer() throws RemoteException {
		
		super();
		
		i = 3;
		done = false;
	}

	public String getNextFruit() throws RemoteException {
		
		try {
			
			String tn = Thread.currentThread().getName();
			done = false;
			i++;
			if (i == 4) i = 0;
			Thread.sleep(3000);
			done = true;
			
			System.out.println("server getNextFruit() thread: '" + tn + "' reports FINISHED");

			return fruit_db[i];
			
		} catch (InterruptedException e) {
			
			e.printStackTrace();
			return null;
			
		}
	
	}

	public boolean isDone() throws RemoteException {
		String tn = Thread.currentThread().getName();
		System.out.println("server isDone() thread: '" + tn + "' reports FINISHED");
		return done;
	}
	
	
	public static void main(String argc[]) {

        System.setProperty("java.security.policy", "security.policy");
        System.setSecurityManager(new RMISecurityManager());
		
		try {
			
			FruitServer fruitserv = new FruitServer();
			Naming.rebind("fruit", fruitserv);
			String host_addrress = InetAddress.getLocalHost().getHostAddress();
			System.out.println("'fruit' server bound @ " + host_addrress + ":1099");
			
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
	}

	
}
