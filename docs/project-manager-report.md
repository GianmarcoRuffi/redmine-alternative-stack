# Redmine come possibile alternativa a Jira

## Documento di sintesi per Project Manager

## Stato del lavoro

Questo documento riassume quanto emerso finora sull'ipotesi di usare Redmine come possibile alternativa a Jira/Atlassian.

Punto importante: al momento siamo ancora in fase di indagine. Non c'è ancora una decisione di investimento su un prodotto o su una migrazione. L'obiettivo attuale è capire se esiste una base abbastanza solida per passare a una fase di implementazione.

## Executive summary

La conclusione preliminare è che Redmine, nella sua forma base, non è ancora una sostituzione migliore di Jira in senso assoluto. Tuttavia, Redmine può diventare una valida alternativa per alcune software house se viene proposto non come prodotto "vanilla", ma come stack curato e potenziato.

I punti dove Redmine parte avvantaggiato sono soprattutto:

- costo ricorrente più basso
- minore lock-in verso un singolo vendor
- maggiore controllo su hosting, dati e personalizzazioni
- maggiore libertà rispetto alla spinta Atlassian verso il cloud

I punti dove Redmine è più debole rispetto a Jira sono invece quelli che oggi rendono Jira operativamente comodo:

- board e backlog più maturi
- reporting e dashboard più pronti all'uso
- automazioni più ricche
- integrazioni più curate
- esperienza utente più moderna in alcune aree

La tesi più promettente, quindi, non è "sostituire Jira con Redmine base", ma valutare se sia sensato costruire o assemblare una distribuzione Redmine potenziata, orientata a team software che vogliono più controllo e meno dipendenza da Atlassian.

## Cosa abbiamo indagato

L'indagine finora ha coperto queste aree:

1. confronto Jira vs Redmine
2. ecosistema Redmine: plugin, temi, customizzazioni e API
3. modalità di sviluppo di add-on su Redmine
4. possibili partnership con soggetti credibili del mondo Redmine
5. fattibilità di migrazione da Jira a Redmine
6. ipotesi di posizionamento commerciale verso software house

## Principali evidenze raccolte

## 1. Redmine ha valore soprattutto come piattaforma controllabile

Rispetto a Jira, Redmine appare particolarmente interessante quando il problema principale del cliente non è avere "più funzioni possibile", ma avere:

- meno costo ricorrente
- più controllo sul dato
- più flessibilità di hosting
- meno dipendenza da roadmap e licensing Atlassian

Questo significa che la proposta di valore non va costruita sulla parità funzionale totale, ma su controllo, costo e sufficienza operativa.

## 2. Jira resta più forte nelle funzioni operative già pronte

Le aree dove Jira è ancora nettamente più forte sono:

- gestione Agile pronta all'uso
- roadmap e pianificazione cross-team
- reportistica e dashboard native
- automazioni
- ecosistema di integrazioni e app più esteso

Se volessimo proporre davvero Redmine come alternativa, queste aree andrebbero almeno ridotte come gap, tramite plugin selezionati, personalizzazioni o add-on proprietari.

## 3. Il mondo Redmine ha partner credibili, ma non un vendor unico da trattare come "produttore ufficiale"

Redmine è open source, quindi non esiste un unico vendor proprietario paragonabile ad Atlassian.

Le piste più concrete emerse sono:

- Planio: soggetto credibile lato hosting e delivery, molto vicino alla comunità Redmine e ai contributor principali; offre anche supporto alla migrazione e si presenta pubblicamente come team con forte legame con il progetto Redmine
- RedmineUP: vendor con ecosistema plugin e theme molto ampio, oltre a un partner program pubblico e strutturato
- Easy8: più utile come benchmark competitivo, cioè come esempio di come si può costruire un'offerta commerciale evoluta a partire dal mondo Redmine

Conclusione: partnership possibili sì, ma soprattutto con chi offre hosting, plugin, servizi o canale, non con un "creatore unico del prodotto" nel senso classico.

## 4. Gli add-on Redmine sono sviluppabili in modo relativamente ordinato

Redmine è basato su Ruby on Rails. Le estensioni seguono logiche note:

