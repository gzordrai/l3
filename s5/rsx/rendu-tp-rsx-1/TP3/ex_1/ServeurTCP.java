import java.net.*;
import java.io.*;
import java.lang.String;

public class ServeurTCP{

    public static void main(String[] args) throws IOException{
        try{
            ServerSocket sose;
            Socket s;
            sose = new ServerSocket(2023);
            while(true){
            s = sose.accept();
            System.out.println("Connexion depuis " + s.getInetAddress());
                PrintStream out = new PrintStream(s.getOutputStream());
                out.println("Bienvenue sur mon serveur et au revoir");
                s.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}