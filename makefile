# vim: nofoldenable: list:
# PIVARD Julien
# Dernière modification : Samedi 21 septembre[09] 2019

SHELL		:= /bin/sh
.DEFAULT_GOAL	:= all
# Les suffixes des fichiers dont on va tenir compte
.SUFFIXES:

srcdir		:= .

include ./makefile.conf
include ./config/makefile.checks
include ./config/makefile.template

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
	@echo " ───────────────────────────────"
	@echo " [OK] Compilation du programme : [ $(NOMAPP) ] terminé"
	@echo "  "

###################
.PHONY: chiffrer
chiffrer: $(DEPEND)
	@echo "───────────────────────────────"
	@echo "Chiffrement"
	$(EXECUTABLE_SEQ) $(ARGSCHIFFRE)
	$(EXECUTABLE_TAC) $(ARGSCHIFFRE)
	$(EXECUTABLE_RAV) $(ARGSCHIFFRE)

###################
.PHONY: dechiffrer
dechiffrer: $(DEPEND)
	@echo "───────────────────────────────"
	@echo "Déchiffrement"
	$(EXECUTABLE_SEQ) $(ARGSDECHIFFRES)
	$(EXECUTABLE_TAC) $(ARGSDECHIFFRET)
	$(EXECUTABLE_RAV) $(ARGSDECHIFFRER)

###################
.PHONY: fichier_comparer
fichier_comparer:
	@echo "Comparaison : "
	-diff $(VARNOMFICHIER) $(VARNOMFICHIER).$(EXTENSION_DECHIFFRE_S)
	-diff $(VARNOMFICHIER) $(VARNOMFICHIER).$(EXTENSION_DECHIFFRE_T)
	-diff $(VARNOMFICHIER) $(VARNOMFICHIER).$(EXTENSION_DECHIFFRE_R)
	-diff $(VARNOMFICHIER).$(EXTENSION_CHIFFRE_S) $(VARNOMFICHIER).$(EXTENSION_CHIFFRE_T)
	-diff $(VARNOMFICHIER).$(EXTENSION_CHIFFRE_T) $(VARNOMFICHIER).$(EXTENSION_CHIFFRE_R)
	-diff $(VARNOMFICHIER).$(EXTENSION_CHIFFRE_S) $(VARNOMFICHIER).$(EXTENSION_CHIFFRE_R)

###################
.PHONY: doc
doc:
	gnatdoc -P$(GPR) $(OPTGPR) $(OPTDOCUMENT)

###################
.PHONY: prove
prove:
	gnatprove -P$(GPR) $(OPTGPR) --level=$(NIVEAU_PREUVE) --report=all

###################
.PHONY: check
check:
	gnatcheck -P$(GPR) $(OPTGPR) $(OPT_CHECK)

###################
.PHONY: pretty
pretty:
	gnatpp -P$(GPR) $(Fic)

###################
.PHONY: cleandoc
cleandoc:
	$(RM) $(OPTRM) doc

###################
.PHONY: help
help:
	@echo "Liste des commandes :"
	@echo " - all			: Compile l'application."
	@echo "    - build"
	@echo "    - $(CIBLECOMPILE)"
	@echo " - run			: Execute l'application avec les paramètres défini."
	@echo " - doc			: Génère la documentation du programme."
	@echo " "
	@echo " -  clean		: Efface tous les fichiers généré par le compilateur sauf les exécutables."
	@echo " - distclean		: Efface tous les fichiers généré par le compilateur."
	@echo " - cleandoc		: Supprime la documentation généré."
	@echo " "
	@echo " -  check		: Lance la vérification des règles de programmation sur les sources."
	@echo " -  prove		: Exécute l'outil gnatprove sur les fichiers sources."
	@echo " - pretty		: Reformate le fichier désigné par Fic=/nom/du/fichier."
	@echo " "
	@echo " - compter		: Compte le nombre de lignes de code source."
	@echo "    - avec_find"
	@echo "    - avec_cloc"
	@echo " - compter_detail	: Compte le nombre de lignes de code source par fichier."
	@echo "    - avec_find_detail"
	@echo "    - avec_cloc_detail"
	@echo " "
	@echo " - version_makefile	: La version des makefiles."
	@echo " "
	@echo " - chiffrer		: Chiffre le fichier donné par VARNOMFICHIER dans makefile.conf:100"
	@echo " - dechiffrer		: Déchiffre les fichiers du chiffrement"
	@echo " - fichier_comparer	: Compare les versions chiffrées et déchiffrées entre elles"
