with System;

private
--  @summary
--  Rassemble la configuration des tâches.
--  @description
--  Défini la taille de chaque tâche ainsi que leur priorité.
--  @group Configuration Tâches
package Des_P.Chaine_P.Conf_Tasches_P
   with Pure
is

   type Taille_Tasches_T is range 0 .. Integer'Last;
   --  La taille d'une tâche.

   Taille_Page : constant Taille_Tasches_T := 64;

   Taille_Tasche_Ecriture : constant Taille_Tasches_T :=
      Taille_Page * 1024;
   Taille_Tasche_Sortie   : constant Taille_Tasches_T :=
      Taille_Page * 1024;
   Taille_Tasche_Corps    : constant Taille_Tasches_T :=
      Taille_Page * 1024;
   Taille_Tasche_Entree   : constant Taille_Tasches_T :=
      Taille_Page * 1024;
   Taille_Tasche_Lecture  : constant Taille_Tasches_T :=
      Taille_Page * 1024;

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

end Des_P.Chaine_P.Conf_Tasches_P;
