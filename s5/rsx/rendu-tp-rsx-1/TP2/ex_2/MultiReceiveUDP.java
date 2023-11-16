import java.net.DatagramPacket;
import java.net.MulticastSocket;
import java.net.NetworkInterface;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.io.IOException;
import java.lang.String;

public class MultiReceiveUDP{

    public static void main(String[] args) throws NumberFormatException, IOException {
        String msg;
        InetSocketAddress addr = new InetSocketAddress(InetAddress.getByName(args[1]), 0);
        MulticastSocket ms = new MulticastSocket(Integer.parseInt(args[0]));
        DatagramPacket p = new DatagramPacket(new byte[6500], 6500);
        NetworkInterface netIf = NetworkInterface.getByName("eth0");

        ms.joinGroup(addr, netIf);
        ms.receive(p);
        msg = new String(p.getData());
        System.out.println(msg);
        ms.leaveGroup(addr, netIf);
    }
}