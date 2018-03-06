with Des_P.Filtre_P.Decryptage_Interface_P;

private with Des_P.Clef_P.Clef_48_I_P.Holder_P;

--  @summary
--  Représentation du filtre de permutation principal de cryptage DES.
--  @description
--  Filtre de cryptage permutation principal qui va servir à paramétrer le
--  reste des étages.
--  @group Filtre Décryptage
package Des_P.Filtre_P.Corps_P.Decryptage_P is

   package P_Decryptage_P renames Des_P.Filtre_P.Decryptage_Interface_P;

   type Corps_T is new Corps_Abstrait_T and
      P_Decryptage_P.Decryptage_Interface_T with private;
   --  Le filtre de cryptage principal.

   overriding
   procedure Filtrer
      (
         Filtre : Corps_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      );
   --  Filtre le bloc de 64 bits avec la clef de 48 bits.
   --  @param Filtre
   --  Le filtre.
   --  @param Bloc
   --  Le bloc de 64 bits.

   overriding
   procedure Modifier_Clef
      (
         Filtre : in out Corps_T;
         Clef : Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T'Class
      );
   --  Modifie la clef du filtre.
   --  @param Filtre
   --  Le filtre.
   --  @param Clef
   --  la clef de 48 bits.

private

   type Corps_T is new Corps_Abstrait_T and
      P_Decryptage_P.Decryptage_Interface_T with
      record
         Clef : Des_P.Clef_P.Clef_48_I_P.Holder_P.Holder;
      end record;

end Des_P.Filtre_P.Corps_P.Decryptage_P;
