package td_2;

public class DoubleBloc implements Bloc {
    private Bloc bloc;

    public DoubleBloc(Bloc bloc) {
        this.bloc = bloc;
    }

    @Override
    public void applyEffect(Player player) {
        bloc.applyEffect(player);
        bloc.applyEffect(player);
    }
}
