<div align="center">
  
  <img width="102" height="100" alt="icon" src="https://github.com/user-attachments/assets/37f970bd-6222-4e52-8292-acc2c0225272" />

  <h1>Questo è No Open Bin v1.0.0</h1>

</div>

---

## Installazione

Per installare l'ultima versione di No Open Bin aprite una PowerShell e digitate il comando:

```powershell
irm https://raw.githubusercontent.com/DeMENIGECO/NoOpenBin/refs/heads/main/INSTALL.bat -OutFile INSTALL.bat; cmd /c INSTALL.bat
```

vedrete

```text
No Open Bin Installer Manager


Comandi:

- nim install
   Installa
- nim escape
   Esci

>>
```

Installate con `nim install`.

Poi, quando avete finito l'installazione, digitate `nim escape`.

Facciamo un test veloce, digitate nel terminale:

```bash
nob help
```

Dovrà uscire:

```text
No Open Bin
Versione 1.0

Comandi:
nob -p <programma> [argomenti]
Avvia un programma installato.

Esempio:
nob -p tets
nob -p tets hello
PS C:\Users\Rosario e Domenico>
```

Se non esce, provate a reinstallarlo.

---

## Installare un paccheto con NPI

**NPI** è l'acronimo di **NoOpenBin Package Installer**.

Installiamo il nostro primo pacchetto: `tets`.

Ecco i comandi e l'output:

```text
PS C:\Users\Rosario e Domenico> nob -p npi install
=============================
            NPI
=============================
Inserisci il pacchetto da installare: tets
Inserisci la versione del pacchetto: 0.1.1
raccogliendo tets...
download tets...
installazione...

Il pacchetto e' stato installato
Premere un tasto per continuare . . .
PS C:\Users\Rosario e Domenico>
```

E dopo digitate:

```tets
nob -p tets
```

Stamperà:

```text
Funziona NPI!
```

---

## DEV: Buildare un pacchetto per NPI

Potete fare la whell (ruota) di un pacchetto.

Ecco come.

Create una cartella, ad esempio `mio_progetto_npi` e metteteci, per primo file `manifest.json`.

Ad Esempio:

```json
[
    {
        "project.details":{
            "name": "mioprogramma", 
            "version": "0.1.0",
            "eseguible": "mioprogramma.exe",
            "descripcion": "Test per NPI."
        },

        "npi.build-system": {
            "setuptools":"1.0"
        }
    }
]
```

Poi dobbiamo avere l'eseguibile `mioprogramma.exe` (il nome deve conincidere con `name` del manifest, e deve avere l'icona che potete trovare nella cartella npi del repository), e infine un file LICENSE, con la licenza del programma.
Comprimete tutto il contenuto nella cartella in zip.

Poi nel terminale fate:

```text
PS C:\Users\Rosario e Domenico> nob -p npi build
==========================
    NPI Wheel Builder
==========================

Percorso file ZIP: (senza virgolette) C:\Users\Rosario e Domenico\Desktop\tets\mio_progetto_npi.zip
Formato (whl/nopkg) [default nopkg]:
Manifest trovato.

==========================
Name: mioprogramma
Version: 0.1.0
Executable: mioprogramma.exe
Setuptools: 1.0
==========================


==========================
NPI Setuptools 1.0
==========================

Creazione wheel...

Wheel creato:
C:\Users\Rosario e Domenico\mioprogramma_0.1.0-AnyWheel.nopkg

Premere un tasto per continuare . . .
```
