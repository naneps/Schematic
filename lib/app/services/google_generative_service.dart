import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GoogleGenerativeService extends GetxService {
  String coreSystemInstruction =
      'You are an AI that generates content based on user requests in the form of API-style JSON responses. You should follow these specifications:\n\n- If the user provides a valid prompt, return a success response in the following format:\n  ```json\n  {\n    "success": true,\n    "data": [\n      ...{data}\n    ],\n    "message": "Data retrieved successfully.",\n    "status": 200\n  }\n  ```\n\n- If the user provides an nvalid prompt or one that is out of context, return an error response in the following format:\n  ```json\n  {\n    "success": false,\n    "data": [],\n    "message": "Invalid request. Please provide a valid prompt.",\n    "status": 400\n  }\n  ```\n\n#### Example of Valid Prompts:\n\n1.  Prompt: `Generate Dummy Product`\n   - Provide dummy product data with fields: `id:string`, `name:string`, `price:int`, `category:object->{id:string, name:string}`.\n\n2. Prompt: `field {id:string, name:string, price:int, category:object->{id:string, name}}`\n   - Provide multiple dummy entries in the format specified by the user.\n\n#### Example Responses for Valid Prompts:\n\n1. **Prompt**: `Generate Dummy Product`\n   ```json\n   {\n     "success": true,\n     "data": [\n       {\n         "id": "prod_01",\n         "name": "Wireless Mouse",\n         "price": 25000,\n         "category": {\n           "id": "cat_01",\n           "name": "Electronics"\n         }\n       },\n       {\n         "id": "prod_02",\n         "name": "Bluetooth Headset",\n         "price": 50000,\n         "category": {\n           "id": "cat_02",\n           "name": "Accessories"\n         }\n       }\n     ],\n     "message": "Products retrieved successfully.",\n     "status": 200\n   }\n   ```\n\n2. **Prompt**: `field {id:string, name:string, price:int, category:object->{id:string, name}}`\n   ```json\n   {\n     "success": true,\n     "data": [\n       {\n         "id": "prod_01",\n         "name": "Wireless Keyboard",\n         "price": 30000,\n         "category": {\n           "id": "cat_03",\n           "name": "Electronics"\n         }\n       },\n       {\n         "id": "prod_02",\n         "name": "Gaming Mouse",\n         "price": 75000,\n         "category": {\n           "id": "cat_03",\n           "name": "Electronics"\n         }\n       }\n     ],\n     "message": "Products retrieved successfully.",\n     "status": 200\n   }\n   ```\n\nExample Response for Invalid Prompts:\n\n1. **Prompt**: `Invalid Prompt`\n   ```json\n   {\n     "success": false,\n     "data": [],\n     "message": "Invalid request. Please provide a valid prompt.",\n     "status": 400\n   }\n   ```\n\nExplanation:\n- **success**: Indicates whether the request was successful (`true`) or failed (`false`).\n- **data**: Contains dummy data in case of success, or an empty array if there’s an error.\n- **message**: Displays a success or error message explaining the result of the request.\n- **status**: HTTP status code, `200` for success, and `400` (or others) for errors.\n\n';
  String fieldSystemInstruction =
      '### System Instruction:\n\nYou are an AI specialized in optimizing user prompts for data generation.\n\nThe user will provide a prompt in the form of an exclamatory sentence requesting data, such as information about cars, sales, products, books, dishes, or other related topics.\n\nYour task is to:\n\n1. Parse the prompt to identify key entities and infer relevant fields.\n2. Generate appropriate fields in the following format:\n   - Each field must include an `ID`, `key`, `type`, `description`, and a `subtype` (if applicable).\n   - For fields of type `array`, specify the `subtype` (e.g., "array of object", "array of string").\n   - For nested structures (object or array of objects), generate corresponding subfields.\n   - Ensure that subfields are only generated for fields with type `object` or `array of object`.\n3. If the field type is **not** `object` or `array of object`, leave the `subFields` empty.\n4. Return the generated fields in JSON format.\n\n### Example Flow:\n\n**User Prompt**:  \n`Give me a list of popular Korean dishes with their ingredients and cooking instructions.`\n\n**Generated Response**:\n```json\n{\n  "success": true,\n  "data": [\n    {\n      "id": "field_001",\n      "key": "dish_name",\n      "type": "string",\n      "description": "Name of the Korean dish",\n      "subFields": []\n    },\n    {\n      "id": "field_002",\n      "key": "ingredients",\n      "type": "array",\n      "description": "List of ingredients required for the dish",\n      "subtype": "object",\n      "subFields": [\n        {\n          "id": "sub_field_001",\n          "key": "ingredient_name",\n          "type": "string",\n          "description": "Name of the ingredient"\n        },\n        {\n          "id": "sub_field_002",\n          "key": "quantity",\n          "type": "number",\n          "description": "Quantity of the ingredient"\n        }\n      ]\n    },\n    {\n      "id": "field_003",\n      "key": "cooking_instructions",\n      "type": "array",\n      "description": "Step-by-step instructions to cook the dish",\n      "subtype": "string",\n      "subFields": []\n    }\n  ],\n  "message": "Fields generated successfully.",\n  "status": 200\n}\n```\n\n### Invalid Prompt Example:\n\n**User Prompt**:  \n`Please give me everything you have on design.`\n\n**Generated Response**:\n```json\n{\n  "success": false,\n  "data": [],\n  "message": "Invalid request. Please provide a valid prompt.",\n  "status": 400\n}\n```\n\n### Note:\n\n- **Subfields** are only generated for fields with type `object` or `array of object`.\n- If the type is `array`, its `subtype` defines the type of elements within the array (e.g., `array of string`, `array of object`).\n- If the type is **not** `object` or `array of object`, ensure that `subFields` is an empty array.\n- The generated fields must be descriptive, clear, and structured based on the context of the user\'s prompt.\n\n';

  Future<String> enhancePrompt(String prompt) async {
    String output = await generate(
      prompt,
      maxTokens: 200,
      temperature: 0,
      systemInstruction:
          'You are an AI that optimizes user prompts.\n\nIn this context, the prompts provided by users are exclamatory sentences for generating data, such as information about cars, sales, products, books, and other related topics.\n\nYour task is to enhance the user\'s default prompts for clarity and descriptiveness. For example, transform the incorrect input "I need a data book" into a clearer format like "I need book data from Indonesia with details such as title, author, etc."\n\nThe output should be a single or double, concise exclamatory sentence, not a question',
    );
    return output;
  }

  Future<String> generate(
    String prompt, {
    int maxTokens = 100,
    int temperature = 0,
    String? systemInstruction,
    String? responseMimeType = 'text/plain',
  }) async {
    String output = '';

    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      //   apiKey: "AIzaSyBWTtO8ws1Vy46kDgujZvjnbwrUwxLUpXI",
      apiKey: "AIzaSyBxymxe8qiQQfJhP0B_jaG9AIaDP19Qs0w",
      //   apiKey: "AIzaSyBXQdMOoqoWx7CBNlIfqdGTX4r7VCGXeLM",
      systemInstruction: Content.system(systemInstruction ?? ''),
    );

    final content = [Content.text(prompt)];

    await model.generateContentStream(
      content,
      generationConfig: GenerationConfig(
        temperature: temperature.toDouble(),
        maxOutputTokens: maxTokens,
        responseMimeType: responseMimeType,
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      ],
    ).listen((event) {
      if (event.text != null) {
        output += event.text!;
      }
    }).asFuture();

    return output;
  }

  Future<String> generateData(String prompt) async {
    return generate(
      prompt,
      maxTokens: 10000,
      systemInstruction: coreSystemInstruction,
    );
  }

  Future<String> generateFields(String prompt) async {
    return generate(
      prompt,
      maxTokens: 10000,
      systemInstruction: fieldSystemInstruction,
      responseMimeType: 'application/json',
    );
  }
}
