with Des_P.Bloc_P.Bloc_32_P;
with Des_P.Clef_P.Clef_48_Abs_P;

--  @summary
--  Représentation abstraite des filtres de DES.
--  @description
--  Filtre principale abstrait qui va servir à paramétrer
--  chaque étages de la chaine.
--  @group Filtre
package Des_P.Filtre_P.Corps_P is

   pragma Pure;

   --  Un filtre de corps abstrait.
   type Corps_Abstrait_T is abstract new Filtre_Interface_T with private;

   --  Le numéro du filtre représente la position
   --  dans la suite des filtres
   type Numero_Filtre_T is range 1 .. 16;

   --  Modifie le numéro du filtre.
   --  @param Filtre
   --  Le filtre.
   --  @param Numero
   --  Le numéro à attribuer au filtre.
   procedure Modifier_Numero
      (
         Filtre : in out Corps_Abstrait_T;
         Numero : Numero_Filtre_T
      )
   is abstract;

private

   function Fonction_F
      (
         Bloc : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abs_T'Class
      )
      return Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;

   Table_Decalage : constant
      array (Numero_Filtre_T)
      of Des_P.Clef_P.Clef_56_Abs_P.Decalage_T :=
      (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1);

   type Corps_Abstrait_T is abstract new Filtre_Interface_T with null record;

end Des_P.Filtre_P.Corps_P;
