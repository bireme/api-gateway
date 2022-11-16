IMAGE_NAME=bireme/api-gateway
APP_VERSION=$(shell git describe --tags --long --always | sed 's/-g[a-z0-9]\{7\}//')
TAG_LATEST=$(IMAGE_NAME):latest

## variable used in docker-compose for tag the build image
export IMAGE_TAG=$(IMAGE_NAME):$(APP_VERSION)

tag:
	@echo "IMAGE TAG:" $(IMAGE_TAG)

prod_build:
	@docker-compose --compatibility build
	@docker tag $(IMAGE_TAG) $(TAG_LATEST)

prod_run:
	@docker-compose --compatibility up kong

prod_start:
	@docker-compose --compatibility up -d kong

prod_stop:
	@docker-compose --compatibility stop

prod_logs:
	@docker-compose --compatibility logs -f

prod_ps:
	@docker-compose --compatibility ps

prod_rm:
	@docker-compose --compatibility rm -f

prod_setup_network:
	@docker network create kong-net

prod_setup_db:
	@docker-compose --compatibility up -d kong-db

prod_setup_migration:
	@docker-compose --compatibility up -d kong-migrations

prod_shell:
	@docker-compose --compatibility exec kong sh

