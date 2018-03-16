dist: FORCE
	bash divvy.sh
	ls dist/?-data.html | while read x; do LETTER=`echo $$x | egrep -o '[A-Z]'`; sed "/INSERT HERE/r $$x" template.html | sed "s/LETTER/$${LETTER}/" > dist/$${LETTER}.html; done
	cp dist/?.html ${HOME}/public_html/droichead/

triples.tsv: droichead.tsv
	cat droichead.tsv | cut -f 1,5 | sed 's/^/ga:/' | sed 's/\t/\trel:etymology\tsga:/' > $@

eidlinks.tsv: crawl/?
	cat crawl/? | egrep -o '/[0-9]+">[^<]+' | sed 's/^\///' | sed 's/^\([0-9]*\)">\(.*\)$$/\2\t\1/' | sed 's/^[ *]*//' | sed 's/ḟ/fh/g; s/ṡ/sh/g' | LC_ALL=C sort -k1,1 > $@
	sed -i '/\t34983$$/s/^/1 /; /\t34984$$/s/^/2 /' $@
	echo '*oenaránach~33523' | tr "~" "\t" >> $@
	echo '*oenaránacht~33524' | tr "~" "\t" >> $@
	echo '*pille~34340' | tr "~" "\t" >> $@
	echo '-ni, -ne~33150' | tr "~" "\t" >> $@
	echo '*remi-suidigedar~35064' | tr "~" "\t" >> $@

clean:
	rm -f eidlinks.tsv triples.tsv

FORCE:
