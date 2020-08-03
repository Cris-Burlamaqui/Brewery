# Brewery
 Engineering - Code Challenge
 
 **To run the application:**

- To run the application it's necessary an iPhone or a XCode simulator running with iOS version 13.6 or higher.
- To use real device you must assign a team development on the Signing and Capabilities tab, than execute the step before choosing your device.
- To load a batch of beer types click on ![](image/load.png)


**Architectural decisions**

- For this challenge I decided to use SwiftUI for the reason that:
    - there wasn't any dependency of older iOS versions;
    - it's faster to implement designs, ideas and concepts;
    - and its live preview makes any kind of change easier to test.
- The architecture used was MVVM dividing model, view and view model responsabilities.
- The models objects were developed using ObservableObject protocol so when their values change they will be reflected in all views. Consequently the user interface will be updated with the correct values.
- As a result of the previous item the Codable protocol couldn’t be used because of its limitation of being implemented only in scructure objects. 
- This meant a further work to parse the data since it was necessary to use JSONSerialization intead of JSONDecoder.

**Unit testing**

- The unit testing was based on view model class BeerTypeBatchModel. There're two tests for possible solutions to make customers happy and more two for no solution.
