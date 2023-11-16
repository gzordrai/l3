package fil.l3.coo.station.model;

import java.util.ArrayList;
import java.util.List;

import fil.l3.coo.station.observer.Observer;
import fil.l3.coo.station.observer.Subject;

public class ControlCenter implements Observer {
    private List<Subject> subjects;

    public ControlCenter() {
        this.subjects = new ArrayList<Subject>();
    }

    @Override
    public void addSubject(Subject subject) {
        this.subjects.add(subject);
    }

    @Override
    public void update() {
        // TODO Auto-generated method stub
    }
}
