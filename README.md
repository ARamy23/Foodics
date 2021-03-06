# Foodics

## Summary

- Read [How is Everything connected](https://github.com/ARamy23/Foodics#how-is-everything-connected)?
- Read [Why using Clean Architecture](https://github.com/ARamy23/Foodics#so-why-use-clean-architecture)?
- Read [Some Design Decisions](https://github.com/ARamy23/Foodics#some-design-decisions)

## How to Install?

1. `cd PROJECT_PATH_ON_YOUR_COMPUTER`
2. `pod install`

## How is everything connected?

I use Clean Architecture in how things are connected together and how components talk to each other combined with a declarative UI pod to build the UI, I'll explain shortly why i picked using this architecture

So inspired from the diagram listed [here](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
specifically this diagram: 
![Uncle bob clean architecture diagram](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

I broke down the project into 4 different layers which can be seen here inspired by the clean architecture but not really strict to the clean architecture discussed by uncle bob, so it's a bit different

![Overview of the used architecture in this project](https://i.ibb.co/dGF0mdp/Screen-Shot-2020-06-18-at-10-25-52-PM.png)

here we will see 4 layers

### UI Layer
**Brief**: this is basically the View's layers, it consists of the View and the View Controller where both basically don't do anything except get events from the user and pass it to the next layer in line which is the presentation layer, and they await data to display through an observer pattern which channels the Components that a ViewController's TableView should render

**What it does?**: delegates any interaction with the UI to the presentation layer


**What it expects?**: data to display through call backs/delegates or observer pattern depending on the presentation layer picked design pattern

### Presentation Layer
**Brief**: this is where the UI logic gets handled, meaning that how many sections or how many cells that should be displayed goes here, things like pagination or lazy loading (prefetching), any intensive logic that is not related to the UI is delegated to the next layer which is the business layer

**What it does?**: handles the UI logic and notifies the View with the changes and changes backend models to view models that the UI takes to display it's data without any effort


**What it expects?**: dependencies from the View and the backend data

### Business Layer
**Brief**: this is where all the business logic is happening, things like sorting games or actually favourting games should happen, usually this layer does computational operations on the data coming from the next layer which is the data layer and pass it back to the presentation layer for it to map it back to a ViewModel that the view can understand

**What it does?**: do operations on the returned data


**What it expects?**: dependencies from the presentation layer and the backend data from the data layer

### Data Layer
**Brief**: this is where all the networking and caching goes, it fetches the data from either network or from cache or maybe both through repository pattern

**What it does?**: fetch required data


**What it expects?**: i decided to make this part independent, i could have used generics and reused this layer everywhere, but I think it's better to not use generics for 2 reasons
  1. it will increase the complexity of the project
  2. i think it serves more into the separation of concern and increase maintainability
  
### Note
```
For speed, I sacrificed the presence of the data layer and combined it with the Business Layer, and they are named under the name Model
so when you see the Sufix `Model` that means this class does Business and Data Handling
```


## So Why use Clean Architecture?

our main goal is to build a scalable, maintainable, flexible system that is also testable, i found that i can do all the SOLID principles with this architecture where each class does one thing and every layer is also testable (S) (exculding the View which is not unit-testable, but it will be tested with UI Tests), each class can be extended without changing its guts (O), you can change the implementation of any layer without the app getting affected because they are talking to each others through protocols (L), the protocols that are the borders between every layer is only doing one thing (I), the whole app is linked together through protocols which makes the app soft and not coupled with each other (D)

having an architecture that does all of this is so great it allows for all the good things you would wish to happen in a project

## Why use Carbon and Declarative UI approach?

It's no secret that declarative UI gives you more freedom and flexibility and the ability to build even the most complex of UI, after the debut of SwiftUI, I had the chance to build fun stuff and things that would take hours in a matter of mins thanks to the easy API that Apple provides
But ofc, SwiftUI has its own limitations, and it's not yet production ready, so here comes Carbon, a UI building pod in a declarative fashion with the most advanced diffing algorithem out there to deliver butter-smooth UX with nothing less than 60 fps, so you have the agility of Declarative UI building and the performance of a smart diffing algorithem that updates only what has been changed in the UI not `reloadData()` and just reload everything

## The Deeper look

here you can find the whole diagram for anyone to see [here](https://drive.google.com/file/d/1a7w2gX_IXE8RFdKtvaO8vPzNT4C2VJmF/view?usp=sharing)

and this is the overview look of a more detailed UML

![Deeper overview of the architecture](https://i.ibb.co/YhZpZpm/Screen-Shot-2020-06-18-at-10-53-49-PM.png)

let's break it down...


We start at the bottom where the view controller is, as u see it doesn't do much, and when we implement this diagram, you will find that the View Controller does so little things and expects to be served with ViewModels (a viewModel here is not to be mistaken with the MVVM viewModel, it's just a model that fills up the view, it's just a data model that is suitable for the view)

so the view on first launch is expecting Games to display to the user, so it contacts the presentation layer to tell it hey, can u get me the home feed?, so the presentation layer does that by contacting the next layer which is the business layer, the business layer is kinda useless here a bit because there is not much operations it can do, but having it here like this allows for reusability where we can use the same interactor for multiple presentation layers with the right dependencies, so the data layer takes this request and fetches the home feed, if it found it in the cahce it will return it, and on parallel it is fetching it from the remote data source (the backend) by doing so we ensure that the user is always presented with something to see and interact with except in the first launch of the home feed

all of this is done through the repository

the repository is an interface/protocol that is available to the business layer, and the business layer creates this repository through the network protocol and the cache protocol that was handed to it from the presentation layer

how does the repository work? that is something unknown to the business layer, it just tells it to fetch the games feed and that's it waits for the async callback

so the business layer got the data and ran some operations on it, for imagination sake (it sorts the game according to popularity)

then it passes that data back to the presentation and the presentation turn that data into ViewModels that the view can display without a hassle

### Note
```
(a conflict here, we can make it 1 model that is used through the whole lifecycle, and that will indeed boost the performance a lot, but by separating the business model and the view model, we gain two things...
1. any changes to the view will keep the business layer intact without any need to change anything
2. any change from the business side (let's say a change in the API contract), we only need to change the business model and adapt it to the new response coming from the backend)
```

## What about the router?

the router is another way of keeping the View from doing anything, it's a way of encapsulating a weak View Controller reference inside a class that is going to be reused later on by the presentation layer or the business layer

it allows the presentation and the business to navigate the user from one screen to another without giving the view controller any authority, and that's it Keeping the view as dumb as possible to make sure that we dont need to test it

## What about the tests?

that's the easier part, we first start by mocking our externals, like the Router, the Network, and the Cache

we do so by making another implementation and giving injecting this implementation to the SUT (subject under test) which can be either the presentation layer or the business layer

i thought that i'd write a lot explaining it, but you can check the tests module and see how everything is written, since talk is cheap anyway

## Some goodies in this project
- [x] Dark Mode
- [x] Offline Favouriting
- [x] Observable Pattern
- [x] centralized text messages for easier Localization
- [x] easy to use Navigation layer
- [x] simple and reusable UI and components
- [x] layout that fits landscape and portrait
- [x] supports iPhone and iPad
- [x] Unit tests

## Some Design Decisions
- UI was built in code to give flexibility to stuff like: Unified TextField fonts with easy change, Unified Button Styles, Having a control center over all the UI which can be changed easily with A/B Testing without too many effort that the IB can make
- Using Nuke for caching Images, Someone in the iOS Community posted on Twitter that Nuke is faster than Kingfisher, so I decided to use it here
- Wrapping all the assets inside an easy to use API called R.swift, thanks to this, we have strong typed access to all our strings in the localizables, colors in the assets and much more which allowed for an easy Dark Mode and localization with too little effort
- Dynamic<T>
  Dynamic is an observable pattern that is solely dependent on property observer (didSet), where when the value of this class changes, it channels this mutation to all of those who bind (subscribes) to this object, it allowed for seamless update in the UI from the Presentation layer and the presentation layer can be called a ViewModel in this case (MVVM) but i decided to go with the name `Presentation` to avoid naming conflictions
- Externals
  The idea behind Externals is conforming to the SOLID Principles by doing Dependency inversion, Liskov Substitution and Single Responsibility, so we can test, maintain and scale our app without really worrying about lots of stuff

