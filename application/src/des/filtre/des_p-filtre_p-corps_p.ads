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

   --  Modifie le numéro du filtre.
   --  @param Filtre
   --  Le filtre.
   --  @param Clef
   --  la clef de 48 bits.
   procedure Modifier_Clef
      (
         Filtre : in out Corps_Abstrait_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abstrait_T'Class
      )
   is abstract;

private

   --  Fonction de cryptage/décryptage F.
   --  @param Bloc
   --  Le bloc de 32 bits
   --  @param Clef
   --  La clef de 48 bits
   --  @return Le bloc transformé
   function Fonction_F
      (
         Bloc : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abstrait_T'Class
      )
      return Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;

   type Corps_Abstrait_T is abstract new Filtre_Interface_T with null record;

end Des_P.Filtre_P.Corps_P;
