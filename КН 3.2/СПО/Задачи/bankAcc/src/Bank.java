
public class Bank 
{

	private final double accounts[];
	
	public Bank(int n, double initBalance)
	{
				
		accounts = new double[n];
		for(int i = 0; i < accounts.length; i++)
			accounts[i] = initBalance;
	
	}
	
	public void transfer(int from, int to, double amnt) 
	{
		
		if (accounts[from] < amnt) return;
		
		accounts[from] -= amnt;
		System.out.printf("%s: %.2f from %d to %d\n", Thread.currentThread().getName(), amnt, from, to);
		accounts[to] += amnt;
		
		System.out.printf("%s: Total bank balance: %.2f\n\n", Thread.currentThread().getName(), getTotalBalance());
		
	}
	
	public double getTotalBalance() 
	{
		
		double res = 0.0;
		
		for(int i = 0; i < accounts.length; i++)
			res += accounts[i];

		return res;
		
	}
	
	public int size()
	{
		return accounts.length;
	}
	
}
