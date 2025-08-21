
public class BankTest {

	private static final int NUM_ACCOUNTS = 100;
	private static final double INITIAL_ACCOUNT_BALANCE = 1000.0;
	
	public static void main(String[] args) {
		
		Bank b = new Bank(NUM_ACCOUNTS, INITIAL_ACCOUNT_BALANCE);
		
		Thread jobs[] = new Thread[NUM_ACCOUNTS];
		
		
		// System.out.println("Initial Bank Balance: " + b.getTotalBalance());
		System.out.printf("%s: Initial bank balance: %.2f\n\n", Thread.currentThread().getName(), b.getTotalBalance());
		
		for(int i=0; i < NUM_ACCOUNTS; i++) {
			
			TransferRunnable r = new TransferRunnable(b, i, INITIAL_ACCOUNT_BALANCE);
			Thread t = new Thread(r);
			t.start();
			jobs[i] = t;
			
		}
		
		for(int i = 0; i < NUM_ACCOUNTS; i++) {
			
			try {
				
				jobs[i].join();
				
			} catch (InterruptedException e) {
				
			}
			
		}
		
		// System.out.println("Final Bank Balance: " + b.getTotalBalance());
		System.out.printf("%s: Final bank balance: %.2f\n\n", Thread.currentThread().getName(), b.getTotalBalance());
		
	}

}
