# Checkout
Demo app to perform checkout using card payment.

## Code Overview

The code is implemented in below layers

- Network Layer (Responsible for making network request)
- Data Layer (Responsible for providing data in pages)
- Presentation Layer (Responsible for displaying data)
- Domain Layer (Usecases and entities )

The app consists of below modules

- Scenes:
    - CardPayment - Screen to add card details to perform the checkout.
    - Redirection - Loads the redirection url received on initiating a payment.
    - Success/Failure - Success or Failure page when 3D secure validation succeeds

- Network Module : 
    - Responsible for making network request.

- Data Module : 
    - Responsible for fetching data in pages.
    - Repository, Datasources, Services.

- Domain Module :
    - Responsible for business logics.
    - UseCases, Entities
    
- Presentation Module : 
    - Responsible for presentation logic.
    - Views, ViewModels, DisplayModelMappers.



## Architecture Design Pattern

The app is architected using the MVVM Architecture following the SOLID principles and responsibilities divided across different layers. Following are the some of the highlights of the architecture used:
- MVVM
- Clean Architecture (Data/Domain/Presentation).
- Combine


## Testability

- Unit Tests to be written.   


## Future Enhancements:

- Better test coverage.
- Better UI for card expiry input.
- Formatting card number as user enters.

