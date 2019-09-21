# vim: nofoldenable: list:
# PIVARD Julien
# Dernière modification : Samedi 21 septembre[09] 2019

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
	@echo " - all			: Compile les tests unitaire."
	@echo "    - build"
	@echo "    - $(CIBLECOMPILE)"
	@echo " - run			: Execute les tests unitaires"
	@echo " "
	@echo " -  clean		: Efface tous les fichiers généré par la compilation des tests unitaires sauf les exécutables."
	@echo " - distclean		: Efface tous les fichiers généré par la compilation des tests unitaires."
	@echo " "
	@echo " - compter		: Compte le nombre de lignes de code source des tests unitaires."
	@echo "    - avec_find"
	@echo "    - avec_cloc"
	@echo " - compter_detail	: Compte le nombre de lignes de code source des tests unitaires par fichier."
	@echo "    - avec_find_detail"
	@echo "    - avec_cloc_detail"
	@echo " "
	@echo " - version_makefile	: La version des makefiles."
