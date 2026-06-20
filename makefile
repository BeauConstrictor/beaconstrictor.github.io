IN   := site/
OUT  := build/
CHEF := ./chef
VARS :=

.PHONY: all
all:
	@./all

.PHONY: clean
clean:
	rm -rf "$(OUT)"

.PHONY: run
run: all
	@python -m http.server -d "$(OUT)/html/"

.PHONY: pubgem
pubgem: all
	cp -a ~/projects/me/build/gemini/. ~/public_gemini
