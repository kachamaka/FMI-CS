import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RMISecurityManager;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.Calendar;


public class FruitClient {

	public static void main(String argc[]) {
		
		Remote remoteObject = null;
		Fruit serverObject;

        System.setProperty("java.security.policy", "security.policy");
        System.setSecurityManager(new RMISecurityManager());
		
		try {
			
//			remoteObject = Naming.lookup("rmi://localhost/fruit");
			remoteObject = Naming.lookup("fruit");
			serverObject = (Fruit) remoteObject;
			
 			long ts_b;
			long ts_e;
			
			for(int i = 0; i < 5; i++) {
				ts_b = Calendar.getInstance().getTimeInMillis();
				System.out.println(serverObject.getNextFruit());
				ts_e = Calendar.getInstance().getTimeInMillis();
				System.out.println("iteration: " + i + ", finished in: " + (ts_e - ts_b) + " milliseconds.");
			}

/*
  			FruitClientRunnable fcr = new FruitClientRunnable(serverObject);
			Thread t = new Thread(fcr);
			t.start();
			
			String crnt_t = Thread.currentThread().getName();
			String clnt_t = t.getName();
			
			while (t.isAlive()) {
				ts_b = Calendar.getInstance().getTimeInMillis();
				t.join(200);
				ts_e = Calendar.getInstance().getTimeInMillis();
				System.out.println("'" + crnt_t + "' serverObject.isDone(): " + serverObject.isDone());
				System.out.println("'" + crnt_t + "' waited thread '" + clnt_t + "' for about " + (ts_e - ts_b) + " milliseconds to finish.");
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
*/			

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NotBoundException e) {
			e.printStackTrace();
		}
		
	}

}
