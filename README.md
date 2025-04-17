Countries Search App

A simple iOS application that allows users to search and filter countries by name or capital in real-time.

Demo

![Demo](demo.gif)

Features
	•	Search for countries by name or capital
	•	Real-time search results
	•	Table view layout using UITableView
	•	Loading state indicator during filtering
	•	Error handling and empty state
	•	Unit tests and UI tests included

Requirements
	•	iOS 18.0+
	•	Xcode 15.0+
	•	Swift 5.9+

Installation
	1.	Clone the repository
	2.	Open Assesment_wlmrt.xcodeproj in Xcode
	3.	Build and run the project

Architecture

The project follows the MVVM (Model-View-ViewModel) architecture pattern and uses UIKit for the user interface. It’s organized into the following components:
	•	Models: Data models for countries (name, region, code, capital)
	•	Views / ViewControllers: UIKit-based UI layout (UITableView, Cells)
	•	ViewModels: Business logic and filtering
	•	Services: Network layer for fetching countries via CountriesServiceProtocol

Testing

The project includes unit tests and UI tests for the core functionality. To run the tests:
	1.	Open the project in Xcode
	2.	Select the test target
	3.	Press Cmd + U or navigate to Product > Test