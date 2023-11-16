package td_2;

public class Player {
    private int vie;
    private int resistance;
    private int pieces;

    public Player() {
        this.vie = 1;
        this.resistance = 0;
        this.pieces = 0;
    }


    public void gainVie(int vie) {
        this.vie += vie;
    }

    public void gainResistance(int resistance) {
        this.resistance += resistance;
    }

    public void gainPieces(int pieces) {
        this.pieces += pieces;
    }
}
