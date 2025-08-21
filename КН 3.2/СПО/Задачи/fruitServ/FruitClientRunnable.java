import java.rmi.RemoteException;
import java.util.Calendar;


public class FruitClientRunnable implements Runnable {

	private Fruit serverObject;
	
	public FruitClientRunnable(Fruit so) {
		
		serverObject = so;
		
	}
	
	public void run() {

		long ts_b;
		long ts_e;
		
		try {
			
			for(int i = 0; i < 5; i++) {
				ts_b = Calendar.getInstance().getTimeInMillis();
				System.out.println("\t"+serverObject.getNextFruit());
				ts_e = Calendar.getInstance().getTimeInMillis();
				System.out.println("\titeration: " + i + ", finished in: " + (ts_e - ts_b) + " milliseconds.");
			}
		
		} catch (RemoteException e) {
			
			e.printStackTrace();
			
		}
		
	}

}
