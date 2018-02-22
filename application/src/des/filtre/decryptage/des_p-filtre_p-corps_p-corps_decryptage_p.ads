with Des_P.Filtre_P.Decryptage_P;

--  @summary
--  Représentation du filtre de permutation principal de cryptage DES.
--  @description
--  Filtre de cryptage permutation principal qui va servir à paramétrer le
--  reste des étages.
--  @group Filtre Décryptage
package Des_P.Filtre_P.Corps_P.Corps_Decryptage_P is

   pragma Pure;

   --  Le filtre de cryptage principal.
   type Corps_T is new Corps_Abstrait_T and
      Des_P.Filtre_P.Decryptage_P.Decryptage_Interface_T with private;

   overriding
   --  Filtre le bloc de 64 bits avec la clef de 56 bits.
   --  @param Filtre
   --  Le filtre.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Clef
   --  la clef de 56 bits.
   procedure Filtrer
      (
         Filtre : Corps_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      );

   overriding
   procedure Filtrer
      (
         Filtre : Corps_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Abs_T'Class
      );

   overriding
   --  Modifie le numéro du filtre.
   --  @param Filtre
   --  Le filtre.
   --  @param Numero
   --  Le numéro à attribuer au filtre.
   procedure Modifier_Numero
      (
         Filtre : in out Corps_T;
         Numero : Numero_Filtre_T
      );

private

   type Corps_T is new Corps_Abstrait_T and
      Des_P.Filtre_P.Decryptage_P.Decryptage_Interface_T with
      record
         Numero : Numero_Filtre_T;
      end record;

end Des_P.Filtre_P.Corps_P.Corps_Decryptage_P;
