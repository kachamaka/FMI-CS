import java.util.Random;
import java.util.Scanner;


public class homework1 {

	public static  void main(String [] args){
		
		Scanner scan = new Scanner(System.in);
		long times = scan.nextLong();
		int goodTimes = 0;
		for(int j = 0; j < times; j++){
			int [] week = {0,0,0,0,0,0,0};
			Random random = new Random();
			for (int i = 0; i < 12; i++) {
				week[random.nextInt(7)] ++;
			}
			if (week[0]!=0 && week[1]!=0 && week[2]!=0 && week[3]!=0
				&& week[4]!=0 && week[5]!=0 && week[6]!=0 ){
				goodTimes++;
			}
		}
		
		System.out.println(goodTimes + "\n" + (double) goodTimes/times);
		
	}
}
