package td_2;

public class PoisonBloc implements Bloc {

    @Override
    public void applyEffect(Player player) {
        player.gainVie(-1);
    }
    
}
