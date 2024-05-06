# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Usage](#usage)
4. [Architecture](#architecture)
5. [Dependencies](#dependencies)
6. [Design](#design)
7. [API](#api)

# SilverScreen
Movie details application for movie lovers
## Description

<b>SilverScreen</b> is a movie application that provides users with movie details as it would on IMDb
The app provides Now playing, Top rated, Most popular and Upcoming movie results for users to quickly find movies. A search function provides users with the ability to search for a particular movie. The app also has functionality to view movie details such as:
- Poster
- Title
- release year
- genre
- rating
- overview
  
NOTE: Search functionality and movie overview functionality to come

<img width="460" alt="Screenshot 2024-05-06 at 9 04 12 AM" src="https://github.com/sjacobs1/Pet-Movie-Project-Repo/assets/162406787/31331f19-33c2-4008-982d-a1cff7cef5af">
<img width="498" alt="Screenshot 2024-05-05 at 4 33 22 PM" src="https://github.com/sjacobs1/Pet-Movie-Project-Repo/assets/162406787/3cae2188-b4fc-412f-a2e1-f433505db0a5">

## Getting Started
1. Xcode version 14.0 or above should be installed on your computer
2. Download the <b>SuperLiga</b> project files from the repository
3. Open the project files in Xcode
4. Run the active schema
The app should start up on the simulator greating you with the login page

## Usage
At this point in the apps development there isn't any authetican in order to gain access, there are default creditiols
- Username: Admin
- Password: DVTPassword
  
## Architecture
- <b><i>SilverScreen</i></b> is a native iOS application bulit using the Model-View-View Model (MVVM) architecture
- The Model has any data and business logic that is used by the application
- The View is reponsible for the interface in wich the user interacts with
- The View model is necessary to transform information from the model and to update the View
- Currently the project doesn't make use of core data, but it is to implemented
  
## Tests
The project is currently has no tests but unit testing will be implemented

## Dependencies
Currently using sdWebImage package, to be removed

## Design
- The design tool used is [Figma](https://www.figma.com).
  
## API
- The API being used is called The Movie Database API, link : https://developer.themoviedb.org/reference/movie-details
- All data provided is via the API which returns in JSON format only.
