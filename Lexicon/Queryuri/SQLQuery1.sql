UPDATE Gen
SET Nume = 'Stiinta'
WHERE Cod_gen = 4;

UPDATE Cont
SET Email = 'oprisrares78@gmail.com'
WHERE Cod_cont = 1;

ALTER TABLE Carte
ADD Descriere VARCHAR(255),
    Recenzie VARCHAR(255);
	
	ALTER TABLE Carte
ALTER COLUMN Descriere VARCHAR(MAX);

ALTER TABLE Carte
ALTER COLUMN Recenzie VARCHAR(MAX);

UPDATE Carte
SET Descriere = 'Proprietara unei vile de pe litoral este bântuită de senzații ciudate legate de trecutul acesteia...
La scurt timp după ce Gwenda s-a mutat în noua sa casă, au început să se întâmple lucruri ciudate. În ciuda eforturilor sale de a moderniza locuința, nu a reușit decât să scoată la suprafață trecutul acesteia. Mai mult, simțea o teamă irațională de fiecare dată când urca scările...​
Înfricoșată, Gwenda a apelat la Miss Marple pentru a-și alunga fantomele. Împreună, urmau să rezolve o crimă "perfectă" comisă cu mulți ani în urmă',
    Recenzie = 'Asa cum si titlul sugereaza, este o carte plina de mister si dramatism.'
WHERE Cod_carte = 1;

UPDATE Carte
SET Descriere = 'Sheila Webb, o dactilografă liber-profesionistă, soseşte la Wilbraham Crescent ca să ocupe slujba pentru care a fost angajată. Ceea ce găseşte însă este un cadavru bine îmbrăcat, înconjurat de cinci ceasuri, fiecare indicând o altă oră. Dar până la sosirea poliţiştilor, patru dintre ceasuri au dispărut şi, din nefericire, stăpâna casei, care este oarbă, nu a văzut nimic.
Hercule Poirot, pensionar acum, are din fericire suficient timp să pună cap la cap indiciile din cel mai ciudat caz al carierei sale...',
    Recenzie = 'O poveste captivanta, plina de suspans si mister.'
WHERE Cod_carte = 2;

UPDATE Carte
SET Descriere = 'Cu ochiul său ager, bine-cunoscutul detectiv observă detaliile esențiale și se concentrează asupra lor, reușind, cu inteligența lui ascuțită și remarcabila sa putere de deducție, să rezolve o serie de cazuri ce par insolubile. Pentru Sherlock Holmes nici o provocare nu e prea mare, căci întotdeauna, folosind observația și logica subtilă, el demonstrează că „după ce ai exclus imposibilul, ceea ce rămâne, oricât de improbabil ar părea, este adevărul“.',
    Recenzie = 'O colecție captivantă de povestiri polițiste în care faimosul detectiv Sherlock Holmes rezolvă cazuri ingenioase.'
WHERE Cod_carte = 3;

UPDATE Carte
SET Descriere = 'Acum 100.000 de ani, pe pamant existau cel putin sase specii de oameni. Astazi exista una singura: noi, Homo sapiens. Ce s-a intamplat cu celelalte? Si cum am ajuns sa fim stapanii planetei? De la inceputurile speciei noastre si rolul pe care l-a jucat in ecosistemul global pana in modernitate, Sapiens imbina istoria si stiinta pentru a pune in discutie tot ce stim despre noi insine.',
    Recenzie = 'În această carte este descrisă istoria întregii omeniri în paşi simpli, pe înţelesul tuturor, astfel încât toată lumea are acces facil la informaţii.'
WHERE Cod_carte = 4;

UPDATE Carte
SET Descriere = '„O scurtă istorie ilustrată a românilor” de Neagu Djuvara este o lucrare care îmbină textul accesibil cu o selecție bogată de ilustrații, oferind cititorilor o perspectivă clară și captivantă asupra istoriei poporului român. Prin intermediul imaginilor atent alese, cititorii pot vizualiza figuri marcante precum împărați romani, domnitori și regi ai României, alături de aliații și adversarii lor, precum și politicieni de seamă din diverse epoci.',
    Recenzie = 'Recomand această carte tuturor celor care doresc să descopere istoria românilor într-un mod accesibil și plăcut.'
