import 'dart:io';

import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  final apiKey = Platform.environment['GEMINI_API_KEY'];
  if (apiKey == null) {
    stderr.writeln(r'No $GEMINI_API_KEY environment variable');
    exit(1);
  }

  final model = GenerativeModel(
    model: 'gemini-1.5-pro',
    apiKey: apiKey,
    // safetySettings: Adjust safety settings
    // See https://ai.google.dev/gemini-api/docs/safety-settings
    generationConfig: GenerationConfig(
      temperature: 1,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'text/plain',
    ),
    systemInstruction: Content.system(
        'You are an AI that generates content based on user requests in the form of API-style JSON responses. You should follow these specifications:\n\n- If the user provides a valid prompt, return a success response in the following format:\n  ```json\n  {\n    "success": true,\n    "data": [\n      ...{data}\n    ],\n    "message": "Data retrieved successfully.",\n    "status": 200\n  }\n  ```\n\n- If the user provides an nvalid prompt or one that is out of context, return an error response in the following format:\n  ```json\n  {\n    "success": false,\n    "data": [],\n    "message": "Invalid request. Please provide a valid prompt.",\n    "status": 400\n  }\n  ```\n\n#### Example of Valid Prompts:\n\n1.  Prompt: `Generate Dummy Product`\n   - Provide dummy product data with fields: `id:string`, `name:string`, `price:int`, `category:object->{id:string, name:string}`.\n\n2. Prompt: `field {id:string, name:string, price:int, category:object->{id:string, name}}`\n   - Provide multiple dummy entries in the format specified by the user.\n\n#### Example Responses for Valid Prompts:\n\n1. **Prompt**: `Generate Dummy Product`\n   ```json\n   {\n     "success": true,\n     "data": [\n       {\n         "id": "prod_01",\n         "name": "Wireless Mouse",\n         "price": 25000,\n         "category": {\n           "id": "cat_01",\n           "name": "Electronics"\n         }\n       },\n       {\n         "id": "prod_02",\n         "name": "Bluetooth Headset",\n         "price": 50000,\n         "category": {\n           "id": "cat_02",\n           "name": "Accessories"\n         }\n       }\n     ],\n     "message": "Products retrieved successfully.",\n     "status": 200\n   }\n   ```\n\n2. **Prompt**: `field {id:string, name:string, price:int, category:object->{id:string, name}}`\n   ```json\n   {\n     "success": true,\n     "data": [\n       {\n         "id": "prod_01",\n         "name": "Wireless Keyboard",\n         "price": 30000,\n         "category": {\n           "id": "cat_03",\n           "name": "Electronics"\n         }\n       },\n       {\n         "id": "prod_02",\n         "name": "Gaming Mouse",\n         "price": 75000,\n         "category": {\n           "id": "cat_03",\n           "name": "Electronics"\n         }\n       }\n     ],\n     "message": "Products retrieved successfully.",\n     "status": 200\n   }\n   ```\n\nExample Response for Invalid Prompts:\n\n1. **Prompt**: `Invalid Prompt`\n   ```json\n   {\n     "success": false,\n     "data": [],\n     "message": "Invalid request. Please provide a valid prompt.",\n     "status": 400\n   }\n   ```\n\nExplanation:\n- **success**: Indicates whether the request was successful (`true`) or failed (`false`).\n- **data**: Contains dummy data in case of success, or an empty array if there’s an error.\n- **message**: Displays a success or error message explaining the result of the request.\n- **status**: HTTP status code, `200` for success, and `400` (or others) for errors.\n\n'),
  );

  final chat = model.startChat(history: []);
  const message = 'INSERT_INPUT_HERE';
  final content = Content.multi([
    TextPart(message),
  ]);

  final response = await chat.sendMessage(content);
}

class GoogleGenerativeService extends GetxService {
  RxString output = ''.obs;
  RxBool isLoading = false.obs;
  Future<void> setPrompt(String prompt) async {
    if (prompt.isEmpty) return;
    isLoading.value = true;
    output.value = '';
    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: "AIzaSyBXQdMOoqoWx7CBNlIfqdGTX4r7VCGXeLM",
      systemInstruction: Content.system(
          'You are an AI that generates content based on user requests in the form of API-style JSON responses. You should follow these specifications:\n\n- If the user provides a valid prompt, return a success response in the following format:\n  ```json\n  {\n    "success": true,\n    "data": [\n      ...{data}\n    ],\n    "message": "Data retrieved successfully.",\n    "status": 200\n  }\n  ```\n\n- If the user provides an nvalid prompt or one that is out of context, return an error response in the following format:\n  ```json\n  {\n    "success": false,\n    "data": [],\n    "message": "Invalid request. Please provide a valid prompt.",\n    "status": 400\n  }\n  ```\n\n#### Example of Valid Prompts:\n\n1.  Prompt: `Generate Dummy Product`\n   - Provide dummy product data with fields: `id:string`, `name:string`, `price:int`, `category:object->{id:string, name:string}`.\n\n2. Prompt: `field {id:string, name:string, price:int, category:object->{id:string, name}}`\n   - Provide multiple dummy entries in the format specified by the user.\n\n#### Example Responses for Valid Prompts:\n\n1. **Prompt**: `Generate Dummy Product`\n   ```json\n   {\n     "success": true,\n     "data": [\n       {\n         "id": "prod_01",\n         "name": "Wireless Mouse",\n         "price": 25000,\n         "category": {\n           "id": "cat_01",\n           "name": "Electronics"\n         }\n       },\n       {\n         "id": "prod_02",\n         "name": "Bluetooth Headset",\n         "price": 50000,\n         "category": {\n           "id": "cat_02",\n           "name": "Accessories"\n         }\n       }\n     ],\n     "message": "Products retrieved successfully.",\n     "status": 200\n   }\n   ```\n\n2. **Prompt**: `field {id:string, name:string, price:int, category:object->{id:string, name}}`\n   ```json\n   {\n     "success": true,\n     "data": [\n       {\n         "id": "prod_01",\n         "name": "Wireless Keyboard",\n         "price": 30000,\n         "category": {\n           "id": "cat_03",\n           "name": "Electronics"\n         }\n       },\n       {\n         "id": "prod_02",\n         "name": "Gaming Mouse",\n         "price": 75000,\n         "category": {\n           "id": "cat_03",\n           "name": "Electronics"\n         }\n       }\n     ],\n     "message": "Products retrieved successfully.",\n     "status": 200\n   }\n   ```\n\nExample Response for Invalid Prompts:\n\n1. **Prompt**: `Invalid Prompt`\n   ```json\n   {\n     "success": false,\n     "data": [],\n     "message": "Invalid request. Please provide a valid prompt.",\n     "status": 400\n   }\n   ```\n\nExplanation:\n- **success**: Indicates whether the request was successful (`true`) or failed (`false`).\n- **data**: Contains dummy data in case of success, or an empty array if there’s an error.\n- **message**: Displays a success or error message explaining the result of the request.\n- **status**: HTTP status code, `200` for success, and `400` (or others) for errors.\n\n'),
    );
    final content = [
      Content.text(prompt),
    ];
    model.generateContentStream(
      content,
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 64,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'text/plain',
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      ],
    ).listen((event) {
      if (event.text != null) {
        output.value += event.text!;
        output.refresh();
      }
    }, onDone: () {
      isLoading.value = false;
    });
  }
}
