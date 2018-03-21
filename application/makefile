# vim: nofoldenable: list:
# PIVARD Julien
# Dernière modification : Mercredi 21 mars[03] 2018

SHELL		= /bin/sh
.DEFAULT_GOAL	:= all
# Les suffixes des fichiers dont on va tenir compte
.SUFFIXES:

srcdir		= .

include ./makefile.conf
include ./makefile.checks
include ./makefile.template

ifeq ($(wildcard $(EXECUTABLE_SEQ)), )
    DEPEND	= $(CIBLECOMPILE)
else
    DEPEND	=
endif

ifeq ($(wildcard $(EXECUTABLE_TAC)), )
    DEPEND	= $(CIBLECOMPILE)
else
    DEPEND	=
endif

ifeq ($(wildcard $(EXECUTABLE_RAV)), )
    DEPEND	= $(CIBLECOMPILE)
else
    DEPEND	=
endif

###################
.PHONY: $(CIBLECOMPILE)
$(CIBLECOMPILE): build
	@echo "───────────────────────────────"
	@echo "[OK] Compilation du programme : [ $(NOMAPP) ] terminé"
	@echo

###################
.PHONY: crypt
crypt: $(DEPEND)
	@echo "───────────────────────────────"
	@echo "Cryptage"
	$(EXECUTABLE_SEQ) $(ARGSCRYPT)
	$(EXECUTABLE_TAC) $(ARGSCRYPT)
	$(EXECUTABLE_RAV) $(ARGSCRYPT)

###################
.PHONY: decrypt
decrypt: $(DEPEND)
	@echo "───────────────────────────────"
	@echo "Décryptage"
	$(EXECUTABLE_SEQ) $(ARGSDECRYPTS)
	$(EXECUTABLE_TAC) $(ARGSDECRYPTT)
	$(EXECUTABLE_RAV) $(ARGSDECRYPTR)

###################
.PHONY: fichier_comparer
fichier_comparer:
	@echo "Comparaison : "
	diff $(VARNOMFICHIER) $(VARNOMFICHIER).sequ.crypt.sequ.decrypt
	diff $(VARNOMFICHIER) $(VARNOMFICHIER).task.crypt.task.decrypt
	diff $(VARNOMFICHIER) $(VARNOMFICHIER).rave.crypt.rave.decrypt
	diff $(VARNOMFICHIER).sequ.crypt $(VARNOMFICHIER).task.crypt
	diff $(VARNOMFICHIER).task.crypt $(VARNOMFICHIER).rave.crypt
	diff $(VARNOMFICHIER).sequ.crypt $(VARNOMFICHIER).rave.crypt

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
