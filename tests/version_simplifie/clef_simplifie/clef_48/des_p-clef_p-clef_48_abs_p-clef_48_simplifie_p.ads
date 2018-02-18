package Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simplifie_P is

   pragma Pure;

   type Clef_48_Simplifie_T is new Clef_48_Abs_T with private;

   type Champ_De_Bits_T is array (Intervalle_Clef_48_T) of Bit_T;

   procedure Init
      (
         Clef : out Clef_48_Simplifie_T;
         Champ : Champ_De_Bits_T
      );

   overriding
   function Lire_Bit
      (
         Clef : Clef_48_Simplifie_T;
         Position : Intervalle_Clef_48_T
      )
      return Bit_T;

   overriding
   procedure Initialize (Clef : in out Clef_48_Simplifie_T);

   overriding
   procedure Finalize (Clef : in out Clef_48_Simplifie_T);

   overriding
   procedure Adjust (Clef : in out Clef_48_Simplifie_T);

private

   type Clef_48_Simplifie_T is new Clef_48_Abs_T with
      record
         Bits : Champ_De_Bits_T;
      end record;

end Des_P.Clef_P.Clef_48_Abs_P.Clef_48_Simplifie_P;
