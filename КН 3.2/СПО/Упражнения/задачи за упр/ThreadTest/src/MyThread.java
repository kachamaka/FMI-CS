import java.lang.*;
import java.util.Random;
public class MyThread implements Runnable {
	
	     private String mName;
	     private long mTimeInterval;

	     public MyThread(String aName) {
	         mName = aName;
	     }
	     

	     public void run() {
	    	 System.out.println("aaaaa");
	        
	         
	     }
	 

	
	
	     public static void main(String[] args) {
	         /*MyThread thread1 = new MyThread("thread 1", 1000);
	         MyThread thread2 = new MyThread("thread 2", 2000);
	         MyThread thread3 = new MyThread("thread 3", 1500);
	         thread1.start();
	         thread2.start();
	         thread3.start();
	         for (int i = 0; i <5; i++) {
				MyThread th = new MyThread("thread" + i, 1000);
				th.start();
			}*/
	    MyThread t = new MyThread("Tread");
	    t.run();
	 }

}
