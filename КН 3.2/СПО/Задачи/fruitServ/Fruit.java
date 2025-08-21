import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Fruit extends Remote {

	String getNextFruit() throws RemoteException;
	boolean	isDone() throws RemoteException;
	
}
