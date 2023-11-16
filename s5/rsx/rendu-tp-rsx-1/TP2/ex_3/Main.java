package ex_3;

import java.io.IOException;

public class Main{
    public static void main(String[] args){
        try {
            Thread t = new MulticastReceiver(args[0], Integer.parseInt(args[1]));
            Thread s = new MulticastSender(args[0], Integer.parseInt(args[1]));
            t.start();
            s.start();
        } catch (IOException e){
            e.printStackTrace();
        }
    }
}