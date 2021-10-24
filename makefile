# vim: nofoldenable: list:
# PIVARD Julien
# Dernière modification : Dimanche 24 octobre[10] 2021

SHELL		:= /bin/sh
.DEFAULT_GOAL	:= all
# Les suffixes des fichiers dont on va tenir compte
.SUFFIXES:

srcdir		:= .

include ./config/makefile.fixe
include ./makefile.conf
include ./config/makefile.checks
include ./config/makefile.template

# Vérifie si le binaire existe. Sinon il ajoute la cible de compilation
# en dépendance.
ifeq ($(wildcard $(RESLT_COMPIL)), )
    DEPEND	= compiler
else
    DEPEND	=
endif

ifeq ($(wildcard $(EXECUTABLE_TAC)), )
    DEPEND	= compiler
else
    DEPEND	=
endif

ifeq ($(wildcard $(EXECUTABLE_RAV)), )
    DEPEND	= compiler
else
    DEPEND	=
endif

###################
.PHONY: run
run: $(DEPEND)
	$(RESLT_COMPIL) $(ARGUMENTSAPPLI)

###################
.PHONY: compiler
compiler: build
	@echo " ───────────────────────────────"
	@echo " [OK] Compilation du programme : [ $(NOMAPP) ] terminé"
	@echo "  "

###################
.PHONY: prod
prod: $(FAIRE_INITIALISATION)
	$(CC) -P$(GPR) $(OPT_GPR_PROD)

###################
.PHONY: chiffrer
chiffrer: $(DEPEND) $(VARNOMFICHIER)
	@echo "───────────────────────────────"
	@echo "Chiffrement"
	$(RESLT_COMPIL) $(ARGSCHIFFRE)
	$(EXECUTABLE_TAC) $(ARGSCHIFFRE)
	$(EXECUTABLE_RAV) $(ARGSCHIFFRE)

###################
$(NOM_FIC_CHIFFRE_S): chiffrer

###################
$(NOM_FIC_CHIFFRE_T): chiffrer

###################
$(NOM_FIC_CHIFFRE_R): chiffrer

###################
.PHONY: dechiffrer
dechiffrer: $(DEPEND) $(NOM_FIC_CHIFFRE_S) \
	$(NOM_FIC_CHIFFRE_T) $(NOM_FIC_CHIFFRE_R)
	@echo "───────────────────────────────"
	@echo "Déchiffrement"
	$(RESLT_COMPIL) $(ARGSDECHIFFRES)
	$(EXECUTABLE_TAC) $(ARGSDECHIFFRET)
	$(EXECUTABLE_RAV) $(ARGSDECHIFFRER)

###################
$(NOM_FIC_DECHIFFRE_S): dechiffrer

###################
$(NOM_FIC_DECHIFFRE_T): dechiffrer

###################
$(NOM_FIC_DECHIFFRE_R): dechiffrer

###################
.PHONY: fichier_comparer
fichier_comparer: $(DEPEND) $(NOM_FIC_DECHIFFRE_S) $(NOM_FIC_DECHIFFRE_T) \
	$(NOM_FIC_DECHIFFRE_R) $(NOM_FIC_CHIFFRE_S) $(NOM_FIC_CHIFFRE_T) \
	$(NOM_FIC_CHIFFRE_R)
	@echo "Comparaison : "
	-diff $(VARNOMFICHIER) $(NOM_FIC_DECHIFFRE_S)
	-diff $(VARNOMFICHIER) $(NOM_FIC_DECHIFFRE_T)
	-diff $(VARNOMFICHIER) $(NOM_FIC_DECHIFFRE_R)
	-diff $(NOM_FIC_CHIFFRE_S) $(NOM_FIC_CHIFFRE_T)
	-diff $(NOM_FIC_CHIFFRE_T) $(NOM_FIC_CHIFFRE_R)
	-diff $(NOM_FIC_CHIFFRE_R) $(NOM_FIC_CHIFFRE_S)

###################
.PHONY: doc
doc: $(FAIRE_INITIALISATION)
	gnatdoc -P$(GPR) $(OPTGPR) $(OPTDOCUMENT)

###################
.PHONY: prove
prove: $(FAIRE_INITIALISATION)
	gnatprove -P$(GPR) $(OPTGPR) --level=$(NIVEAU_PREUVE) --report=all

###################
.PHONY: check
check: $(FAIRE_INITIALISATION)
	gnatcheck -P$(GPR) $(OPTGPR) $(OPT_CHECK)

###################
.PHONY: pretty
pretty: $(FAIRE_INITIALISATION)
	gnatpp -P$(GPR) $(Fichier)

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
	@echo "    - compiler"
	@echo " - prod			: Compile avec l'option release active."
	@echo " - run			: Execute l'application avec les paramètres défini."
	@echo " - doc			: Génère la documentation du programme."
	@echo " "
	@echo " - clean 		: Efface tous les fichiers généré par le compilateur sauf les exécutables."
	@echo " - distclean		: Efface tous les fichiers généré par le compilateur."
	@echo " - cleandoc		: Supprime la documentation généré."
	@echo " "
	@echo " -  check		: Lance la vérification des règles de programmation sur les sources."
	@echo " -  prove		: Exécute l'outil gnatprove sur les fichiers sources."
	@echo " - pretty		: Reformate le fichier désigné par Fichier=/nom/du/fichier."
	@echo " "
	@echo " - compter		: Compte le nombre de lignes de code source."
	@echo "    - avec_find"
	@echo "    - avec_cloc"
	@echo " - compter_detail	: Compte le nombre de lignes de code source par fichier."
	@echo "    - avec_find_detail"
	@echo "    - avec_cloc_detail"
	@echo " "
	@echo " - maj_sous_modules	: Met à jour les sous modules"
	@echo " "
	@echo " - version_makefile	: La version des makefiles."
	@echo " "
	@echo " - chiffrer		: Chiffre le fichier donné par VARNOMFICHIER dans makefile.conf:100"
	@echo " - dechiffrer		: Déchiffre les fichiers du chiffrement"
	@echo " - fichier_comparer	: Compare les versions chiffrées et déchiffrées entre elles"
