.PHONY: help
#: ヘルプコマンド
help:
	@grep -A1 -E "^#:" Makefile \
	| grep -v -- -- \
	| sed 'N;s/\n/###/' \
	| sed -n 's/^#: \(.*\)###\(.*\):.*/\2###\1/p' \
	| column -t  -s '###'

.PHONY: docker-bash
# exitすると make: *** [docker-bash] Error 130 がでるので無視するために-をつけてる
#: コンテナにbashで入る
docker-bash: docker-select-container-id
	-docker exec -it $(CONTAINER_ID) bash

.PHONY: docker-attach
# exitすると make: *** [docker-bash] Error 130 がでるので無視するために-をつけてる
#: コンテナで実行中のコマンドにattach
docker-attach: docker-select-container-id
	docker attach $(CONTAINER_ID)

.PHONY: docker-logs
#: コンテナのログを見る
docker-logs: docker-select-container-id
	@docker container logs $(CONTAINER_ID) --tail 500 

.PHONY: docker-select-container-id
docker-select-container-id:
	$(eval CONTAINER_ID := $(shell docker ps --format "{{.Names}} {{.ID}}" |  peco  | awk '{print $$2}'))
