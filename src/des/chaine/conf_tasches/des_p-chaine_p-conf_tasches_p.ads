with System;

private
--  @summary
--  Rassemble la configuration des tâches.
--  @description
--  Défini la priorité de chaque tâches.
--  @group Configuration Tâches
package Des_P.Chaine_P.Conf_Tasches_P
   with Pure
is

   use type System.Priority;

   Priorite_Moyenne : constant System.Priority :=
      (System.Priority'Last - System.Priority'First) / 2;

   subtype Priorite_Tasches_T is System.Priority
      range System.Priority'First .. Priorite_Moyenne;
   --  L'intervalle des priorités des tâches.

   Priorite_Par_Defaut_Tasche : constant Priorite_Tasches_T :=
      (Priorite_Tasches_T'Last - Priorite_Tasches_T'First) / 2;
   --  Priorité par défaut d'une tâche.

   Priorite_Tasche_Ecriture : constant Priorite_Tasches_T :=
      Priorite_Par_Defaut_Tasche;
   Priorite_Tasche_Sortie   : constant Priorite_Tasches_T :=
      Priorite_Par_Defaut_Tasche;
   Priorite_Tasche_Corps    : constant Priorite_Tasches_T :=
      Priorite_Par_Defaut_Tasche;
   Priorite_Tasche_Entree   : constant Priorite_Tasches_T :=
      Priorite_Par_Defaut_Tasche;
   Priorite_Tasche_Lecture  : constant Priorite_Tasches_T :=
      Priorite_Par_Defaut_Tasche;

   subtype Priorite_Objet_Protege_T is System.Priority
      range Priorite_Moyenne .. System.Priority'Last;
   --  L'intervalle des priorité des objets protégé.

   Priorite_Par_Defaut_Objet_Protege : constant Priorite_Objet_Protege_T :=
      Priorite_Objet_Protege_T'First
      +
      ((Priorite_Objet_Protege_T'Last - Priorite_Objet_Protege_T'First) / 2);
   --  Priorité par défaut d'un objet protégé.

   Priorite_Objet_Avorter        : constant Priorite_Objet_Protege_T :=
      Priorite_Objet_Protege_T'First;
   Priorite_Objet_Rearmement     : constant Priorite_Objet_Protege_T :=
      Priorite_Objet_Protege_T'First;
   Priorite_Objet_Demarreur      : constant Priorite_Objet_Protege_T :=
      Priorite_Objet_Protege_T'First;
   Priorite_Objet_Signale_Fin    : constant Priorite_Objet_Protege_T :=
      Priorite_Objet_Protege_T'First;
   Priorite_Objet_Filtre_Entree  : constant Priorite_Objet_Protege_T :=
      Priorite_Objet_Protege_T'First;
   Priorite_Objet_Filtre_Sortie  : constant Priorite_Objet_Protege_T :=
      Priorite_Objet_Protege_T'First;
   Priorite_Objet_Filtre_Corps   : constant Priorite_Objet_Protege_T :=
      Priorite_Objet_Protege_T'First;

   Priorite_Objet_Autorisation   : constant Priorite_Objet_Protege_T :=
      Priorite_Par_Defaut_Objet_Protege;
   Priorite_Objet_Donnees        : constant Priorite_Objet_Protege_T :=
      Priorite_Par_Defaut_Objet_Protege;

end Des_P.Chaine_P.Conf_Tasches_P;
