# heroku-container-test

This tiny project is to test deployment of a (single) Docker container from my local machine to Heroku, thus making public a simple webpage, via the Heroku CLI (Command Line Interface). As stated on the Heroku *Deploying with Docker* page, https://devcenter.heroku.com/categories/deploying-with-docker, Heroku provides two options for deployment with Docker:

- *Container Registry allows you to deploy pre-built Docker images to Heroku* (**used here!**) - https://devcenter.heroku.com/articles/container-registry-and-runtime
- *Build your Docker images with heroku.yml for deployment to Heroku* - https://devcenter.heroku.com/articles/build-docker-images-heroku-yml

Here I use the first method. The deployed container uses an *nginx* (web server) base image, https://hub.docker.com/_/nginx.


## [Heroku] Container Registry & Runtime (Docker Deploys)

(My local environment is Windows 10, in which I use *Git Bash* to run the Heroku CLI and deploy the files in this repo.)

First, it is necessary to sign up to an account at https://www.heroku.com, and then to download and install the Heroku CLI from https://devcenter.heroku.com/articles/heroku-cli. 
Then, login and create a Heroku app, in my case named *funky-container-test*.

`heroku container:login`

`heroku create funky-container-test`


### Preparations before deployment - Explanation of Docker configuration

- **nginx.conf** - I refrain from focusing on this configuration file, as it is not essential for the goal of this project. However, here is a guide about how to use it https://www.digitalocean.com/community/tutorials/understanding-the-nginx-configuration-file-structure-and-configuration-contexts.
- **default.conf.template** - In the Dockerfile instructions, data from this file will be copied from *default.conf.template* to *default.conf* within the nginx image. Specifically, Heroku sets the *$PORT* environment variable that needs to be used (listened to HTTP traffic on) by the image. The value for *$PORT* is precisely what is copied to *defaulf.conf*. Instructions available at https://hub.docker.com/_/nginx.
- **Dockerfile** - In the first command, *FROM nginx*, Docker is instructed to use the nginx Docker image as the base image to build on. Next, the webpage (in the *src* folder) as well as the two above configuration files are copied into the image. Finally, the command instruction, *CMD*, is given, telling Docker to copy the *$PORT* value from *default.conf.template* into *default.conf* (using *envsubst* - https://www.mankier.com/1/envsubst), as well as to run nginx.
  - (About the last row: For *bash*, if the *-c* option is present, then commands are read from the string that succeeds it.)


### Deploy to Heroku

Having prepared the above files accordingly (as they are in this repo), the below command can be used to build and push the image to the Heroku Container Registry. (*web* here refers to one of the 3 variants of Heroku *Dyno configurations*, https://devcenter.heroku.com/articles/dynos#dyno-configurations.)

`heroku container:push web`

Then, in order for it to be deployed, it is also necessary to *release* it. 

`heroku container:release web`

View the deployed website (replace with the name of your own Heroku app) at:
https://funky-container-test.herokuapp.com/

Or, alternatively, run:

`heroku open`

