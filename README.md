# Docker Debian CI

Docker CI is an image made for CI runners or build tasks ( tested on Gitlab Act Runner ).
It's based on **Debian 12**, with :
- Some tools `curl` / `zip` / `git` 
- **PHP** with extensions ( `curl` / `gd` / `xml` / `mysql` / `pgsql` / `sqlite3` / `mbstring` )  
- **Node** and associated NPM
- **Docker**
- **Composer 2**
- **Bun**

> Available on Docker Hub at `zouloux/debian-ci`

## Versions

When built, this image creates `/root/versions.txt`. Here are the current versions :
```text
PHP: 8.3.7
Composer: 2.7.6
Node: 22.2.0
NPM: 10.7.0
Docker: 26.1.3
Bun: 1.1.8
```

> Feel free to create an issue to update those versions.

The image is published with updates version on `:latest`, and a unique tag is created.
You should definitely target a specific tag in your build, if you do not want your build to crash when I update dependencies.

## With Gitlab CI

In your `.gitlab-ci.yml` file :

```yaml
image:
  name: zouloux/docker-ci-debian
```

## With Gitea Act or Act Runner

```yaml
jobs:
  my-job:
    runs-on: ubuntu-latest # no worries, it will use the debian image
    container:
      image: zouloux/docker-debian-ci
```

## With Docker 

```bash
docker run -it zouloux/docker-ci-php-node bash
```

## With Docker Compose

```yaml
services :
  debian-ci:
    image: zouloux/debian-ci
  volumes:
  	# If docker is used, link to host docker sock 
    - /var/run/docker.sock:/var/run/docker.sock
  command: |
    bash -c "
	  echo "PWD: $(pwd)"
      echo "Directory:"
	  ls -la
	  echo "Versions:"
      cat versions.txt
    "
```