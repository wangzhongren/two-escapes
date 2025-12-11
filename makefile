# Makefile for book building (alternative to build.sh)

.PHONY: all pdf epub html clean

all: pdf epub html

pdf:
	pandoc output/book-full.md --pdf-engine=xelatex -o output/intelligence-as-categorization.pdf --metadata title="Intelligence as Categorization" --metadata author="Your Name" --toc

epub:
	pandoc output/book-full.md -o output/intelligence-as-categorization.epub --toc

html:
	pandoc output/book-full.md -o output/index.html --standalone --toc

clean:
	rm -rf output/

output/book-full.md:
	mkdir -p output
	cat \
	book/00-preface.md \
	book/01-intelligence-as-categorization.md \
	book/01-intelligence-as-categorization/1.1-the-categorization-pressure-law.md \
	book/02-the-first-escape.md \
	book/02-the-first-escape/2.1-timeline-of-symbolic-revolution.md \
	book/02-the-first-escape/2.2-fire-caves-and-external-memory.md \
	book/02-the-first-escape/2.3-why-neanderthals-lost.md \
	book/03-the-second-escape.md \
	book/03-the-second-escape/3.1-three-eras-of-ai-categorization.md \
	book/03-the-second-escape/3.2-transformer-as-category-engine.md \
	book/03-the-second-escape/3.3-prompt-only-category-autogenesis.md \
	book/04-the-mechanism-revised.md \
	book/04-the-mechanism-revised/4.1-self-attention-as-dynamic-prototyping.md \
	book/04-the-mechanism-revised/4.2-value-vectors-encode-response-semantics.md \
	book/04-the-mechanism-revised/4.3-minimal-implementation.md \
	book/05-architectural-comparisons.md \
	book/05-architectural-comparisons/5.1-transformer-vs-mamba-vs-rnn-for-categorization.md \
	book/06-future-predictions-2026-2035.md \
	book/06-future-predictions-2026-2035/6.1-category-compilers.md \
	book/06-future-predictions-2026-2035/6.2-living-world-models.md \
	book/06-future-predictions-2026-2035/6.3-defining-agi-by-category-autonomy.md \
	book/07-conclusion-two-escapes-one-law.md \
	> output/book-full.md

# Dependencies
pdf epub html: output/book-full.md