# README
This is a Netflix clone that is being built as part of the Launch School elective "Build Robust and Production Quality Applications". The class is taught using Rails 4, but I upgraded to Rails 6 and am using the latest versions of all gems. 

Differences between my project and the class
1. Since Rails 4, Webpacker has started to be used for asset management of JavaScript files, while Sprockets is still used for css, html, and other static assets such as images and fonts. I spent a long time at the beginning setting up Bootstrap using Webpacker, and figuring out how to link to JavaScript in the html files. 

2. It appears that Rails is moving away from using controller tests which is what is taught in the class I am taking. I spent some time reading about current testing practices and there are lots of different recommendations. Based on https://www.betterment.com/resources/guidelines-for-testing-rails-applications/, rspec documentation, and critical thinking, I have decided to use the following approach. 
  a. I will have a test for each model that tests associations, validations, secure password, and any instance or class methods in the model. 
  b. I will use request specs to test http status and redirects for each controller action.
  c. I will use system specs to test the end to end functionality of each feature. 
  d. I will include a test suite for all methods in application helper.