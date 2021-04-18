# README
This is a Netflix clone that is being built as part of the Launch School elective "Build Robust and Production Quality Applications". The class is taught using Rails 4, but I upgraded to Rails 6 and am using the latest versions of all gems. 

Differences between my project and the class
1. Since Rails 4, Webpacker has started to be used for asset management of JavaScript files, while Sprockets is still used for css, html, and other static assets such as images and fonts. I spent a long time at the beginning setting up Bootstrap using Webpacker, and figuring out how to link to JavaScript in the html files. 

2. I spent a lot of time reading about different testing methodologies for Rails, and it seems that as of 2021, controller tests are being discouraged. However, there is a lack of consensus on what replaces them, and the textbook "Agile Web Development With Rails 6" which was published in 2020 still teaches controller tests. For this reason, I will be using controller tests so that I learn how to do them, and when I have a job I will learn whatever testing methodology is used by the company I work for. 
