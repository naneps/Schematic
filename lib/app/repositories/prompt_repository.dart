import 'package:schematic/app/models/promp.model.dart';

class PromptRepository {
  List<Prompt> prompts = [];
  void addPrompt(Prompt prompt) {
    prompts.add(prompt);
  }
}
