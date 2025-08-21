import java.rmi.Naming;
import java.rmi.RMISecurityManager;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;


public class FruitClient extends UnicastRemoteObject implements Notify {

	private static final long serialVersionUID = -8628770725596503758L;
	public	int calcs;
	
	public FruitClient() throws RemoteException{
		super();
		calcs = 0;
	}
	
	public static void main(String argc[]) {
		
		Remote remoteObject = null;
		Fruit serverObject;
		
        System.setProperty("java.security.policy", "src/security.policy");
        System.setSecurityManager(new RMISecurityManager());
		
		try {
			
			remoteObject = Naming.lookup("fs2");
			serverObject = (Fruit) remoteObject;
			
			FruitClient client_callback = new FruitClient();
			Naming.rebind("fc2", client_callback);
			
  			FruitClientRunnable fcr = new FruitClientRunnable(serverObject, client_callback);
  			
			Thread t = new Thread(fcr);
			t.start();
			
  			/*
  			FruitClientEndRunnable fcer = new FruitClientEndRunnable(client_callback);
			Thread te = new Thread(fcer);
			te.start();
			*/
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		}
		
		System.out.println("main: done!");
		
	}

	public void calcDone(String f) throws RemoteException {
		System.out.println("remote done with: " + f);
		calcs++;
	}

}
