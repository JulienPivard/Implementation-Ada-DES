with Des_P.Filtre_P.Cryptage_P;

private with Des_P.Clef_P.Clef_48_Abs_P.Holder_P;

--  @summary
--  Représentation du filtre de permutation principal de cryptage DES.
--  @description
--  Filtre de cryptage permutation principal qui va servir à paramétrer le
--  reste des étages.
--  @group Filtre Cryptage
package Des_P.Filtre_P.Corps_P.Corps_Cryptage_P is

   --  Le filtre de cryptage principal.
   type Corps_T is new Corps_Abstrait_T and
      Des_P.Filtre_P.Cryptage_P.Cryptage_Interface_T with private;

   overriding
   --  Filtre le bloc de 64 bits avec la clef de 48 bits.
   --  @param Filtre
   --  Le filtre.
   --  @param Bloc
   --  Le bloc de 64 bits.
   procedure Filtrer
      (
         Filtre : Corps_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      );

   overriding
   --  Modifie la clef du filtre.
   --  @param Filtre
   --  Le filtre.
   --  @param Clef
   --  la clef de 48 bits.
   procedure Modifier_Clef
      (
         Filtre : in out Corps_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abstrait_T'Class
      );

private

   type Corps_T is new Corps_Abstrait_T and
      Des_P.Filtre_P.Cryptage_P.Cryptage_Interface_T with
      record
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Holder_P.Holder;
      end record;

end Des_P.Filtre_P.Corps_P.Corps_Cryptage_P;
