# vim: nofoldenable: list:
# PIVARD Julien
# Dernière modification : Dimanche 26 mai[05] 2024

SHELL		:= /bin/sh
.DEFAULT_GOAL	:= all
# Les suffixes des fichiers dont on va tenir compte
.SUFFIXES:

srcdir		:= .

DOSSIER_MAKE	:= dossier_makefiles

include ./$(DOSSIER_MAKE)/makefile.fixe
ifeq ($(wildcard makefile.conf), )
    include ./$(DOSSIER_MAKE)/makefile.conf.tmpl
else
    include ./makefile.conf
endif
include ./$(DOSSIER_MAKE)/makefile.checks
include ./dossier_makefiles/makefile.template
    include ./$(DOSSIER_MAKE)/makefile_tests_unitaires

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
$(DOSSIER_MAKE)/makefile.conf.tmpl:

###################
makefile.conf: $(DOSSIER_MAKE)/makefile.conf.tmpl
	cp ./$(DOSSIER_MAKE)/makefile.conf.tmpl ./makefile.conf
	chmod u+w ./makefile.conf
	@echo " "

###################
.PHONY: run
run: $(DEPEND)
	$(RESLT_COMPIL) $(ARGUMENTS_APPLI)

###################
.PHONY: compiler
compiler: makefile.conf build
	@echo " ───────────────────────────────"
	@echo " [OK] Compilation du programme : [ $(NOM_APP) ] terminé"
	@echo "  "

###################
.PHONY: prod
prod: makefile.conf $(FAIRE_INITIALISATION)
	which $(COMPILATEUR)
	$(CC) -P$(GPR) $(OPT_GPR_PROD)
	@echo " ─────────────────────────────────────────────────────────────────"
	@echo " Résultat écrit dans [$(RESLT_COMPIL_PROD)]"
	@echo " ─────────────────────────────────────────────────────────────────"

###################
.PHONY: chiffrer
chiffrer: makefile.conf $(DEPEND) $(VARNOMFICHIER)
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
dechiffrer: makefile.conf $(DEPEND) $(NOM_FIC_CHIFFRE_S) \
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
doc: makefile.conf $(FAIRE_INITIALISATION)
	which $(GNAT_DOC)
	$(GNAT_DOC) -P$(GPR) $(OPT_GPR) $(OPT_DOCUMENT)

###################
.PHONY: prove
prove: makefile.conf $(FAIRE_INITIALISATION)
	which $(GNATPROVE)
	$(GNATPROVE) -P$(GPR) $(OPT_GPR) $(NIVEAU) $(RAPPORT) $(MODE_EXE)

###################
.PHONY: check
check: makefile.conf $(FAIRE_INITIALISATION)
	which $(GNATCHECK)
	$(GNATCHECK) -P$(GPR) $(OPT_GPR) $(OPT_CHECK)

###################
.PHONY: pretty
pretty: makefile.conf $(FAIRE_INITIALISATION)
	which $(GNATPP)
	$(GNATPP) -P$(GPR) $(Fichier)

###################
.PHONY: cleandoc
cleandoc: makefile.conf
	$(RM) $(OPT_RM) doc

###################
.PHONY: help
help: makefile.conf
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
ifneq  ($(wildcard ./$(DOSSIER_MAKE)/makefile_tests_unitaires), )
	@echo " "
	@echo " - tests_unitaire	: Compile les tests unitaire."
	@echo "    - compiler_tests_unitaire"
	@echo " - run_tests_unitaire	: Execute les tests unitaires."
endif
