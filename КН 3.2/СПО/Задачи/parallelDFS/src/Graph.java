import java.util.Stack;
import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.ReentrantLock;

/**
 * 
 */

/**
 * @author lisp
 *
 */
public class Graph {

	public final int NUM_LOCKS;

	public ReentrantLock locks[];
	
	public Semaphore nv_count;
	public Stack<Integer> nv;
	public int gCount;
	public ReentrantLock gCountLock;
	
	public int v;
	public int adj[][];
	public int visited[];

	public int thread_count;
	
	public Graph(int vertices, int thread_count) {
		
		int i;
	
		this.thread_count = thread_count;
		
		v = vertices;
		adj = new int[v][v];
		visited = new int[v]; 
		
		nv_count = new Semaphore(v);
		nv = new Stack<Integer>();
		gCount = 0;
		gCountLock = new ReentrantLock();
		
		NUM_LOCKS = 2*thread_count;
		
		locks = new ReentrantLock[NUM_LOCKS];
		
		for(i = 0; i < NUM_LOCKS; i++)
			locks[i] = new ReentrantLock();
		
		for(i = v -1; i >= 0; i--)
			nv.push(i);
	}
	
	public void dumpGraph() {
		
		int i,j;
		
		System.out.printf("dumping graph:\n");
		
		for(i = 0; i < v; i++) {
			
			for(j = 0; j < v; j++)
				
				System.out.printf("%3d", adj[i][j]);
			
			System.out.printf("\n");
			
		}
		
	}
	
	public void dumpVisited() {
		
		int i;
		
		System.out.printf("dumping visited:\n");
		for(i = 0; i < v; i++) 
			System.out.printf("%3d", visited[i]);
		System.out.printf("\n");
		
	}
	
	public void populateEdges() {
		
		// going to generate random edges between vertices;
		
		int i, j;
		
		for (i = 0; i < v; i++) { 
			
			// for every vertex, generate N random neighbors
			int neigh_count = (int) (Math.random() * v);
			
			for (j = 0; j < neigh_count; j++) {
				
				int neigh = (int) (Math.random() * v);
				
				adj[i][neigh] = 1;
				
			}
			
		}
		
		
	}
	
}
