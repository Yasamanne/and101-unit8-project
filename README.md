# 🌍 GlobeTrekker Insight

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)
5. [Demo](#Demo)

## Overview

### Description

GlobeTrekker Insight is a user-friendly app that taps into the power of the REST Countries API to provide you with a wealth of information about every country in the world. With just a few taps, you can explore a treasure trove of data, from the official language, currency, and capital city of any country to its flag and location on the world map.

Discover the beauty of global diversity and expand your knowledge of the world's nations with CountryInfo Hub. Whether you're a curious traveler, a student, or simply interested in global facts, this app is your go-to source for essential country details. Explore, learn, and stay informed about the fascinating tapestry of our world – all at your fingertips, thanks to GlobeTrekker Insight.

### App Evaluation

- **Category:**
  GlobeTrekker Insight falls into the "Reference & Education" category, as it primarily serves as a resource for users looking to gather information about countries around the world.
- **Mobile:**
  GlobeTrekker Insight is a mobile application available for iOS platforms. It's optimized for mobile use, offering a seamless user experience on smartphones and tablets.
- **Story:**
  The app's story is centered around providing a convenient and accessible way for users to explore and learn about different countries. It leverages the REST Countries API to deliver a rich dataset, enabling users to discover details such as languages, currencies, and capital cities. It aims to make global knowledge readily available and easy to access.
- **Market:**
  GlobeTrekker Insight targets a broad market, catering to various user segments. It appeals to travelers seeking information about destinations, students researching geography and cultures, and anyone with an interest in global facts. It has the potential for a global user base, making it accessible and relevant to a wide audience.
- **Habit:**
  The app can encourage a habit of exploration and learning about different countries. Users may find themselves returning to it whenever they encounter a country-related question or when they want to expand their understanding of the world. Over time, it can become a habitual resource for those who enjoy discovering new information.
- **Scope:**
  The scope of CountryInfo Hub is comprehensive in its focus on providing information about all the countries in the world. It covers essential details, such as language, currency, and capital, offering a holistic view of each nation. The app's scope is well-defined and aligned with its primary purpose of being an informative resource for country-related data.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can insert name of a country
* User can select to see the flag of the selected country
* The app displays the currency of the countries, official name, languages spoken, and capital
* User can select to see more details like continent, timezone, population, and coat of arms
* A tab to see three favorite countries' information

**Optional Nice-to-have Stories**

* Currency exchange to dollar
* News about that specific country
* Displays the location of the country on the map

### 2. Screen Archetypes

- [1️⃣] Stream
* User can insert a country name
* User can select a button to see more details
- [2️⃣] Details
* User can select to see the flag
* User can select to see the coat of arms
- [3️⃣] Profile
* User can add 3 countries of their interest to their favorite list

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home
* Favorite Tab
* News Tab(optional)

**Flow Navigation** (Screen to Screen)

- [🏠] Home - Insert Country name
* => View Information

- [🏁] Country's Information - select flag
* => View the country's flag

- [🔣] Country's Detail - select coat of arm
* => View the country's coat of arm

- [👍] Favorite's tab
* list of favorite countries


## Wireframes


<img src="http://g.recordit.co/ARdJw6M7rx.gif" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

Two APIs are used for this app development:
  - For Country information, Flags, and map: [Country API](https://restcountries.com/)
  - For News Related to a specific country: [News API](https://newsapi.org/)

### Demo

<img src="http://g.recordit.co/dkfMIVNDGa.gif">

