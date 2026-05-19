import os
import sys
import subprocess

# ====================================
# BASE DIRECTORY
# ====================================

if getattr(sys, 'frozen', False):
    BASE_DIR = os.path.dirname(sys.executable)
else:
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# ====================================
# NOB
# ====================================

VERSION = "1.0"

# ====================================
# HELP
# ====================================

def show_help():
    print("No Open Bin")
    print(f"Versione {VERSION}")
    print()
    print("Comandi:")
    print("nob -p <programma> [argomenti]")
    print("Avvia un programma installato.")
    print()
    print("Esempio:")
    print("nob -p tets")
    print("nob -p tets hello")

# ====================================
# CONTROLLO ARGOMENTI
# ====================================

if len(sys.argv) < 2:
    show_help()
    sys.exit()

# ====================================
# FLAG -p
# ====================================

if sys.argv[1] == "-p":

    # =========================
    # CONTROLLO NOME PROGRAMMA
    # =========================

    if len(sys.argv) < 3:
        print("Errore: nessun programma specificato.")
        sys.exit()

    PROGRAMMA = sys.argv[2]

    # =========================
    # PATH PROGRAMMA
    # =========================

    EXE_PATH = os.path.join(
        BASE_DIR,
        "Lib",
        PROGRAMMA,
        f"{PROGRAMMA}.exe"
    )

    # =========================
    # CONTROLLO FILE
    # =========================

    if not os.path.exists(EXE_PATH):
        print(f"Programma '{PROGRAMMA}' non trovato.")
        sys.exit()

    # =========================
    # ARGOMENTI EXTRA
    # =========================

    EXTRA_ARGS = sys.argv[3:]

    # =========================
    # AVVIO
    # =========================

    subprocess.run([EXE_PATH] + EXTRA_ARGS)

# ====================================
# HELP
# ====================================

elif sys.argv[1] == "help":
    show_help()

else:
    print("Comando non valido.")
    print("NoOpenBin 1.0.0 ")