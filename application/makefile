# vim: nofoldenable: list:
# PIVARD Julien
# Dernière modification : Mercredi 21 février[02] 2018

SHELL		= /bin/sh
.DEFAULT_GOAL	:= all
# Les suffixes des fichiers dont on va tenir compte
.SUFFIXES:

srcdir		= .

include ./makefile.conf
include ./makefile.checks
include ./makefile.template

###################
.PHONY: $(CIBLECOMPILE)
$(CIBLECOMPILE): build
	@echo "───────────────────────────────"
	@echo "[OK] Compilation du programme : [ $(NOMAPP) ] terminé"
	@echo

###################
.PHONY: crypt
crypt:
	@echo "───────────────────────────────"
	@echo "Cryptage"
	$(EXECUTABLE) $(ARGSCRYPT)

###################
.PHONY: decrypt
decrypt:
	@echo "───────────────────────────────"
	@echo "Décryptage"
	$(EXECUTABLE) $(ARGSDECRYPT)

###################
.PHONY: doc
doc:
	gnatdoc -P$(GPR) $(OPTGPR) $(OPTDOCUMENT)

###################
.PHONY: cleandoc
cleandoc:
	$(RM) $(OPTRM) doc

###################
.PHONY: help
help:
	@echo "Liste des commandes :"
	@echo " - all		: Compile l'application."
	@echo "    - build"
	@echo "    - $(CIBLECOMPILE)"
	@echo " - doc		: Génère la documentation du programme."
	@echo " - cleandoc	: Supprime la documentation généré."
	@echo " - run		: Execute l'application avec les paramètres défini."
	@echo " - clean	: Efface tous les fichiers généré par le compilateur sauf les exécutables."
	@echo " - distclean	: Efface tous les fichiers généré par le compilateur."
