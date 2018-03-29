with Des_P.Bloc_P.Bloc_32_P;
with Des_P.Clef_P.Clef_48_I_P;

--  @summary
--  Représentation abstraite des filtres de DES.
--  @description
--  Filtre principale abstrait qui va servir à paramétrer
--  chaque étages de la chaine.
--  @group Filtre
package Des_P.Filtre_P.Corps_P is

   pragma Pure;

   type Corps_Abstrait_T is abstract new Filtre_Interface_T with private;
   --  Un filtre de corps abstrait.

   procedure Modifier_Clef
      (
         Filtre : in out Corps_Abstrait_T;
         Clef : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      )
   is abstract;
   --  Modifie le numéro du filtre.
   --  @param Filtre
   --  Le filtre.
   --  @param Clef
   --  la clef de 48 bits.

private

   function Fonction_F
      (
         Bloc : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
         Clef : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      )
      return Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
   --  Fonction de chiffrement/déchiffrement F.
   --  @param Bloc
   --  Le bloc de 32 bits
   --  @param Clef
   --  La clef de 48 bits
   --  @return Le bloc transformé

   type Corps_Abstrait_T is abstract new Filtre_Interface_T with null record;

end Des_P.Filtre_P.Corps_P;
