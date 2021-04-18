# README
This is a Netflix clone that is being built as part of the Launch School elective "Build Robust and Production Quality Applications". The class is taught using Rails 4, but I upgraded to Rails 6 and am using the latest versions of all gems. 

Differences between my project and the class
1. Since Rails 4, Webpacker has started to be used for asset management of JavaScript files, while Sprockets is still used for css, html, and other static assets such as images and fonts. I spent a long time at the beginning setting up Bootstrap using Webpacker, and figuring out how to link to JavaScript in the html files. 

2. It appears that Rails is moving away from using controller tests which is what is taught in the class I am taking. I spent some time reading about current testing practices and there are lots of different recommendations. Based on https://www.betterment.com/resources/guidelines-for-testing-rails-applications/, rspec documentation, and critical thinking, I have decided to use the following approach. 
  a. I will have a test for each model that tests associations, validations, secure password, and any instance or class methods in the model. 
  b. I will use request specs to test http status, template rendering, and redirects for each controller action.
  c. I will use system specs to test the end to end functionality of each feature. 
  d. I will include a test suite for all methods in application helper.

Explanation of Testing Decisions
There does seem to be some redundancy of what is tested in request specs and system specs, but for now I think it's best to include both. I don't have much experience with testing so my thoughts about it may change, but it seems to me that the request specs could help see exactly what is broken. For example, there could be a system spec/feature test that tests that a user can log in. If it fails, it may not be clear exactly which part of it failed. But if you know what requests were involved in whatever feature you're testing, you can check the request spec and see exactly where the problem is. 