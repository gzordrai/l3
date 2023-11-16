package fil.l3.coo.station.observer;

import java.util.ArrayList;
import java.util.List;

public abstract class Subject {
    protected List<Observer> observers;

    public Subject() {
        this.observers = new ArrayList<Observer>();
    }

    /**
     * Adds an observer to the list of subscribers.
     *
     * @param observer the observer to add to the list of subscribers
    */
    public void subscribe(Observer observer) {
        this.observers.add(observer);
        observer.addSubject(this);
    }

    /**
     * Removes an observer from the list of subscribers.
     *
     * @param observer the observer to remove from the list of subscribers
     */
    public void unsubscribe(Observer observer) {
        this.observers.remove(observer);
    }

    /**
     * Notifies all subscribers that the subject has been updated.
     */
    public void notifyObservers() {
        for (Observer observer : this.observers) {
            observer.update();
        }
    }
}
