--  @summary
--  Représentation du filtre de permutation final de cryptage DES.
--  @description
--  Filtre de cryptage permutation final qui va servir à paramétrer le
--  dernier étage des filtres.
--  @group Filtre
package Des_P.Filtre_P.Cryptage_P.Op_P is

   --  Le filtre de cryptage qui va effectuer la permutation final
   type Sortie_T is new Cryptage_Abstrait_T with private;

   overriding
   procedure Filtrer
      (
         Filtre : Sortie_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      );

   overriding
   procedure Modifier_Numero
      (
         Filtre : in out Sortie_T;
         Numero : Numero_Filtre_T
      );

private

   type Sortie_T is new Cryptage_Abstrait_T with null record;

end Des_P.Filtre_P.Cryptage_P.Op_P;
