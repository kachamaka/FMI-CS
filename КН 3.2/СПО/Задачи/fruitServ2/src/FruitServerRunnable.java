import java.rmi.RemoteException;

public class FruitServerRunnable implements Runnable {
	
	private Notify client;
	private FruitServer server;
	
	public FruitServerRunnable(FruitServer s, Notify n) {
		client = n;
		server = s;
	}
	
	public void run() {
		
		try {
			Thread.sleep((int) (3000 * Math.random()));
			server.getNextIndex();
			client.calcDone(server.getFruit());
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
	}

}
