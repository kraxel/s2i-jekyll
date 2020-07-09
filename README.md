# s2i builder for jekyll sites

Source: [https://gitlab.com/kraxel/s2i-jekyll](https://gitlab.com/kraxel/s2i-jekyll)

Image: registry.gitlab.com/kraxel/s2i-jekyll

## Deploy in openshift

```
oc new-app registry.gitlab.com/kraxel/s2i-jekyll~git://some.host/your/repo.git
```

## Work with the builder image sources

### Create the builder image
The following command will create a builder image named kraxel/s2i-jekyll based on the Dockerfile that was created previously.
```
docker build -t kraxel/s2i-jekyll .
```
The builder image can also be created by using the *make* command since a *Makefile* is included.

### Creating the application image
The application image combines the builder image with your applications source code, which is served using whatever application is installed via the *Dockerfile*, compiled using the *assemble* script, and run using the *run* script.
The following command will create the application image:
```
s2i build test/test-app kraxel/s2i-jekyll kraxel/s2i-jekyll-app
---> Building and installing application from source...
```
Using the logic defined in the *assemble* script, s2i will now create an application image using the builder image as a base and including the source code from the test/test-app directory. 

### Running the application image
Running the application image is as simple as invoking the docker run command:
```
docker run -d -p 8080:8080 kraxel/s2i-jekyll-app
```
The application, which consists of a simple static web page, should now be accessible at  [http://localhost:8080](http://localhost:8080).
