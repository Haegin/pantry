class RecipeStep {}

class TimeStep extends RecipeStep {
  Duration time;

  TimeStep(this.time);
}

class TaskStep extends RecipeStep {
  String description;

  TaskStep(this.description);
}

class Recipe {
  String name;
  List<RecipeStep> steps;

  Recipe(this.name, this.steps);
}
