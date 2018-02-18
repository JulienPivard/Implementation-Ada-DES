package Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Simple_P is

   type Clef_56_T is new Clef_56_Abs_T with private;

   overriding
   function Possede_Constructeur_48 (Clef : Clef_56_T) return Boolean;

   overriding
   procedure Decaler_Bits_A_Gauche
      (Clef : in out Clef_56_T; Nb_Decalage : Decalage_T := 1);

   overriding
   function Lire_Bit
      (Clef : Clef_56_T; Position : Intervalle_Clef_56_T)
      return Bit_T;

   overriding
   function Lire_Clef_48 (Clef : Clef_56_T)
      return Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T;

   overriding
   procedure Initialize (Clef : in out Clef_56_T);

   overriding
   procedure Finalize (Clef : in out Clef_56_T);

   overriding
   procedure Adjust (Clef : in out Clef_56_T);

private

   type Clef_56_T is new Clef_56_Abs_T with null record;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Simple_P;