WHERE Cod_carte = 5;

UPDATE Carte
SET Descriere = 'Un tur extraordinar de bine ghidat printr-o relatare dramatică, profund revelatoare, despre acei oameni care fie din întâmplare, fie cu premeditare au creat lumea noastră de astăzi. Margaret MacMillan propune o selecție inedită de personalități, unele faimoase, altele mai puțin cunoscute, care și-au lăsat amprenta asupra trecutului. Unele au schimbat cursul istoriei și chiar au dat tonul epocilor în care au trăit.',
    Recenzie = 'O carte interesantă despre personalități cunoscute și mai puțin cunoscute.'
WHERE Cod_carte = 6;

UPDATE Carte
SET Descriere = 'Procesul lui Franz Kafka urmareste istoria stranie si tulburatoare a lui Josef K., lucrator la banca si celibatar, care se trezeste intr-o buna zi „arestat” fara sa aiba habar de ce: este momentul cand viata lui se schimba ireversibil. Va incepe un sir de incercari disperate de a afla adevarul si de intamplari halucinante, toate gravitand in jurul unui tribunal fantomatic, necrutator, ale carui victime isi asteapta sentinta fara sa stie daca isi vor capata vreodata libertatea.',
    Recenzie = 'Un roman interesant, ce îți dă de gândit și care merită citit.'
WHERE Cod_carte = 7;

UPDATE Carte
SET Descriere = 'Crimă și pedeapsă, capodopera lui Dostoievski, prezintă în prim‑plan drama lui Raskolnikov, un fost student sărac și idealist care pune la cale o crimă cumplită, ce va zgudui orașul Sankt -Petersburg, atât pentru a -și rezolva problemele financiare, cât și din dorința de a -și demonstra sieși că este îndreptățit să o facă. Deși se consideră o persoană înzestrată cu calități deosebite și simte că decizia de a ucide este justificată, imediat după săvârșirea crimei, protagonistul se îmbolnăvește și are remușcări cu privire la acțiunile sale.',
    Recenzie = 'Cu siguranță una dintre cele mai bune cărți scrise vreodată.'
WHERE Cod_carte = 8;

UPDATE Carte
SET Descriere = '„Frații Karamazov” este ultimul și cel mai complex roman al lui Feodor Dostoievski, considerat o capodoperă a literaturii universale. Povestea se concentrează pe familia Karamazov, alcătuită din patru frați și tatăl lor, Feodor Pavlovici Karamazov, un moșier desfrânat și corupt moral. Fiecare dintre frați reprezintă o ipostază fundamentală a individului. Moartea neașteptată a lui Feodor Pavlovici declanșează o serie de evenimente care aruncă suspiciuni asupra tuturor fraților, fiecare având motive întemeiate pentru a-i dori dispariția.',
    Recenzie = 'O lectură profundă, care ridică întrebări fundamentale despre sensul vieții.'
WHERE Cod_carte = 9;
UPDATE Carte
SET Descriere = 'Cosmos vorbeste despre stiinta si cosmologie, dar si despre descoperirile oamenilor, minunea si puterea curiozitatii umane.
Prin povestirea istoriei descoperirilor umane si ilustrand uimirea si incertitudinea universului si a cosmosului, Carl Sagan ne ofera o privire de ansamblu asupra evolutiei stiintei, incepand de la primele observatii facute de vechii greci si ajungand pana la descoperirile mai recente din domeniul astrofizicii si astronomiei.',
    Recenzie = 'O carte interesantă cu multe informații utile.'
WHERE Cod_carte = 10;
UPDATE Carte
SET Descriere = '„Scurtă istorie a timpului” de Stephen Hawking este o lucrare emblematică ce își propune să explice conceptele fundamentale ale universului într-un mod accesibil publicului larg. În această operă, Hawking abordează întrebări esențiale despre existență. Autorul reușește să prezinte teorii complexe, precum relativitatea generală și mecanica cuantică, utilizând analogii și imagini intuitive care stimulează curiozitatea și înțelegerea cititorilor, indiferent de pregătirea lor științifică.',
    Recenzie = 'O carte excelenta pentru pasionații de știința.'
