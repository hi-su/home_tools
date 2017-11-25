.SUFFIXES : .pdf .tex .pic .ps .xbb .epsi .dot .svg .md .html
#.SUFFIXES : .asy

.tex.pdf :
	platex -synctex=1 $< && dvipdfmx $*
	platex -synctex=1 $< && dvipdfmx $*

# 日本語を使わなければ大丈夫(日本語を使うなら、pic->tex->pdf->epsi)
.pic.ps :
	iconv -t EUCJP $< | gpic | iconv -f EUCJP -t UTF8 | groff > $@

.ps.pdf :
	ps2pdf $<

.ps.epsi :
	ps2epsi $<

.epsi.xbb :
	extractbb $<

#使わなくなったので
#.pdf.ps :
#	pdf2ps $<

# 日本語フォントで問題発生
# .dot.pdf :
#	dot -Tpdf $< -o $@

.svg.ps :
	inkscape -z -E $@ $<

.dot.svg :
	gcc -E -xc -undef $< | dot -Tsvg -o $@
#	dot -Tsvg $< -o $@

# 数式($xx$)ができない
.pic.svg :
	iconv -t EUCJP $< | pic2plot -T svg | sed "s/ISO-8859-1/EUC-JP/" > $@

.pic.tex :
	iconv -t EUCJP $< | gpic -t | iconv -f EUCJP -t UTF8 > $@

.dot.tex :
	dot2tex -tmath $< > $@

# 思ったようにいかない
#.asy.tex :
#	asy --inlinetex $?

# 2015-02-25 追加
.dot.pdf :
	cat $< | gcc -E -xc - | dot -Tpdf -o $@
#	dot $< -Tpdf -o $@

.md.html :
	pandoc $< -s -o $@

