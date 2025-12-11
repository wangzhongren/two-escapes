#!/bin/bash
# 一键构建脚本：生成PDF/ePub/HTML

set -e

echo "📦 构建《智能即分类》电子书..."

# 检查依赖
if ! command -v pandoc &> /dev/null; then
    echo "❌ 错误: 未安装 Pandoc。请先安装: https://pandoc.org/installing.html"
    exit 1
fi

# 创建输出目录
mkdir -p output

# 合并所有章节（按顺序）
echo "📑 合并Markdown章节..."
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

# 生成PDF
echo "🖨️  生成PDF..."
pandoc output/book-full.md \
  --pdf-engine=xelatex \
  -o output/intelligence-as-categorization.pdf \
  --metadata title="Intelligence as Categorization" \
  --metadata author="Your Name" \
  --toc

# 生成ePub
echo "📱 生成ePub..."
pandoc output/book-full.md \
  -o output/intelligence-as-categorization.epub \
  --toc

# 生成HTML
echo "🌐 生成HTML..."
pandoc output/book-full.md \
  -o output/index.html \
  --standalone \
  --toc

echo "✅ 构建完成！文件位于 output/ 目录。"