WHERE Cod_carte = 11;
UPDATE Carte
SET Descriere = '„Oppenheimer” de Jeremy Bernstein este o biografie concisă a lui J. Robert Oppenheimer, fizicianul teoretician cunoscut drept „părintele bombei atomice”. Publicată în 2004, această lucrare oferă o perspectivă unică asupra vieții și carierei lui Oppenheimer, evidențiind atât realizările sale științifice, cât și complexitatea personalității sale. Spre deosebire de alte biografii exhaustive, această carte se concentrează pe aspectele esențiale ale vieții lui Oppenheimer, oferind cititorilor o imagine clară și accesibilă a unui om de știință remarcabil și enigmatic.',
    Recenzie = 'Cartea prezintă portretul unui geniu al fizicii, realizat cu ajutorul celor din jurul lui.'
WHERE Cod_carte = 12;

UPDATE Carte
SET Descriere = '„Mândrie și prejudecată” este unul dintre cele mai cunoscute și îndrăgite romane ale scriitoarei engleze Jane Austen. Acțiunea se desfășoară în Anglia începutului de secol XIX și urmărește viața familiei Bennet, compusă din domnul și doamna Bennet și cele cinci fiice ale lor. Romanul explorează teme precum mândria, prejudecata, statutul social, căsătoria și moralitatea, oferind în același timp o critică subtilă a societății engleze din acea perioadă.',
    Recenzie = 'O carte minunată, plină de ironie și sarcasm, dar ușor de citit.'
WHERE Cod_carte = 13;

UPDATE Carte
SET Descriere = 'Reconstituirea unei pasionante povești de dragoste, eșuată din cauza unor prejudecăți de netrecut. În cercul strâmt al unei familii, fratele intervine brutal în destinul surorii sale. Blestemul sentimentelor împiedicate să se desfășoare în firescul lor se întinde pe mai multe generații, într-un roman cu o atmosferă de o densitate uluitoare.',
    Recenzie = 'O carte adecvată pentru adolescenți, care trezește sentimente puternice.'
WHERE Cod_carte = 14;

UPDATE Carte
SET Descriere = '„Nopți albe” este o nuvelă scrisă de Fiodor Dostoievski, publicată pentru prima dată în 1848. Acțiunea are loc în Sankt Petersburg, pe parcursul a patru nopți și o dimineață, în timpul fenomenului natural cunoscut sub numele de „nopți albe”, când apusurile târzii și răsăriturile timpurii fac ca întunericul nopții să fie aproape inexistent. Tema principală a nuvelei este singurătatea și dorința de conexiune umană. Dostoievski explorează complexitatea emoțiilor umane, contrastul dintre fantezie și realitate și fragilitatea relațiilor interumane.',
    Recenzie = 'Cartea prezintă o poveste delicată, scrisă cu multă sensibilitate.'
WHERE Cod_carte = 15;

UPDATE Carte
SET Descriere = 'Cartea lui Daniel Goleman a marcat o revoluție uluitoare în psihologie prin analiza importanței copleșitoare a emoțiilor în dezvoltarea personalității umane. Studiul său ne explică cum, atunci când ne înțelegem sentimentele, situația în care ne aflăm devine mai limpede. Preluând rezultatele cercetărilor asupra creierului și comportamentului, autorul propune extinderea conceptului de inteligență.',
    Recenzie = 'Este o carte care te ajută să îți înțelegi reacțiile, trăirile tale, dar și pe ale celor din jur.'
WHERE Cod_carte = 16;

UPDATE Carte
SET Descriere = 'Omul în căutarea sensului vieții este cronica experiențelor îngrozitoare trăite de psihiatrul Viktor Frankl în timpul detenției sale la Auschwitz și în alte lagăre concentraționiste. Cartea deschide cea mai intimă perspectivă asupra înțelegerii omului în situații de nesupraviețuit, cum acceptă trauma și în final, găsește sens în ceea ce trăiește.',
    Recenzie = 'O carte deosebită care te trece prin toate emoțiile.'
WHERE Cod_carte = 17;

