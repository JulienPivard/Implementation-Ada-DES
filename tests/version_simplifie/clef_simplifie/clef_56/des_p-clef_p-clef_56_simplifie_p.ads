with Des_P.Clef_P.Clef_56_I_P;

package Des_P.Clef_P.Clef_56_Simplifie_P is

   type Clef_S_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T with private;

   type Champ_De_Bits_T is array
      (Des_P.Clef_P.Clef_56_I_P.Intervalle_T) of Bit_T;

   procedure Init
      (
         Clef : out Clef_S_T;
         Champ : Champ_De_Bits_T
      );

   overriding
   procedure Decaler_Bits_A_Gauche
      (
         Clef : in out Clef_S_T;
         Nb_Decalage : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 1
      );

   overriding
   procedure Decaler_Bits_A_Droite
      (
         Clef : in out Clef_S_T;
         Nb_Decalage : Des_P.Clef_P.Clef_56_I_P.Decalage_T := 1
      );

   overriding
   function Lire_Bit
      (
         Clef : Clef_S_T;
         Position : Des_P.Clef_P.Clef_56_I_P.Intervalle_T
      )
      return Bit_T;

   overriding
   procedure Initialize (Clef : in out Clef_S_T);

   overriding
   procedure Finalize (Clef : in out Clef_S_T);

   overriding
   procedure Adjust (Clef : in out Clef_S_T);

private

   type Clef_S_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T with
      record
         Champ : Champ_De_Bits_T;
      end record;

end Des_P.Clef_P.Clef_56_Simplifie_P;
