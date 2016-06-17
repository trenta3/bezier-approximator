L'idea qui è di fare i conti molto più velocemente sfruttando la funzione
nonlin_residmin che permette di minimizzare una somma di quadrati di funzioni.

Inoltre, per evitare che le linee di bezier vadano a finire sui quadretti bianchi,
metteremo in un insieme tutti i quadretti a distanza <= 3 da un quadretto nero e
permetteremo alle curve di stare solo qui sopra aggiungendo alla somma dei quadrati
l'inverso della distanza dal complementare di questo nuovo insieme