- plugin Ruby on Rails
- temi per la parte visiva
- hook ed estensioni del core
- REST API per integrazioni e automazioni esterne

Questo è un punto a favore, perché consente di distinguere bene tre livelli di intervento:

- personalizzazione grafica
- estensione funzionale
- integrazione con sistemi terzi

Dal punto di vista tecnico, quindi, costruire add-on è fattibile. Il vero tema non è tanto se si può fare, ma quanto conviene farlo rispetto a comprare o integrare plugin già esistenti.

## 5. Le customizzazioni sono possibili, ma vanno governate con disciplina

Le personalizzazioni Redmine possono passare da:

- campi custom e workflow
- temi
- plugin
- integrazioni API

Il rischio principale è trasformare Redmine in un mosaico difficile da aggiornare. Per questo, la strada più sana è:

- usare Redmine core dove basta
- usare plugin consolidati dove accelerano davvero
- sviluppare in casa solo dove il gap è strategico
- evitare modifiche invasive al core, salvo casi estremi

## 6. La migrazione da Jira a Redmine è possibile, ma non va venduta come lift-and-shift perfetto

La migrazione appare fattibile soprattutto per:

- issue e campi
- utenti e ruoli
- commenti e allegati
- stati e workflow semplificati

Le aree più delicate sono invece:

- board e backlog
- automazioni
- dashboard e reporting
- integrazioni profonde col mondo Atlassian
- configurazioni molto complesse o molto personalizzate

La conclusione più prudente è che la migrazione va pensata come "migrazione guidata con redesign controllato", non come semplice esporta/importa.

## 7. Il posizionamento commerciale migliore non è "Redmine contro Jira", ma "stack Redmine curato contro overhead Atlassian"

La proposta che regge meglio è questa:

- non vendere Redmine base
- non promettere parità totale con Jira enterprise
- proporre invece una soluzione più controllabile, più leggera economicamente e più indipendente

In altre parole, il posizionamento migliore è per software house che:

- sentono il peso economico di Jira
- non vogliono lock-in crescente
- non hanno bisogno di tutta la profondità enterprise di Atlassian
- sono disposte ad accettare uno stack più curato e più opinionated

## Matrice gap Jira -> Redmine

Questa è la versione di lavoro da usare come base decisionale.

| Area | Jira oggi | Redmine base | Azione consigliata | Priorità |
| --- | --- | --- | --- | --- |
| Costo e licensing | Punto debole percepito | Punto forte | Leva commerciale, non sviluppo | Alta |
| Lock-in e controllo dati | Punto debole percepito | Punto forte | Leva commerciale, non sviluppo | Alta |
| Direzione forzata verso il cloud | Punto debole percepito | Punto forte | Valorizzare self-hosting e libertà di deployment | Alta |
| Board e backlog | Maturi e nativi | Deboli o plugin-based | Partire da plugin selezionati, poi valutare estensioni proprietarie | Alta |
| Roadmap e pianificazione cross-team | Forti nelle tier più alte | Parziali | Migliorare con plugin e UX curata | Alta |
| Reporting e dashboard | Forti e pronti all'uso | Deboli | Rafforzare con plugin o layer custom | Alta |
| Automazioni | Forti | Deboli | Aggiungere regole leggere o integrazioni mirate | Alta |
| UX generale | Ricca ma spesso pesante | Più semplice ma datata | Migliorare con tema moderno e flussi più puliti | Alta |
| Mobile e responsive | Buoni | Limitati | Migliorare solo le viste chiave in prima battuta | Media |
| Workflow e permessi | Molto configurabili | Buoni ma meno sofisticati | Preparare template standard e setup più semplice | Alta |
| Integrazioni dev tools | Ecosistema ampio | API e plugin meno curati | Priorità a Git, CI, chat e notifiche | Alta |
| Migrazione da Jira | Uscire da Jira è difficile | Non gestita come prodotto | Costruire runbook e toolkit di migrazione | Alta |
| Wiki / knowledge base | Spesso integrata con Confluence | Presente ma più semplice | Valutare quando basta e quando integrare altro | Media |
| Helpdesk / service desk | Forte nell'ecosistema Atlassian | Debole nativamente | Non è focus della prima fase | Media |
| AI | Spinta commerciale forte | Assente | Esplicitamente fuori scope iniziale | Bassa |
| Governance enterprise | Forte | Limitata | Non è target iniziale | Bassa |

