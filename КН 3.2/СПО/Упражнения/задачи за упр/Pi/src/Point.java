
public class Point {
	private static long xCoodrinate;
	private static long yCoodrinate;
	
	Point(long x, long y) {
		xCoodrinate = x;
		yCoodrinate = y;

	}
	
	long getX(){
		return xCoodrinate;
		}
	
	void setX(long x){
		xCoodrinate = x;
		}
	
	long getY(){
		return yCoodrinate;
		}
	
	void setY(long y){
		yCoodrinate = y;
		}
}
