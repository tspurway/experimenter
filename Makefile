secretkey:
	openssl rand -hex 24

build: 
	./scripts/build.sh

compose_build: build
	docker-compose build

up: compose_build
	docker-compose up

test: compose_build
	docker-compose run app bash -c "coverage run manage.py test;coverage report -m --fail-under=100" 

lint: compose_build
	docker-compose run app flake8 .

check: compose_build lint test
	echo "Success"

migrate: compose_build
	docker-compose run app python manage.py migrate

shell: compose_build
	docker-compose run app python manage.py shell

bash: compose_build
	docker-compose run app bash
