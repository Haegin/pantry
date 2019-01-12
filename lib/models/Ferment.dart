import 'package:pantry/models/Recipe.dart' as R;

class InvalidStepError extends Error {
  InvalidStepError() : super();
}

class FermentStep {
  bool completed = false;

  FermentStep(this.completed);
  factory FermentStep.convert(R.RecipeStep base) {
    var type = base.runtimeType;
    switch (type) {
      case R.TimeStep:
        return TimeStep.convert(base);
      case R.TaskStep:
        return TaskStep.convert(base);
      default:
        throw InvalidStepError();
    }
  }
}

class TimeStep extends FermentStep {
  Duration time;

  TimeStep(this.time, bool completed) : super(completed);
  TimeStep.convert(R.TimeStep base) : super(false) {
    this.time = base.time;
  }
}

class TaskStep extends FermentStep {
  String description;

  TaskStep(this.description, bool completed) : super(completed);
  TaskStep.convert(R.TaskStep base) : super(false) {
    this.description = base.description;
  }
}

class Ferment {
  String name;
  List<FermentStep> steps;

  Ferment(String name, R.Recipe recipe) {
    this.name = name;
    this.steps = recipe.steps.map((step) {
      return FermentStep.convert(step);
    }).toList();
  }
}
