with Des_P.Filtre_P.Cryptage_P;

--  @summary
--  Représentation du filtre de permutation principal de cryptage DES.
--  @description
--  Filtre de cryptage permutation principal qui va servir à paramétrer le
--  reste des étages.
--  @group Filtre
package Des_P.Filtre_P.Corps_P.Corps_Cryptage_P is

   pragma Pure;

   --  Le filtre de cryptage principal.
   type Corps_T is new Corps_Abstrait_T and
      Des_P.Filtre_P.Cryptage_P.Cryptage_Interface_T with private;

   overriding
   procedure Filtrer
      (
         Filtre : Corps_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      );

   overriding
   procedure Modifier_Numero
      (
         Filtre : in out Corps_T;
         Numero : Numero_Filtre_T
      );

private

   type Corps_T is new Corps_Abstrait_T and
      Des_P.Filtre_P.Cryptage_P.Cryptage_Interface_T with
      record
         Numero : Numero_Filtre_T;
      end record;

end Des_P.Filtre_P.Corps_P.Corps_Cryptage_P;
