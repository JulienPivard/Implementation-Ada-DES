with Des_P.Filtre_P.Cryptage_Interface_P;

--  @summary
--  Représentation du filtre de permutation final de chiffrement DES.
--  @description
--  Filtre de chiffrement permutation final qui va servir à paramétrer le
--  dernier étage des filtres.
--  @group Filtre Chiffrement
package Des_P.Filtre_P.Sortie_P.Cryptage_P is

   pragma Pure;

   package P_Cryptage_P renames Des_P.Filtre_P.Cryptage_Interface_P;

   type Sortie_T is new Sortie_Abstrait_T and
      P_Cryptage_P.Cryptage_Interface_T with private;
   --  Le filtre de chiffrement qui va effectuer la permutation final

   overriding
   procedure Filtrer
      (
         Filtre : Sortie_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      );
   --  Filtre le bloc de 64 bits.
   --  @param Filtre
   --  Le filtre.
   --  @param Bloc
   --  Le bloc de 64 bits.

private

   type Sortie_T is new Sortie_Abstrait_T and
      P_Cryptage_P.Cryptage_Interface_T with null record;

end Des_P.Filtre_P.Sortie_P.Cryptage_P;
