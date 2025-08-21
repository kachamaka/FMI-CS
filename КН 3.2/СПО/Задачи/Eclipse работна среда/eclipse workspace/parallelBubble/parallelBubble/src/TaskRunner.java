import java.util.Calendar;
import java.util.concurrent.locks.ReentrantLock;

/**
 * @author lisp
 *
 */

public class TaskRunner {

	static final int MAX_RANDOM_NUM = 1000000;
	
	public static void main(String[] args) {
		
		// local index variable;
		int i;
		
		// do we have to dump our raw and sorted data?
		boolean dump = false;
		
		// enough arguments in command line?
		if (args.length < 2) {
			
			System.out.println("TaskRunner <num of elements> <num of threads>");
			System.exit(1);
			
		}
		
		// if we have three arguments then, may be the third one is a dump request?
		if ( args.length == 3 && args[2].compareTo("-dump") == 0 ) dump = true;

		long ts_b, ts_e;

		int el_count = new Integer(args[0]);
		int thread_count = new Integer(args[1]);

		// every chunk of array has that many elements
		int chunk_size = el_count / thread_count;
	
		// making thread pool, to wait for
		Thread tr[] = new Thread[thread_count];

		// global number showing how meny elements we have to sort
		GlobalNum gn = new GlobalNum(el_count - 1);
		
		// making critical sections pool
		ReentrantLock cl[];
		if (el_count % thread_count == 0) { // if we have no reminder  
			cl = new ReentrantLock[thread_count];
	 		for(i = 0; i < thread_count; i++) cl[i] = new ReentrantLock();
		} else { // reminder makes one more critical secttion;
			cl = new ReentrantLock[thread_count + 1];
	 		for(i = 0; i < thread_count+1; i++) cl[i] = new ReentrantLock();
		}
		
		long a[] = new long[el_count];
		
		// populating raw data if requested
		ts_b = Calendar.getInstance().getTimeInMillis();
		for(i = 0; i < el_count; i++) {
			a[i] = (int) (Math.random() * MAX_RANDOM_NUM);
		}
		ts_e = Calendar.getInstance().getTimeInMillis();
		
		System.out.println("populating a[] finished in: " + (ts_e - ts_b) + " ms");
		
		// dumping raw data if requested
		if (dump) {
			for (i = 0; i < el_count; i++)
				System.out.printf("%8d", a[i]);
			System.out.printf("\n");
		}

		// making actual work
		ts_b = Calendar.getInstance().getTimeInMillis();

  		for(i = 0; i < thread_count; i++) {

			BubbleRunnable r = new BubbleRunnable(gn, cl, a, chunk_size);
			tr[i] = new Thread(r);
			tr[i].start();
			
		}
  		
  		// waiting threads to finish
		for(i = 0; i < thread_count; i++) {
			
			try {
				
				tr[i].join();
				
			} catch (InterruptedException e) {
				
			}
			
		}

		ts_e = Calendar.getInstance().getTimeInMillis();

		System.out.println("job finished in: " + (ts_e - ts_b) + " ms");

		// dumping sorted data if requested
		if (dump) {
			for (i = 0; i < el_count; i++)
				System.out.printf("%8d", a[i]);
			System.out.printf("\n");
		}
		
	}

}
