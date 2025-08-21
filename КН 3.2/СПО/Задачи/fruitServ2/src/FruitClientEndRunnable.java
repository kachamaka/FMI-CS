
public class FruitClientEndRunnable implements Runnable {

	private FruitClient client;
	
	public FruitClientEndRunnable(FruitClient fc) {
		client = fc;
	}
	
	public void run() {
		
		while (client.calcs < 5) {
			// System.out.println("calcs: " + client.calcs);
			try {
				Thread.sleep(300);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("all finally done!");
		System.exit(0);
		
	}

}
