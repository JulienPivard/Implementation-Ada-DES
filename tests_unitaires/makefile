# vim: nofoldenable: list:
# PIVARD Julien
# Dernière modification : Dimanche 24 mars[03] 2019

SHELL		:= /bin/sh
.DEFAULT_GOAL	:= all
# Les suffixes des fichiers dont on va tenir compte
.SUFFIXES:

srcdir		:= .

include ./makefile.conf
include ../config/makefile.template

###################
.PHONY: $(CIBLECOMPILE)
$(CIBLECOMPILE): build
	@echo " ────────────────────────────────────────────"
	@echo " [OK] Compilation des tests unitaires terminé"
	@echo "  "

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
