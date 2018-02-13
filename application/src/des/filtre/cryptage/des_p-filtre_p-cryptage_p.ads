--  @summary
--  Représentation abstraite des filtres de cryptage de DES.
--  @description
--  Filtre abstrait de cryptage qui va servir à paramétrer chaque étage
--  de la chaine.
--  @group Filtre
package Des_P.Filtre_P.Cryptage_P is

   pragma Pure;

   --  Un filtre de cryptage abstrait.
   type Cryptage_Abstrait_T is abstract
      new Filtre_Abstrait_T with private;

   overriding
   procedure Filtrer
      (
         Filtre : Cryptage_Abstrait_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      )
   is abstract;

   overriding
   procedure Modifier_Numero
      (
         Filtre : in out Cryptage_Abstrait_T;
         Numero : Numero_Filtre_T
      )
   is abstract;

private

   Table_Decalage : constant
      array (Numero_Filtre_T)
      of Des_P.Clef_P.Clef_56_Abs_P.Decalage_T :=
      (0, 1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1, 0);

   type Cryptage_Abstrait_T is abstract
      new Filtre_Abstrait_T with null record;

end Des_P.Filtre_P.Cryptage_P;
