package TP2.ex_1;

import java.io.IOException;
import java.lang.String;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.DatagramPacket;

class SendUDP {
    public static void main(String[] args) throws IOException {
        DatagramSocket socket = new DatagramSocket();
        String message = args[2];
        byte[] buffer = message.getBytes();
        InetAddress destination = InetAddress.getByName(args[0]);
        int port = Integer.parseInt(args[1]);
        DatagramPacket packet = new DatagramPacket(buffer, buffer.length, destination, port);

        socket.send(packet);
        socket.close();
    }
}