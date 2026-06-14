IN   := site/
OUT  := build/
CHEF := ./chef
VARS :=

VARS += -d NAME beauconstrictor
VARS += -d EMAIL foil-ivory-glutton@duck.com

.PHONY: all
all:
	@sh -ec '\
		rm "$(OUT)" -rf; \
		find "$(IN)" -print0 | while IFS= read -r -d "" file; do \
		outpath="$(OUT)/$${file#$(SITE)}"; \
		src="$$file"; \
		case "$$outpath" in \
			*.gmi) outpath="$${outpath%.*}.html" ;; \
		esac; \
		echo "$$src -> $$outpath" ; \
		if [ -d "$$file" ]; then \
		  mkdir -p "$$outpath"; \
		else \
		  $(CHEF) $(VARS) -o "$$outpath" "$$src"; \
		fi; \
	done'

.PHONY: clean
clean:
	rm "$(OUT)" -rf

.PHONY: run
run: all
	@python -m http.server -d "$(OUT)/$(IN)"
