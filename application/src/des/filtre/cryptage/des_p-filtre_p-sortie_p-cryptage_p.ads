with Des_P.Filtre_P.Cryptage_Interface_P;

--  @summary
--  Représentation du filtre de permutation final de cryptage DES.
--  @description
--  Filtre de cryptage permutation final qui va servir à paramétrer le
--  dernier étage des filtres.
--  @group Filtre Cryptage
package Des_P.Filtre_P.Sortie_P.Cryptage_P is

   pragma Pure;

   package P_Cryptage_P renames Des_P.Filtre_P.Cryptage_Interface_P;

   --  Le filtre de cryptage qui va effectuer la permutation final
   type Sortie_T is new Sortie_Abstrait_T and
      P_Cryptage_P.Cryptage_Interface_T with private;

   overriding
   --  Filtre le bloc de 64 bits.
   --  @param Filtre
   --  Le filtre.
   --  @param Bloc
   --  Le bloc de 64 bits.
   procedure Filtrer
      (
         Filtre : Sortie_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      );

private

   type Sortie_T is new Sortie_Abstrait_T and
      P_Cryptage_P.Cryptage_Interface_T with null record;

end Des_P.Filtre_P.Sortie_P.Cryptage_P;