/**
 * 
 */

/**
 * @author lisp
 *
 */
public class DFSRunnable implements Runnable {

	private Graph g;
	
	public DFSRunnable(Graph g) {
		
		this.g = g;
		
	}
	
	public void run() {
	
		int i, k;
		int iWillVisit = 0;
		
		while (true) {
			
			try {
				g.nv_count.acquire();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}

			if (g.gCount == g.v) break;
			
			k = g.nv.pop();
			
			int j = k % g.NUM_LOCKS;
			g.locks[j].lock();
			if (g.visited[k] == 0) {
				
				g.visited[k] = 1;
				iWillVisit = 1;
				
				g.gCountLock.lock(); // to be sure no one else is incrementing this;
				g.gCount++;
				g.gCountLock.unlock();
				
			}
			g.locks[j].unlock();
			
			if (iWillVisit == 1) {
				
				for(i = 0; i < g.v; i++) {
					
					int semCount = 0;
					if (g.adj[k][i] == 1) {
						g.nv.push(i);
						semCount++;
					}
					
					if (semCount > 0) g.nv_count.release(semCount);
					
				}
				
				iWillVisit = 0;
				
			}
			
		}

	}

}
