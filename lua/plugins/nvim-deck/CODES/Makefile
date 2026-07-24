DENO_DIR := ${PWD}/.deno_dir

.PHONY: prepare
prepare:
	docker build --platform linux/arm64/v8 -t panvimdoc https://github.com/kdheepak/panvimdoc.git#d5b6a1f3ab0cb2c060766e7fd426ed32c4b349b2

.PHONY: docs
docs:
	if [ ! -d ${DENO_DIR} ]; then mkdir ${DENO_DIR}; fi
	docker run -v ${PWD}:/app -v ${DENO_DIR}:/deno-dir -i denoland/deno -A /app/scripts/docs.ts
	docker run -v ${PWD}:/app -v ${DENO_DIR}:/deno-dir -i denoland/deno fmt /app/README.md
	# --project-name: the name of the project
	# --input-file: the input markdown file
	# --vim-version: the version of Vim that the project is compatible with
	# --toc: 'true' if the output should include a table of contents, 'false' otherwise
	# --description: a project description used in title (if empty, uses neovim version and current date)
	# --title-date-pattern: '%Y %B %d' a pattern for the date that used in the title
	# --dedup-subheadings: 'true' if duplicate subheadings should be removed, 'false' otherwise
	# --demojify: 'false' if emojis should not be removed, 'true' otherwise
	# --treesitter: 'true' if the project uses Tree-sitter syntax highlighting, 'false' otherwise
	# --ignore-rawblocks: 'true' if the project should ignore HTML raw blocks, 'false' otherwise
	# --doc-mapping: 'false' if h4 headings should double as mapping docs, 'true' otherwise
	# --doc-mapping-project-name: 'true' if tags generated for mapping docs contain project name, 'false' otherwise
	# --shift-heading-level-by: 0 if you don't want to shift heading levels , n otherwise
	# --increment-heading-level-by: 0 if don't want to increment the starting heading number, n otherwise
	# --scripts-dir: '/scripts' if 'GITHUB_ACTIONS=true' or '.dockerenv' is present, '/panvimdoc.sh/scripts' if no argument is passed, scripts directory otherwise
	docker run -v $(PWD):/data -i panvimdoc \
		--project-name deck \
		--input-file README.md \
		--vim-version "NVIM v0.10.0" \
		--toc true \
		--demojify true \
		--treesitter true \
		--ignore-rawblocks true \

.PHONY: lint
lint:
	docker run -v $(PWD):/code -i registry.gitlab.com/pipeline-components/luacheck:latest --codes /code/lua

.PHONY: format
format:
	docker run -v $(PWD):/src -i fnichol/stylua --config-path=/src/.stylua.toml -- /src/lua

.PHONY: test
test:
	vusted --output=gtest --pattern=.spec ./lua

.PHONY: check
check:
	make lint
	make format
	make test

.PHONY: typecheck
typecheck:
	rm -Rf $(pwd)/tmp/typecheck; $(LUA_LS_PATH) --check $(pwd)/lua --configpath=$(pwd)/.luarc.typecheck.json --logpath=$(pwd)/tmp/typecheck
