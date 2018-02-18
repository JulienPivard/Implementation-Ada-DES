with Des_P.Clef_P.Clef_56_Abs_P;
with Des_P.Bloc_P.Bloc_64_P;

package Des_P.Filtre_P.Filtre_Simple_P is

   pragma Pure;

   type Filtre_Simple_T is new Filtre_Interface_T with private;

   overriding
   procedure Filtrer
      (
         Filtre : Filtre_Simple_T;
         Bloc : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T;
         Clef : in out Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class
      );

private

   type Filtre_Simple_T is new Filtre_Interface_T with null record;

end Des_P.Filtre_P.Filtre_Simple_P;
