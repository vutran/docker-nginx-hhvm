# [Ubuntu 14.04 LTS + Nginx + HHVM](https://registry.hub.docker.com/u/vutran/docker-nginx-hhvm/)

This is a simple container with Nginx, HHVM, and Ubuntu 14.04.

-----

To pull this image from Docker Hub:

    docker pull vutran/docker-nginx-hhvm

To run an instance of this image:

    docker run --name mywebapp -d -P vutran/docker-nginx-hhvm

You can mount your local application directory to the container at `/var/www/html`:

    docker run --name mywebapp -d -P -v /src/html:/var/www/html vutran/docker-nginx-hhvm

Open the URL in the browser

    open http://$(boot2docker ip):$(docker port mywebapp 80 | sed 's/0.0.0.0://g')

## Dockerfile

You can also build your own image with this as the base and apply your own application-specific configurations if needed.

For more information, please see the [Dockerfile documentations](http://docs.docker.com/reference/builder/).

### Dockerfile

    FROM vutran/docker-nginx-hhvm

    # Execute or run any additional instructions here such
    # Example:
    # COPY website.conf /etc/nginx/conf.d/website.conf
    # ENV myEnvVar myEnvValue
    

## Docker Compose

If you have a complex application, you can use Docker Compose to run everything in a single command.

For more information, please see the [Docker Compose documentation](http://docs.docker.com/compose/)

### docker-compose.yml

    web:
        build: .
        volumes:
         - .:/var/www/html
