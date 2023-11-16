import java.net.MulticastSocket;
import java.net.NetworkInterface;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.io.IOException;
import java.lang.String;

public class MultiSendUDP {

    public static void main(String[] args) throws IOException {
        MulticastSocket ms = new MulticastSocket();
        DatagramPacket p;
        String msg = args[2];
        String machine = args[0];
        byte[] buffer = msg.getBytes();
        InetAddress dst = InetAddress.getByName(machine);
        InetSocketAddress addr = new InetSocketAddress(dst, 0);
        int dstPort = Integer.parseInt(args[1]);
        NetworkInterface netIf = NetworkInterface.getByName("eth0");
        p = new DatagramPacket(buffer, buffer.length, dst, dstPort);

        ms.joinGroup(addr, netIf);
        ms.send(p);
        ms.close();
    }
}