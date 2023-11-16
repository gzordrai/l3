package td_2;

public class SimpleBloc implements Bloc {

    @Override
    public void applyEffect(Player player) {
        player.gainPieces(1);
    }
    
}
