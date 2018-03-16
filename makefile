dist: FORCE
	bash divvy.sh
	ls dist/?-data.html | while read x; do LETTER=`echo $$x | egrep -o '[A-Z]'`; sed "/INSERT HERE/r $$x" template.html | sed "s/LETTER/$${LETTER}/" > dist/$${LETTER}.html; done
	cp dist/?.html ${HOME}/public_html/droichead/

triples.tsv: droichead.tsv
	cat droichead.tsv | cut -f 1,5 | sed 's/^/ga:/' | sed 's/\t/\trel:etymology\tsga:/' > $@

clean:
	rm -f triples.tsv

FORCE:
