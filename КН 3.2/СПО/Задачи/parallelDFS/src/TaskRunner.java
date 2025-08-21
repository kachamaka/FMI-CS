import java.util.Calendar;

/**
 * 
 */

/**
 * @author lisp
 *
 */
public class TaskRunner {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		int i;

		if (args.length < 2) {
			
			System.out.println("TaskRunner <num of elements> <num of threads>");
			System.exit(1);
			
		}

		int el_count = new Integer(args[0]);
		int thread_count = new Integer(args[1]);

		Graph g = new Graph(el_count, thread_count);
		g.populateEdges();
		// g.dumpGraph();
		
		Thread tr[] = new Thread[thread_count];
		
		long ts_b = Calendar.getInstance().getTimeInMillis();
		for(i = 0; i < thread_count; i++) {
			DFSRunnable r = new DFSRunnable(g);
			tr[i] = new Thread(r);
		}
		
		for(i = 0; i < thread_count; i++) tr[i].start();
		
		for(i = 0; i < thread_count; i++) {
			try {
				tr[i].join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		long ts_e = Calendar.getInstance().getTimeInMillis();
		
		// g.dumpVisited();
		
		System.out.println(ts_e - ts_b);
		

	}

}
