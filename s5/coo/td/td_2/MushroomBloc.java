package td_2;

public class MushroomBloc extends SimpleBloc {
    public void applyEffect(Player player) {
        super.applyEffect(player);
        player.gainVie(1);
    }
}
