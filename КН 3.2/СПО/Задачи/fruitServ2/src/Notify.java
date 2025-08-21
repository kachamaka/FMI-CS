import java.rmi.Remote;
import java.rmi.RemoteException;


public interface Notify extends Remote {
	void calcDone(String f) throws RemoteException;
}
