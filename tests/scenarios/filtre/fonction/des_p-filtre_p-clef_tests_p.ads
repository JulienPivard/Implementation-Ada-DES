with Des_P.Clef_P.Clef_64_Simplifie_P;

package Des_P.Filtre_P.Clef_Tests_P is

   --  Valeur attendu
   --  X0X1000X 0001011X 00110XXX 00XX100X
   --  1101100X 1111011X 1011110X 10X00X1X
   Contenu_Clef : constant
   Des_P.Clef_P.Clef_64_Simplifie_P.Tableau_Bits_T :=
      (
         False, False, True, True, False, True, True, True,
         False, False, True, True, True, False, False, True,
         True, True, False, False, True, False, False, True,
         True, True, True, False, False, True, True, True,
         True, False, True, True, True, True, False, True,
         True, False, True, False, False, True, True, True,
         True, True, False, True, False, False, True, True,
         True, False, False, False, True, True, True, True
      );

end Des_P.Filtre_P.Clef_Tests_P;
