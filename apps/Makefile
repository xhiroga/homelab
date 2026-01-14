n8n-borzoi-up:
	docker compose -f n8n/docker-compose.yml -p n8n-borzoi --env-file config/.n8n-borzoi.env up -d
n8n-borzoi-stop:
	docker compose -f n8n/docker-compose.yml -p n8n-borzoi --env-file config/.n8n-borzoi.env stop
n8n-borzoi-restore:
	docker compose -f n8n/docker-compose.yml -p n8n-borzoi --env-file config/.n8n-borzoi.env --profile restore run --rm restore

n8n-yagi-up:
	docker compose -f n8n/docker-compose.yml -p n8n-yagi --env-file config/.n8n-yagi.env up -d
n8n-yagi-stop:
	docker compose -f n8n/docker-compose.yml -p n8n-yagi --env-file config/.n8n-yagi.env stop
n8n-yagi-restore:
	docker compose -f n8n/docker-compose.yml -p n8n-yagi --env-file config/.n8n-yagi.env --profile restore run --rm restore

open-webui-borzoi-up:
	docker compose -f open-webui/docker-compose.yml -p open-webui-borzoi --env-file config/.open-webui-borzoi.env up -d
open-webui-borzoi-stop:
	docker compose -f open-webui/docker-compose.yml -p open-webui-borzoi --env-file config/.open-webui-borzoi.env stop
open-webui-borzoi-restore:
	docker compose -f open-webui/docker-compose.yml -p open-webui-borzoi --env-file config/.open-webui-borzoi.env --profile restore run --rm restore

open-webui-yagi-up:
	docker compose -f open-webui/docker-compose.yml -p open-webui-yagi --env-file config/.open-webui-yagi.env up -d
open-webui-yagi-stop:
	docker compose -f open-webui/docker-compose.yml -p open-webui-yagi --env-file config/.open-webui-yagi.env stop
open-webui-yagi-restore:
	docker compose -f open-webui/docker-compose.yml -p open-webui-yagi --env-file config/.open-webui-yagi.env --profile restore run --rm restore
