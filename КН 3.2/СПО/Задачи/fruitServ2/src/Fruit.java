import java.rmi.Remote;
import java.rmi.RemoteException;


public interface Fruit extends Remote {
	
	void getNextCalc(Notify n) throws RemoteException;
	
	String getFruit() throws RemoteException;

}
