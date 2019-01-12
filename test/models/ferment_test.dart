import "package:test/test.dart";
import "package:pantry/models/Recipe.dart" as R;
import "package:pantry/models/Ferment.dart";

void main() {
  R.Recipe kombucha = R.Recipe("Kombucha", [
    R.TaskStep("Brew the kombucha"),
    R.TimeStep(Duration(days: 7)),
    R.TaskStep("Rack to the secondary"),
    R.TimeStep(Duration(days: 2)),
    R.TaskStep("Bottle"),
    R.TimeStep(Duration(days: 2)),
    R.TaskStep("Drink"),
  ]);

  test("Creating a Ferment", () {
    Ferment ferment = Ferment("Kombucha - 11th Jan 2019", kombucha);

    expect(ferment.steps[0].runtimeType, equals(TaskStep));
    expect((ferment.steps[0] as TaskStep).description,
        equals("Brew the kombucha"));

    expect(ferment.steps[3].runtimeType, equals(TimeStep));
    expect((ferment.steps[3] as TimeStep).time, equals(Duration(days: 2)));
  });
}
