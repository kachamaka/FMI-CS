
import java.util.concurrent.locks.ReentrantLock;


public class BubbleRunnable implements Runnable {
	
	GlobalNum g;
	ReentrantLock cl[];
	long a[];
	
	int size;
	
	boolean done;
	boolean exch;
	
	public BubbleRunnable(GlobalNum g, ReentrantLock cl[], long a[], int size) {
		
		this.g = g; // global "gave to sort" elements count
		this.cl = cl; // chunk lock (critical section locks)
		this.a = a; // array of elements to sort;
		
		this.size = size; // chunk size;
		
		this.done = false; // have we done?
		this.exch = false; // do we have exchange?
		
	}
	
	public void run() {
		
		int i, j, k, rel_pt;
		long temp;
		
		while (!done) {
			
			k = 0; // every thread starts from critical section 0;
			exch = false; // no exchange

			cl[k].lock(); // taking lock for current critical section;
			i = g.n --; // in this iteration we'll take one element on top;
			rel_pt = size; // what is our release point?
			
			if (i <=0 ) { // if no elements to sort, we are done.
				done = true;
				cl[k].unlock();
				break;
			}
			
			for(j = 0; j < i; j++) { // making internal iteration
				
				if (a[j] > a[j+1]) { // do we have to change these two?
					temp = a[j]; a[j] = a[j+1]; a[j+1] = temp;
					exch = true;
				}
			
				if (j == rel_pt) { // are we over release point?
					cl[k].unlock();
					k++; // moving one step further?
					cl[k].lock(); // acquiring critical section lock.
					rel_pt += size; // generating next release point.
				}
				
			}
			
			cl[k].unlock(); // unlocking final critical section;
			if (!exch) done = true; // if no exchange is done, then we are done
			
		}

	}

}
