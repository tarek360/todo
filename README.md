# To-Do List App ReadMe

This ReadMe file provides an overview of the To-Do List app, including its architecture, state management, UI/UX design
choices, testing approach, and potential improvements.

## App Architecture

The To-Do List app follows the **MVVM (Model-View-ViewModel)** architecture pattern. This architectural choice helps in
separating concerns and maintaining a clean and structured codebase:

- **Model**: Represents the underlying data structures and business logic. In this app, the model includes data entities
  like `ToDo` and `TodoEntity`, as well as the `TodosRepository` for data access.

- **View**: Represents the user interface (UI) components and layout. Flutter widgets are used for creating the UI
  components, such as the To-Do list and the bottom sheet for viewing long text.

- **ViewModel**: Serves as the intermediary between the View and the Model. The `TodoListViewModel` manages the state of
  the To-Do list and provides data to the View. It also handles interactions, such as adding new To-Do items and
  retrying data fetch operations.

## State Management

State management in the app is achieved using **Riverpod**, a state management library for Flutter. Riverpod is used to
create and manage providers, which are responsible for providing data to various parts of the app. Key providers
include `todoListViewModelProvider` for managing the state of the To-Do list and `onItemInsertedProvider` for tracking
newly added items.

## Testing & Quality

The app includes a testing strategy, covering both unit tests and widget tests:

- **Unit Tests**: These tests focus on the `TodoListViewModel` class, which manages the state and behavior of the To-Do
  list. Unit tests verify that the ViewModel functions correctly in scenarios like data fetching, error handling, item
  addition, and retrying.

- **Widget Tests**: Widget tests ensure that the app's UI components look and interact as expected. They validate that
  widgets render correctly and that user interactions produce the intended results.

- **Robust Data Handling**: The app handles corrupted or unexpected data. It filters out incomplete items, ensuring that
  only valid
  To-Do items are displayed. Moreover, in the case of an empty data response, the app presents a user-friendly message
  and an action button, ensuring a seamless experience. This robust data handling guarantees a smooth and reliable user
  interface, free from disruptions caused by data anomalies.

## UI/UX Design

### Simple UI:

The app features a clean and straightforward user interface. Users can view a list of their To-Do items, and a bottom
sheet provides a scrollable view for reading long text associated with each item.

### Smooth Animation:

To enhance the user experience when adding new To-Do items, the app incorporates a smooth animation that indicates where
the newly added item is within the list. This animation makes it easier for users to identify the addition.

### Haptic Feedback:

The app provides haptic feedback upon adding a new To-Do item. This feedback enhances the tactile experience of using
the app and provides a subtle confirmation of task completion.

### Text Truncation:

To ensure a consistent and user-friendly UI, the app limits the display of each To-Do item to a maximum of two lines of
text. This design choice ensures that users can always see other items in the list and easily read the item titles.

### Bottom Sheet:

For To-Do items with long descriptions, users can tap on an item to view the entire text in a scrollable bottom sheet.
This design approach prevents UI clutter while allowing users to access detailed information when needed.

### Potential Improvements

While the app serves as a case study and demonstrates key concepts, there are areas for potential improvement in a
real-world application:

- **Persistence**: Currently, the app stores To-Do items only in memory. In a production app, implementing disk caching
  or connecting to a server for data storage and synchronization would be essential.

- **Server Integration**: The app ignores fields like `ID` and `UserID` in To-Do items from the dummy API. In a real
  app, these fields could be used for features like editing or assigning tasks to specific users.

- **Error Handling**: Enhancing error handling to cover various error types, such as network issues or server errors,
  would provide users with more informative error messages.

- **Integration Tests**: Consider adding integration tests to verify that all app components, including widgets and
  services, work seamlessly together in a real-world scenario.

This To-Do List app is a valuable learning exercise that showcases MVVM architecture, Riverpod state management, and
thoughtful UI/UX design. It provides a foundation for building a feature-rich and robust productivity application.