UPDATE Carte
SET Descriere = 'În cartea „În mintea celorlalți”, Nicholas Epley se apleacă asupra abilității noastre de a citi mintea celorlalți, argumentând că noi credem că suntem mai abili în a citi gândurile și intențiile celorlalți decât sunt de fapt capabili. Epley ne arată care sunt greșelile pe care le facem când încercăm să ne dăm seama ce simt și vor cei din jur, dar oferă și o altă perspectivă despre cum să înțelegem atât propriile stereotipuri cât și pe ale celorlalți.',
    Recenzie = 'Perspectiva oferită de autor asupra minții umane este una inedită și merită explorată.'
WHERE Cod_carte = 18;

UPDATE Carte
SET Descriere = '„Amintiri din copilărie” este una dintre cele mai îndrăgite opere ale literaturii române. Opera este narată la persoana întâi de către Nică, alter ego-ul autorului, și se remarcă prin tonul cald, nostalgic și deseori autoironic. În paginile sale, Creangă descrie cu o sinceritate cuceritoare diverse episoade din copilăria sa. Stilul este popular, autentic, presărat cu regionalisme și expresii moldovenești, iar personajele sunt pitorești și pline de viață.',
    Recenzie = 'O carte care ar trebui să existe în biblioteca tuturor copiilor.'
WHERE Cod_carte = 19;

UPDATE Carte
SET Descriere = '„Enigma Otiliei” este un roman realist de analiză psihologică și socială, scris de George Călinescu și publicat în 1938. Povestea îl are în centrul său pe Felix Sima, un adolescent orfan care vine la București pentru a urma Facultatea de Medicină și este găzduit de unchiul său, Costache Giurgiuveanu. Aici o cunoaște pe Otilia, fiica vitregă a unchiului, o tânără misterioasă și cuceritoare, care devine obiectul fascinației și iubirii lui Felix. Relația lor este marcată de ambiguități, contradicții și jocuri de aparențe, conturând o adevărată enigmă emoțională.',
    Recenzie = 'Una dintre cele mai bune cărți ale literaturii românești interbelice.'
WHERE Cod_carte = 20;

UPDATE Carte
SET Descriere = 'Moara cu noroc este o nuvelă scrisă de Ioan Slavici, tratând consecințele negative pe care setea de îmbogățire le aduce asupra destinului omenesc. Autorul este convins că goana după bani aduce numai rele în viață și, în final, duce la pierzanie. Astfel, Moara cu noroc este o nuvelă psihologică care are loc în satul transilvănean din a doua parte a secolului al XIX-lea.',
    Recenzie = 'O nuvelă importantă, ce pune accent pe valorile umane.'
WHERE Cod_carte = 21;

UPDATE Carte
SET Descriere = 'În Cântecul celulei, Mukherjee povestește cum au fost descoperite celulele și în ce fel biologia celulară conduce la crearea de tratamente novatoare și de oameni noi. Scrisă cu antren, cartea de față oferă o panoramă vie, condimentată cu propria experiență a lui Mukherjee de cercetător, medic și cititor pasionat. Acesta istorisește povești remarcabile cu oameni de știință, medici și pacienți salvați de munca lor.',
    Recenzie = 'O carte cu multe informații utile.'
WHERE Cod_carte = 22;

UPDATE Carte
SET Descriere = 'Uluitorul volum de memorii al lui Paul Kalanithi reprezintă cronica emoționantă și lucidă a transformării unui student la medicină, idealist și entuziast, într-un neurochirurg de succes, cu o carieră importantă în față, apoi în pacient și în tatal care trebuie să-și înfrunte propria moarte.',
    Recenzie = 'O carte foarte emoționantă, care te trece prin multe stări.'
WHERE Cod_carte = 23;

UPDATE Carte
SET Descriere = 'Plecând de la informații științifice de ultimă oră și de la propriile cercetări de pionierat în biochimie, Jessie Inchauspe propune zece metode surprinzător de simple prin care ne putem echilibra nivelurile glucozei din organism, eliminând simptomele negative.',
    Recenzie = 'O carte care vine cu îndrumări pentru un stil de viață mai sănătos.'
WHERE Cod_carte = 24;







