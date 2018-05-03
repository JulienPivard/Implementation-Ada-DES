# vim: nofoldenable: list:
# PIVARD Julien
# Dernière modification : Jeudi 03 mai[05] 2018

SHELL		:= /bin/sh
.DEFAULT_GOAL	:= all
# Ajout du chemin du compilateur gnat dans le path
GNAT_GPR_PROJECT_PATH_LINUX	:= /usr/gnat/lib/gnat
GNAT_LD_LIB_LINUX		:= /usr/gnat/lib
GNAT_BIN_LINUX			:= /usr/gnat/bin

GNAT_GPR_PROJECT_PATH_MACOS	:= /usr/local/gnat/lib/gnat
GNAT_LD_LIB_MACOS		:= /usr/local/gnat/lib
GNAT_BIN_MACOS			:= /usr/local/gnat/bin

ifneq ($(wildcard $(GNAT_BIN_MACOS)), )
    PATH		:= $(GNAT_BIN_MACOS):$(PATH)
    LD_LIBRARY_PATH	:= $(GNAT_LD_LIB_MACOS):$(LD_LIBRARY_PATH)
    GPR_PROJECT_PATH	:= $(GNAT_GPR_PROJECT_PATH_MACOS)
else ifneq ($(wildcard $(GNAT_BIN_LINUX)), )
    PATH		:= $(GNAT_BIN_LINUX):$(PATH)
    LD_LIBRARY_PATH	:= $(GNAT_LD_LIB_LINUX):$(LD_LIBRARY_PATH)
    GPR_PROJECT_PATH	:= $(GNAT_GPR_PROJECT_PATH_LINUX)
endif
# Les suffixes des fichiers dont on va tenir compte
.SUFFIXES:

srcdir		:= .

include ./makefile.conf
include ./application/makefile.template

###############
.PHONY: runapp
runapp:
	$(MAKE) -C application run

###################
.PHONY: $(CIBLECOMPILE)
$(CIBLECOMPILE): build
	@echo "────────────────────────────────────────────"
	@echo "[OK] Compilation des tests unitaires terminé"
	@echo

###################
.PHONY: cleanall
cleanall: clean
	@echo
	@echo
	@echo "━━━━━━━━━━━━━━━━ Effacement des sous répertoires ━━━━━━━━━━━━━━━━"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━ temporaires ━━━━━━━━━━━━━━━━━━━━━━━━━━"
	$(MAKE) -C application clean
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ fin ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

###################
.PHONY: distcleanall
distcleanall: distclean
	@echo
	@echo
	@echo "━━━━━━━━━━━━━━━━ Effacement des sous répertoires ━━━━━━━━━━━━━━━━"
	@echo "━━━━━━━━━━━━━━━━━━━ temporaires et exécutable ━━━━━━━━━━━━━━━━━━━"
	$(MAKE) -C application distclean
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ fin ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

###################
.PHONY: help
help:
	@echo "Liste des commandes :"
	@echo " - all		: Compile les tests unitaire."
	@echo "    - build"
	@echo "    - $(CIBLECOMPILE)"
	@echo " - run		: Execute les tests unitaires"
	@echo " - runapp	: Execute l'application"
	@echo " - clean	: Efface tous les fichiers généré par la compilation des tests unitaire sauf les exécutables."
	@echo " - distclean	: Efface tous les fichiers généré par la compilation des tests unitaires."
	@echo " - cleanall	: Efface tous les fichiers généré par la compilation des tests unitaires et de l'application sauf les exécutables."
	@echo " - distcleanall	: Efface tous les fichiers généré par la compilation des tests unitaires et de l'application."
