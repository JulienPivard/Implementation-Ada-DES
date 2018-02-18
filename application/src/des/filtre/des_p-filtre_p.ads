with Des_P.Clef_P.Clef_56_Abs_P;
with Des_P.Bloc_P.Bloc_64_P;

--  @summary
--  Représentation abstraite des filtres de DES.
--  @description
--  Filtre abstrait qui va servir à paramétrer chaque étages de la chaine.
--  @group Filtre
package Des_P.Filtre_P is

   pragma Pure;

   --  Un filtre abstrait.
   type Filtre_Interface_T is interface;

   --  Filtre le bloc de 64 bits avec la clef de 56 bits.
   --  @param Filtre
   --  Le filtre.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Clef
   --  la clef de 56 bits.
   procedure Filtrer
      (
         Filtre : Filtre_Interface_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      )
   is abstract;

end Des_P.Filtre_P;
