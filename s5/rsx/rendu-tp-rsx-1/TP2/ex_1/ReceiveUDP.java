package TP2.ex_1;

import java.io.IOException;
import java.lang.String;
import java.net.DatagramSocket;
import java.net.SocketException;
import java.net.DatagramPacket;

public class ReceiveUDP {
    private DatagramSocket socket;

    public ReceiveUDP(int port) throws SocketException {
        this.socket = new DatagramSocket(port);
    }

    public void listen() throws IOException {
        DatagramPacket packet;

        while (true) {
            packet = new DatagramPacket(new byte[512], 512);
            this.socket.receive(packet);

            System.out.println(
                    "Paquet recu de: " + packet.getAddress() + '\n' +
                            "Port: " + packet.getPort() + '\n' +
                            "Taille: " + packet.getLength() + '\n' +
                            "Message: " + new String(packet.getData()));
        }
    }

    public static void main(String[] args) throws IOException {
        ReceiveUDP server = new ReceiveUDP(Integer.parseInt(args[0]));

        server.listen();
    }
}