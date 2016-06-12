# Idee per lo sviluppo:
Usiamo un metodo iterativo: piazziamo una curva di Bèzier con parametri a caso e cerchiamo di muoverci verso un minimo della nostra funzione di fit.
Se abbiamo ancora una funzione troppo alta piazziamo un'altra curva di Bèzier e così via.

Al posto di normali curve di Bèzier si useranno quelle con uno spessore, per rendere più fedelmente la scrittura (che è il goal di tutto questo progetto)

Per evitare alcuni problemi di convergenza in alcune situazioni bisogna prevedere che:
* Le curve vengano attratte dai pixel neri anche a distanza (qualcuna potrebbe essere attorniata da bianco e quindi muoversi non farebbe differenza)
* Le curve si respingano leggermente tra di loro (nello spazio dei parametri però, vogliamo evitare che le due assi di una X si respingano)
* Le curve vengano respinte dai quadretti bianchi (devono cercare di stare sul bianco meno possibile)
* Se due punti iniziali delle curve sono molto vicini e le loro tangenti anche allora devono cercare di unirsi e le tangenti di mettersi allineate

Per stimare dove è il minimo è previsto che ad ogni passo ogni curva faccia variare leggermente i suoi punti nello spazio dei parametri e si calcoli in maniera
approssimata le derivate parziali nel punto. Note queste si provvederà a muoversi verso il punto di minimo dell'ammontare giusto di spazio.

Una volta fatto questo, si prevede di adottare una strategia genetica per la convergenza ad un minimo quasi-ottimale: ovvero si fa convergere il metodo per
una cinquantina di volte, poi si mischiano le approssimazioni tra queste varie esecuzioni e si ripete.
