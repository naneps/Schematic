
---

# SchemaMatic

**SchemaMatic** is a web-based application that leverages AI technology to automatically generate dummy data based on user-entered prompts. It is designed to simplify the process of creating mock data for developers, researchers, and other users for testing, development, or simulation purposes.

## Key Features

- **AI-Powered Prompt Input**: Use AI models like Gemini to generate dummy data simply by providing a prompt.
- **Tabular Data Display**: The generated data is immediately displayed in an easy-to-read table format.
- **Download JSON Schema**: Download the generated data in JSON schema format, making it easy to integrate with APIs and other applications.
- **Preset Prompts**: Offers example prompts to help users get started with generating dummy data.
- **Customizable Data**: Users can modify the structure and columns of the data to fit their specific needs.

## Technology Stack

- **Flutter Web**: For a responsive and interactive frontend.
- **Gemini AI**: Used to process prompts and generate dummy data on demand.

## How to Use

1. **Enter Prompt**: Users provide a prompt that describes the type of data they need.
2. **Generate Data**: The application sends the prompt to the AI to generate dummy data.
3. **View Results in a Table**: The generated data is displayed in a customizable table format.
4. **Download JSON Schema**: Click the download button to export the data as a JSON schema ready for integration with other APIs.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/schematic.git
   cd schematic
   ```

2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Run the Flutter project in the web:
   ```bash
   flutter run -d chrome
   ```


## Roadmap

- **Custom API Integration**: Add the ability to dynamically store and manage preset prompts.
- **Support for Multiple Data Formats**: Provide export options for other formats such as CSV or XML.
- **User Authentication**: Implement a user authentication system to save generated prompts and results.
- **Real-Time API Response Simulation**: Introduce a feature to simulate real-time API responses for development testing.

## Contributions

Contributions are welcome! If you would like to contribute, feel free to submit a pull request or open an issue for discussion.

---

