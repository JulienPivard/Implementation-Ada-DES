with Des_P.Clef_P.Clef_48_I_P;

package Des_P.Clef_P.Clef_48_Simplifie_P is

   pragma Pure;

   type Clef_S_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T with private;

   type Champ_De_Bits_T is array
      (Des_P.Clef_P.Clef_48_I_P.Intervalle_T) of Bit_T;

   procedure Init
      (
         Clef : out Clef_S_T;
         Champ : Champ_De_Bits_T
      );

   overriding
   function Lire_Bit
      (
         Clef : Clef_S_T;
         Position : Des_P.Clef_P.Clef_48_I_P.Intervalle_T
      )
      return Bit_T;

   overriding
   procedure Initialize
      (Clef : in out Clef_S_T);

   overriding
   procedure Finalize
      (Clef : in out Clef_S_T);

   overriding
   procedure Adjust
      (Clef : in out Clef_S_T);

private

   type Clef_S_T is new Clef_Abstrait_T and
      Des_P.Clef_P.Clef_48_I_P.Clef_Interface_T with
      record
         Bits : Champ_De_Bits_T;
      end record;

end Des_P.Clef_P.Clef_48_Simplifie_P;
