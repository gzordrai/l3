package src;
public class Express extends Air {
    public Express(int distance) {
        super(distance);
    }

    @Override
    public int cost() {
        return super.cost() * 2;
    }
}