Lettura pratica della matrice:

- Redmine è già più forte dove Jira è più criticato commercialmente: costo, lock-in, libertà di deployment e proprietà del dato
- Redmine è invece più debole dove Jira resta più comodo nell'uso quotidiano: board, reporting, automazioni, integrazioni e UX

Questo significa che, se l'iniziativa dovesse proseguire, la priorità non sarebbe inseguire tutta Jira, ma chiudere i gap che bloccano davvero l'adozione.

## Cosa consigliamo di fare adesso

La raccomandazione non è partire subito con un prodotto. La raccomandazione è finanziare una discovery strutturata.

Obiettivi della discovery:

- validare il problema di mercato
- capire fin dove può arrivare Redmine con stack curato
- capire quanto pesa davvero la migrazione
- decidere se il gap va chiuso per integrazione o per sviluppo proprietario

## Tempi indicativi

### Scenario discovery lean

- indagine problema/mercato: 1-2 settimane
- fit-gap e analisi ecosistema: 2-3 settimane
- fattibilità migrazione: 2-3 settimane
- validazione tecnica leggera o sandbox minima: 1-2 settimane
- sintesi finale e go/no-go: 1 settimana

Totale indicativo: 6-11 settimane.

### Scenario discovery più rigorosa

Se si volesse fare l'indagine con più interviste, più test comparativi e meno sovrapposizione dei filoni, il range realistico sale a circa 11-18 settimane.

## Cosa succede dopo, se la discovery dà esito positivo

Solo se la discovery conferma la tesi avrebbe senso passare a una fase successiva, ad esempio:

- sandbox interna più solida
- uso interno su workflow reali
- selezione plugin e tema di riferimento
- primi spike di gap closure
- definizione di una migration factory

Come ordine di grandezza, una readiness tecnica interna credibile richiederebbe probabilmente alcuni mesi aggiuntivi dopo la discovery. Quindi non va raccontata come iniziativa "rapida" fino a che non si chiude la fase di indagine.

## Backlog prioritario della discovery

### Priorità 1: domande bloccanti

- validare i principali pain point su Jira/Atlassian
- completare il fit-gap Jira vs Redmine
- valutare la maturità dell'ecosistema plugin
- capire i rischi reali di migrazione
- definire cosa significa davvero "sufficienza operativa"

### Priorità 2: acceleratori

- raccomandare uno stack tecnico di base
- impostare una sandbox minima
- definire le aree più probabili di gap closure
- strutturare il runbook di migrazione
- affinare il posizionamento commerciale

### Priorità 3: lavoro condizionale

Da fare solo se la discovery conferma la direzione:

- dogfooding interno
- spike di add-on proprietari
- design partner e pilot
- packaging più ripetibile

## Stato attuale del repository

Nel repository esiste già una base minima per la sandbox Redmine:

- `docker-compose.yml`
- `.env.example`
- `docs/sandbox-setup.md`

La configurazione è stata validata sintatticamente. L'avvio reale della sandbox dipende però dai permessi locali sul daemon Docker.

## Raccomandazione finale al PM

La raccomandazione attuale è:

1. non approvare ancora un'iniziativa di build completa
2. approvare invece una discovery con obiettivi, tempi e criteri di uscita chiari
3. usare la discovery per arrivare a una decisione informata su tre alternative:

- procedere con una sandbox interna e un piano di implementazione
- restringere o correggere la tesi
- fermare l'iniziativa se il gap con Jira resta troppo ampio o troppo costoso da colmare

## Allegati logici già disponibili

- gap matrix Jira vs Redmine
- tesi di prodotto
- PRD di discovery
- backlog prioritizzato
- bozza di posizionamento commerciale

Questo materiale è già sufficiente per presentare l'iniziativa come opportunità da investigare, non ancora come progetto di delivery approvato.