# Brewery
## iOS Engineer - Code Challenge
 
 **To run the application:**

- To run the application it's necessary an iPhone or a XCode simulator running with iOS version 13.6 or higher.
- To use real device you must assign a team development on the Signing and Capabilities tab, than execute the step before choosing your device.
- To load the batch of beer types information click on ![](image/load.png).

**To run on live preview:**

- It's necessary a XCode 11 or higher.
- Open the project, click on BeerBatchView.swift file and then open the Canvas on ![](image/adjust_editor_options.png) (Ajust Editor Options).
- Next to screen's preview click on ![](image/live_preview_run.png) to run and interact with the app.

**What to expect:**

- The first screen is composed by a list os beers with theirs image, name, abv and type represented by a letter, B for Barrel Aged and C for classic.
- By clicking on one of the beer's cell it shows the beer's detail view with its image, type, abv, description and an ingredient list and method.
- By clicking on one of the items, Malts or Hops, a list of the ingredients that beer could use will be shown.
- By clicking on the method a detail view will be swhon whit the methods that beer could apply.


**Architectural decisions**

- For this challenge I decided to use SwiftUI for the reason that: 
    - there wasn't any dependency of older iOS versions;
    - it's declarative Swift syntax it's faster to implement designs, ideas and concepts;
    - and its live preview makes any kind of change easier to test. 
- The architecture used was MVVM dividing model, view and view model responsabilities.
- The models objects were developed using ObservableObject protocol so when their values change they will be reflected in all views. Consequently the user interface will be updated with the correct values.
- As a result of the previous item the Codable protocol couldn’t be used because of its limitation of being implemented only in scructure objects. 
- This meant a further work to parse the data since it was necessary to use JSONSerialization intead of JSONDecoder.

**Unit testing**

- The unit testing was based on view model class BeerTypeBatchModel which applies the business rule. 
- There're two tests for possible solutions to make customers happy and there're more two for NO solution.
